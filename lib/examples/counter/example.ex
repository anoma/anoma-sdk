defmodule Anoma.Examples.Counter.Example do
  @moduledoc """
  Example showing how to create counter transactions to initialize a counter.
  """
  alias Anoma.Arm
  alias Anoma.Arm.Action
  alias Anoma.Arm.ComplianceUnit
  alias Anoma.Arm.ComplianceWitness
  alias Anoma.Arm.DeltaWitness
  alias Anoma.Arm.MerklePath
  alias Anoma.Arm.MerkleTree
  alias Anoma.Arm.NullifierKey
  alias Anoma.Arm.Resource
  alias Anoma.Arm.Transacttion
  alias Anoma.Examples.Counter
  alias Anoma.Examples.Counter.CounterLogic
  alias Anoma.Examples.Counter.CounterWitness
  alias Anoma.Util

  import Anoma.Util

  @doc """
  Create a new ephemeral counter.
  """
  @spec create_counter :: {Resource.t(), NullifierKey.t()}
  def create_counter do
    nullifier_key = NullifierKey.default()
    nullifier_key_commitment = NullifierKey.commit(nullifier_key)

    # Create a counter resource
    resource = %Resource{
      logic_ref: Counter.counter_logic_ref(),
      label_ref: Util.randombinlist(32),
      quantity: 1,
      value_ref: Util.bin2binlist(Util.pad_bitstring(<<0>>, 32)),
      is_ephemeral: true,
      nonce: Util.randombinlist(32),
      nk_commitment: nullifier_key_commitment
    }

    {resource, nullifier_key}
  end

  @doc """
  Create an ephemeral counter based on the created counter.
  """
  @spec create_counter(Resource.t(), NullifierKey.t()) :: {Resource.t(), NullifierKey.t()}
  def create_counter(created_counter, created_counter_nf_key) do
    {nullifier_key, nullifier_key_commitment} = NullifierKey.random_pair()

    nonce = Resource.nullifier(created_counter, created_counter_nf_key)

    resource = %{
      created_counter
      | is_ephemeral: false,
        rand_seed: Util.randombinlist(32),
        nonce: nonce,
        value_ref: Util.bin2binlist(Util.pad_bitstring(<<1>>, 32)),
        nk_commitment: nullifier_key_commitment
    }

    {resource, nullifier_key}
  end

  @doc """
  Generate a compliance proof for two resources.
  """
  @spec generate_compliance_proof(Resource.t(), NullifierKey.t(), MerklePath.t(), Resource.t()) ::
          ComplianceUnit.t()
  def generate_compliance_proof(consumed, consumed_nf, merkle_path, created) do
    compliance_witness =
      ComplianceWitness.from_resources_with_path(consumed, consumed_nf, merkle_path, created)

    compliance_unit = Arm.prove(compliance_witness)

    {compliance_unit, compliance_witness.rcv}
  end

  @doc """
  Generate the logic proofs for the given resources.
  """
  @spec generate_logic_proofs(Resource.t(), NullifierKey.t(), Resource.t()) ::
          {LogicProof.t(), LogicProof.t()}
  def generate_logic_proofs(consumed, consumed_nf, created) do
    nullifier = Resource.nullifier(consumed, consumed_nf)
    commitment = Resource.commitment(created)

    action_tree =
      MerkleTree.new([
        {nullifier},
        {commitment}
      ])

    # create the path of the nullifier and commitments in the action tree.
    consumed_resource_path = MerkleTree.path_of(action_tree, {nullifier})
    created_resource_path = MerkleTree.path_of(action_tree, {commitment})

    # counter logic for consumed resource
    consumed_counter_logic = %CounterLogic{
      witness: %CounterWitness{
        is_consumed: true,
        old_counter: consumed,
        old_counter_existence_path: consumed_resource_path,
        nf_key: consumed_nf,
        new_counter: created,
        new_counter_existence_path: created_resource_path
      }
    }

    # generate the proof for the consumed counter
    consumed_logic_proof = Counter.prove_counter_logic(consumed_counter_logic)

    # create a proof for the created counter
    created_counter_logic = %CounterLogic{
      witness: %{consumed_counter_logic.witness | is_consumed: false}
    }

    created_logic_proof = Counter.prove_counter_logic(created_counter_logic)

    {consumed_logic_proof, created_logic_proof}
  end

  @doc """
  Creates a counter initialize transaction.
  """
  @spec create_counter_transaction :: Transacttion.t()
  def create_counter_transaction do
    # create a new counter resource
    {ephemeral_counter, ephemeral_counter_nf} = create_counter()

    {created_counter, created_counter_nf} =
      create_counter(ephemeral_counter, ephemeral_counter_nf)

    # generate the compliance proofs for the transaction
    {compliance_unit, rcv} =
      generate_compliance_proof(
        ephemeral_counter,
        ephemeral_counter_nf,
        MerklePath.default(),
        created_counter
      )

    {consumed_logic_proof, created_logic_proof} =
      generate_logic_proofs(ephemeral_counter, ephemeral_counter_nf, created_counter)

    # create an action for this transaction
    action = %Action{
      compliance_units: [compliance_unit],
      logic_proofs: [consumed_logic_proof, created_logic_proof],
      resource_forwarder_calldata_pairs: []
    }

    delta_witness = %DeltaWitness{signing_key: binlist2bin(rcv)}

    transaction = %Transacttion{
      actions: [action],
      delta_proof: {:witness, delta_witness}
    }

    # generate the delta proof for the transaction
    Transacttion.generate_delta_proof(transaction)
  end
end
