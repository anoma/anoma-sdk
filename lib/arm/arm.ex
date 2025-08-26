defmodule Anoma.Arm.Test do
  @moduledoc """
  I define functions to deal with Anoma Resource Machine structs.
  """

  use Rustler,
    otp_app: :anoma_sdk,
    crate: :arm_test

  # alias Anoma.Arm.Action
  # alias Anoma.Arm.ComplianceInstance
  # alias Anoma.Arm.ComplianceUnit
  # alias Anoma.Arm.ComplianceWitness
  # alias Anoma.Arm.DeltaProof
  # alias Anoma.Arm.DeltaWitness
  # alias Anoma.Arm.ForwarderCalldata
  # alias Anoma.Arm.Leaf
  # alias Anoma.Arm.LogicVerifier
  # alias Anoma.Arm.MerklePath
  # alias Anoma.Arm.MerkleTree
  # alias Anoma.Arm.Resource
  # alias Anoma.Arm.Transaction
  # alias Anoma.Arm.TrivialLogicWitness

  #   @doc """
  #   Proves a compliance witness and returns a compliance unit.
  #   """
  #   @spec prove(ComplianceWitness.t()) :: ComplianceUnit.t()

  #   def prove(_), do: :erlang.nif_error(:nif_not_loaded)

  #   @doc """
  #   Proves a logic witness and returns a logic proof.
  #   """
  #   @spec prove_trivial_logic_witness(TrivialLogicWitness.t()) :: LogicVerifier.t()

  #   def prove_trivial_logic_witness(_), do: :erlang.nif_error(:nif_not_loaded)

  #   @doc """
  #   Returns the compliance instance for a given compliance unit.
  #   """
  #   @spec unit_instance(ComplianceUnit.t()) :: ComplianceInstance.t()
  #   def unit_instance(_), do: :erlang.nif_error(:nif_not_loaded)

  #   @doc """
  #   Proves the given deltawitness
  #   """
  #   @spec prove_delta_witness(DeltaWitness.t(), [byte()]) :: DeltaProof.t()
  #   def prove_delta_witness(_, _), do: :erlang.nif_error(:nif_not_loaded)

  # ----------------------------------------------------------------------------#
  #                                DeltaWitness                                 #
  # ----------------------------------------------------------------------------#

  @doc false
  @spec test_delta_witness() :: DeltaWitness.t()
  def test_delta_witness, do: :erlang.nif_error(:nif_not_loaded)

  @doc false
  @spec test_delta_witness(DeltaWitness.t()) :: DeltaWitness.t()
  def test_delta_witness(_), do: :erlang.nif_error(:nif_not_loaded)

  # ----------------------------------------------------------------------------#
  #                                Delta                                        #
  # ----------------------------------------------------------------------------#

  @doc false
  @spec test_delta_with_proof({:proof, DeltaProof.t()}) :: {:proof, DeltaProof.t()}
  def test_delta_with_proof(_), do: :erlang.nif_error(:nif_not_loaded)

  @doc false
  @spec test_delta_with_proof() :: {:proof, DeltaProof.t()}
  def test_delta_with_proof, do: :erlang.nif_error(:nif_not_loaded)

  @doc false
  @spec test_delta_with_witness({:witness, DeltaWitness.t()}) :: {:witness, DeltaWitness.t()}
  def test_delta_with_witness(_), do: :erlang.nif_error(:nif_not_loaded)

  @doc false
  @spec test_delta_with_witness() :: {:witness, DeltaWitness.t()}
  def test_delta_with_witness, do: :erlang.nif_error(:nif_not_loaded)

  # ----------------------------------------------------------------------------#
  #                                ComplianceInstance                           #
  # ----------------------------------------------------------------------------#

  @doc false
  @spec test_compliance_instance() :: ComplianceInstance.t()
  def test_compliance_instance, do: :erlang.nif_error(:nif_not_loaded)

  @doc false
  @spec test_compliance_instance(ComplianceInstance.t()) :: ComplianceInstance.t()
  def test_compliance_instance(_), do: :erlang.nif_error(:nif_not_loaded)

  # ----------------------------------------------------------------------------#
  #                                ComplianceUnit                               #
  # ----------------------------------------------------------------------------#

  @doc false
  @spec test_compliance_unit() :: ComplianceUnit.t()
  def test_compliance_unit, do: :erlang.nif_error(:nif_not_loaded)

  @doc false
  @spec test_compliance_unit(ComplianceUnit.t()) :: ComplianceUnit.t()
  def test_compliance_unit(_), do: :erlang.nif_error(:nif_not_loaded)

  # ----------------------------------------------------------------------------#
  #                                MerklePath                                   #
  # ----------------------------------------------------------------------------#

  @doc false
  @spec test_merkle_path :: MerklePath.t()
  def test_merkle_path, do: :erlang.nif_error(:nif_not_loaded)

  @doc false
  @spec test_merkle_path(MerklePath.t()) :: MerklePath.t()
  def test_merkle_path(_), do: :erlang.nif_error(:nif_not_loaded)

  # ----------------------------------------------------------------------------#
  #                                MerkleTree                                   #
  # ----------------------------------------------------------------------------#

  @doc false
  @spec test_merkle_tree :: MerkleTree.t()
  def test_merkle_tree, do: :erlang.nif_error(:nif_not_loaded)

  @doc false
  @spec test_merkle_tree(MerkleTree.t()) :: MerkleTree.t()
  def test_merkle_tree(_), do: :erlang.nif_error(:nif_not_loaded)

  # ----------------------------------------------------------------------------#
  #                                ComplianceWitness                            #
  # ----------------------------------------------------------------------------#

  @doc false
  @spec test_compliance_witness :: ComplianceWitness.t()
  def test_compliance_witness, do: :erlang.nif_error(:nif_not_loaded)

  @doc false
  @spec test_compliance_witness(ComplianceWitness.t()) :: ComplianceWitness.t()
  def test_compliance_witness(_), do: :erlang.nif_error(:nif_not_loaded)

  # ----------------------------------------------------------------------------#
  #                                Resource                                     #
  # ----------------------------------------------------------------------------#

  @doc false
  @spec test_resource() :: Resource.t()
  def test_resource, do: :erlang.nif_error(:nif_not_loaded)

  @doc false
  @spec test_resource(Resource.t()) :: Resource.t()
  def test_resource(_), do: :erlang.nif_error(:nif_not_loaded)

  # ----------------------------------------------------------------------------#
  #                                LogicVerifier                                #
  # ----------------------------------------------------------------------------#

  @doc false
  @spec test_logic_verifier() :: LogicVerifier.t()
  def test_logic_verifier, do: :erlang.nif_error(:nif_not_loaded)

  @doc false
  @spec test_logic_verifier(LogicVerifier.t()) :: LogicVerifier.t()
  def test_logic_verifier(_), do: :erlang.nif_error(:nif_not_loaded)

  # ----------------------------------------------------------------------------#
  #                                Action                                       #
  # ----------------------------------------------------------------------------#

  @doc false
  @spec test_action() :: Action.t()
  def test_action, do: :erlang.nif_error(:nif_not_loaded)

  @doc false
  @spec test_action(Action.t()) :: Action.t()
  def test_action(_), do: :erlang.nif_error(:nif_not_loaded)

  # ----------------------------------------------------------------------------#
  #                                Transaction                                  #
  # ----------------------------------------------------------------------------#

  @doc false
  @spec test_transaction() :: Transaction.t()
  def test_transaction, do: :erlang.nif_error(:nif_not_loaded)

  @doc false
  @spec test_transaction(Transaction.t()) :: Transaction.t()
  def test_transaction(_), do: :erlang.nif_error(:nif_not_loaded)

  # ----------------------------------------------------------------------------#
  #                                NullifierKey                                 #
  # ----------------------------------------------------------------------------#

  @doc false
  @spec test_nullifier_key :: {[byte()]}
  def test_nullifier_key, do: :erlang.nif_error(:nif_not_loaded)

  @doc false
  @spec test_nullifier_key({[byte()]}) :: {[byte()]}
  def test_nullifier_key(_), do: :erlang.nif_error(:nif_not_loaded)

  # ----------------------------------------------------------------------------#
  #                                ComplianceWitness                            #
  # ----------------------------------------------------------------------------#

  #   @spec test_delta_proof() :: DeltaProof.t()
  #   @spec test_delta_proof(DeltaProof.t()) :: DeltaProof.t()

  #   @doc false
  #   def test_delta_proof, do: :erlang.nif_error(:nif_not_loaded)

  #   @spec test_forwarder_calldata() :: ForwarderCalldata.t()
  #   @spec test_forwarder_calldata(ForwarderCalldata.t()) :: ForwarderCalldata.t()

  #   @doc false
  #   def test_forwarder_calldata, do: :erlang.nif_error(:nif_not_loaded)

  #   @doc false
  #   def test_forwarder_calldata(_), do: :erlang.nif_error(:nif_not_loaded)

  #   @spec test_nullifier_key_commitment :: {[byte()]}
  #   @spec test_nullifier_key_commitment({[byte()]}) :: [byte()]

  #   @doc false
  #   def test_nullifier_key_commitment, do: :erlang.nif_error(:nif_not_loaded)

  #   @doc false
  #   def test_nullifier_key_commitment(_), do: :erlang.nif_error(:nif_not_loaded)

  #   @spec test_leaf :: Leaf.t()
  #   @spec test_leaf(Leaf.t()) :: Leaf.t()

  #   @doc false
  #   def test_leaf, do: :erlang.nif_error(:nif_not_loaded)

  #   @doc false
  #   def test_leaf(_), do: :erlang.nif_error(:nif_not_loaded)

  #   @spec test_trivial_logic_witness :: TrivialLogicWitness.t()
  #   @spec test_trivial_logic_witness(TrivialLogicWitness.t()) :: TrivialLogicWitness.t()

  #   @doc false
  #   def test_trivial_logic_witness, do: :erlang.nif_error(:nif_not_loaded)

  #   @doc false
  #   def test_trivial_logic_witness(_), do: :erlang.nif_error(:nif_not_loaded)

  #   @spec test :: term()
  #   @spec test(term()) :: term()

  #   @doc false
  #   def test, do: :erlang.nif_error(:nif_not_loaded)

  #   @doc false
  #   def test(_), do: :erlang.nif_error(:nif_not_loaded)
end
