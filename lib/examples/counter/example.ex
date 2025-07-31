defmodule Anoma.Examples.Counter.Example do
  alias Anoma.Arm
  alias Anoma.Arm.Action
  alias Anoma.Arm.ComplianceUnit
  alias Anoma.Arm.ComplianceWitness
  alias Anoma.Arm.DeltaWitness
  alias Anoma.Arm.MerklePath
  alias Anoma.Arm.MerkleTree
  alias Anoma.Arm.NullifierKey
  alias Anoma.Arm.Resource
  alias Anoma.Arm.Transaction
  alias Anoma.Examples.Counter
  alias Anoma.Examples.Counter.CounterLogic
  alias Anoma.Examples.Counter.CounterWitness
  alias Anoma.Util

  import Anoma.Util

  @doc """
  Create a new counter.
  """
  @spec create_counter :: {Resource.t(), NullifierKey.t()}
  def create_counter() do
    nullifier_key = NullifierKey.default()
    nullifier_key_commitment = NullifierKey.commit(nullifier_key)

    # Create a counter resource
    # the label for each counter is unique.
    resource = %Resource{
      logic_ref: Counter.counter_logic_ref(),
      label_ref: Util.bin2binlist(:crypto.strong_rand_bytes(32)),
      quantity: 1,
      value_ref: Util.pad_bitstring(<<1>>, 32) |> Util.bin2binlist(),
      is_ephemeral: true,
      nk_commitment: nullifier_key_commitment
    }

    {resource, nullifier_key}
  end

  @doc """
  Create an ephemeral counter based on the created counter.
  """
  @spec create_consumed_counter(Resource.t()) :: {Resource.t(), NullifierKey.t()}
  def create_consumed_counter(counter) do
    nullifier_key = NullifierKey.default()
    nullifier_key_commitment = NullifierKey.commit(nullifier_key)

    resource = %{
      counter
      | is_ephemeral: true,
        label_ref: Util.bin2binlist(:crypto.strong_rand_bytes(32)),
        value_ref: Util.pad_bitstring(<<1>>, 32) |> Util.bin2binlist(),
        nk_commitment: nullifier_key_commitment
    }

    {resource, nullifier_key}
  end

  @doc """
  Creates the compliance proof for a created and consumed counter.
  """
  @spec create_compliance_proof(Resource.t(), NullifierKey.t(), Resource.t()) ::
          {ComplianceUnit.t(), [byte()]}
  def create_compliance_proof(consumed_counter, consumed_nf, created_counter) do
    compliance_witness =
      ComplianceWitness.from_resources_with_path(
        consumed_counter,
        consumed_nf,
        MerklePath.default(),
        created_counter
      )

    # prove the compliance unit
    unit = Arm.prove(compliance_witness)
    {unit, compliance_witness.rcv}
  end

  @doc """
  Creates a proof for the given consumed and created logics.
  """
  @spec create_logic_proofs(Resource.t(), NullifierKey.t(), Resource.t()) :: term()
  def create_logic_proofs(consumed, consumed_nf_key, created) do
    # create the logic proofs
    consumed_counter_nf = Resource.nullifier(consumed, consumed_nf_key)
    created_counter_cm = Resource.commitment(created)

    action_tree =
      MerkleTree.new([
        {consumed_counter_nf},
        {created_counter_cm}
      ])

    # create the path of the nullifier and commitments in the action tree.
    consumed_resource_path = MerkleTree.path_of(action_tree, {consumed_counter_nf})
    created_resource_path = MerkleTree.path_of(action_tree, {created_counter_cm})

    # counter logic for consumed resource
    consumed_counter_logic = %CounterLogic{
      witness: %CounterWitness{
        is_consumed: true,
        old_counter: consumed,
        old_counter_existence_path: consumed_resource_path,
        nf_key: {consumed_counter_nf},
        new_counter: created,
        new_counter_existence_path: created_resource_path
      }
    }

    consumed_logic_proof = Counter.prove_counter_logic(consumed_counter_logic)

    # create a proof for the created resource
    created_counter_logic = %CounterLogic{
      witness: %{consumed_counter_logic.witness | is_consumed: false}
    }

    created_logic_proof = Counter.prove_counter_logic(created_counter_logic)

    {consumed_logic_proof, created_logic_proof}
  end

  def create_counter_transaction() do
    # create a new counter resource
    {created_counter, create_nf} = create_counter()

    # create an ephemeral counter resource
    {consumed_counter, ephemeral_nf} = create_consumed_counter(created_counter)

    {compliance_unit, rcv} =
      create_compliance_proof(consumed_counter, ephemeral_nf, created_counter)

    {consumed_logic_proof, created_logic_proof} =
      create_logic_proofs(consumed_counter, ephemeral_nf, created_counter)

    # create an action for this transaction
    action = %Action{
      compliance_units: [compliance_unit],
      logic_proofs: [consumed_logic_proof, created_logic_proof],
      resource_forwarder_calldata_pairs: []
    }

    delta_witness = %DeltaWitness{signing_key: binlist2bin(rcv)}

    transaction = %Transaction{
      actions: [action],
      delta_proof: {:witness, delta_witness}
    }

    # generate the delta proof for the transaction
    Transaction.generate_delta_proof(transaction)
  end
end
