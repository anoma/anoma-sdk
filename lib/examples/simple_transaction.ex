defmodule Anoma.Examples.SimpleTransaction do
  @moduledoc """
  I define some examples on how to create a simple transaction, actions, and all
  the necessary parts.
  """

  alias Anoma.Arm.Action
  alias Anoma.Arm.ComplianceWitness
  alias Anoma.Arm.DeltaWitness
  alias Anoma.Arm.MerkleTree
  alias Anoma.Arm.NullifierKey
  alias Anoma.Arm.Resource
  alias Anoma.Arm.Transaction
  alias Anoma.Arm.TrivialLogicWitness
  alias Anoma.Util

  import Anoma.Arm.Constants

  @doc """
  I create a simple action with the given nonce.
  """
  @spec create_action([byte()]) :: {Action.t(), DeltaWitness.t()}
  def create_action(nonce) do
    nullifier_key =
      NullifierKey.default()

    nullifier_key_commitment = NullifierKey.commit(nullifier_key)

    # create a resource to consume.
    # the resource logic of this resource is
    consumed = %Resource{
      logic_ref: test_guest_id(),
      nk_commitment: nullifier_key_commitment,
      label_ref: List.duplicate(0, 32),
      quantity: 0,
      value_ref: List.duplicate(0, 32),
      is_ephemeral: true,
      nonce: nonce,
      rand_seed: List.duplicate(0, 32)
    }

    # the consumed resource is the same as the created one.
    created_nonce = Enum.take(consumed.nonce, 10) ++ Enum.take(consumed.nonce, 22)
    created = %{consumed | nonce: created_nonce}

    # the nonce of the created resource is the first 10 bytes of the consumed
    # appended with the first 22 bytes of the nonce.

    # the compliance witness is the input for the prover. when the compliance
    # witness is proved, the result is compliance unit, and serves as proof
    # that the compliance was correct.
    # this proof attests that:
    # -
    compliance_witness = ComplianceWitness.with_fixed_rcv(consumed, nullifier_key, created)

    compliance_receipt = Anoma.Arm.prove(compliance_witness)

    # create the nullifiers for the consumed resources
    consumed_resource_nf = Resource.nullifier(consumed, nullifier_key)

    # create the commitment for the created resources
    created_resource_cm = Resource.commitment(created)

    # the action tree is a merkle tree with the nullifiers and commitments their bytes.

    action_tree =
      MerkleTree.new([
        {consumed_resource_nf},
        {created_resource_cm}
      ])

    # create the path of the nullifier and commitments in the action tree.
    consumed_resource_path = MerkleTree.path_of(action_tree, {consumed_resource_nf})
    created_resource_path = MerkleTree.path_of(action_tree, {created_resource_cm})

    # create the consumed resource logic witness
    consumed_logic_witness =
      TrivialLogicWitness.new(
        consumed,
        consumed_resource_path,
        nullifier_key,
        true
      )

    # create a proof for the consumed resource logic
    consumed_logic_proof = Anoma.Arm.prove_trivial_logic_witness(consumed_logic_witness)

    # create the created resource logic witness
    created_logic_witness =
      TrivialLogicWitness.new(created, created_resource_path, nullifier_key, false)

    # prove the created logic witness
    created_logic_proof = Anoma.Arm.prove_trivial_logic_witness(created_logic_witness)

    # create the compliance units list
    compliance_units = [compliance_receipt]

    logic_proofs = [consumed_logic_proof, created_logic_proof]

    resource_forwarder_calldata_pairs = []

    action = %Action{
      compliance_units: compliance_units,
      logic_proofs: logic_proofs,
      resource_forwarder_calldata_pairs: resource_forwarder_calldata_pairs
    }

    # create a delta witness for this action
    signing_key = Util.binlist2bin(compliance_witness.rcv)
    delta_witness = %DeltaWitness{signing_key: signing_key}

    {action, delta_witness}
  end

  @doc """
  I create `count` actions.
  """
  @spec create_actions(non_neg_integer()) :: {[Action.t()], DeltaWitness.t()}
  def create_actions(count) do
    actions_and_witnesses =
      for i <- 0..(count - 1) do
        nonce = [i | List.duplicate(0, 31)]
        create_action(nonce)
      end

    # extract the actions from the tuple
    actions = Enum.map(actions_and_witnesses, fn {action, _} -> action end)

    # compress the delta witnesses into 1
    compressed_witness =
      actions_and_witnesses
      |> Enum.map(fn {_, witness} -> witness end)
      |> DeltaWitness.compress()

    {actions, compressed_witness}
  end

  def create_transaction(action_count) do
    # create the actions
    {actions, witness} = create_actions(action_count)
    # create an unproved transaction
    transaction = %Transaction{
      actions: actions,
      delta_proof: {:witness, witness}
    }

    # prove the transactions' delta witness
    transaction = Transaction.generate_delta_proof(transaction)

    transaction
  end
end
