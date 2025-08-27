defmodule Anoma.Arm.Test do
  @moduledoc """
  I define a few functions to test the ARM repo NIF interface.
  """

  use Rustler,
    otp_app: :anoma_sdk,
    crate: :arm_test

  alias Anoma.Arm.Action
  alias Anoma.Arm.ComplianceInstance
  alias Anoma.Arm.ComplianceUnit
  alias Anoma.Arm.ComplianceWitness
  alias Anoma.Arm.DeltaProof
  alias Anoma.Arm.DeltaWitness
  alias Anoma.Arm.ExpirableBlob
  alias Anoma.Arm.LogicVerifier
  alias Anoma.Arm.LogicVerifierInputs
  alias Anoma.Arm.MerklePath
  alias Anoma.Arm.MerkleTree
  alias Anoma.Arm.Resource
  alias Anoma.Arm.Transaction

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
  #                                NullifierKeyCommitment                       #
  # ----------------------------------------------------------------------------#

  @doc false
  @spec test_nullifier_key_commitment :: {[byte()]}
  def test_nullifier_key_commitment, do: :erlang.nif_error(:nif_not_loaded)

  @doc false
  @spec test_nullifier_key_commitment({[byte()]}) :: [byte()]
  def test_nullifier_key_commitment(_), do: :erlang.nif_error(:nif_not_loaded)

  # ----------------------------------------------------------------------------#
  #                                DeltaProof                                   #
  # ----------------------------------------------------------------------------#

  @doc false
  @spec test_delta_proof() :: DeltaProof.t()
  def test_delta_proof, do: :erlang.nif_error(:nif_not_loaded)
  @doc false
  @spec test_delta_proof(DeltaProof.t()) :: DeltaProof.t()
  def test_delta_proof(_), do: :erlang.nif_error(:nif_not_loaded)

  # ----------------------------------------------------------------------------#
  #                                ExpirableBlob                                #
  # ----------------------------------------------------------------------------#

  @doc false
  @spec test_expirable_blob() :: ExpirableBlob.t()
  def test_expirable_blob, do: :erlang.nif_error(:nif_not_loaded)

  @doc false
  @spec test_expirable_blob(ExpirableBlob.t()) :: ExpirableBlob.t()
  def test_expirable_blob(_), do: :erlang.nif_error(:nif_not_loaded)

  # ----------------------------------------------------------------------------#
  #                                AppData                                      #
  # ----------------------------------------------------------------------------#

  @doc false
  @spec test_app_data() :: AppData.t()
  def test_app_data, do: :erlang.nif_error(:nif_not_loaded)

  @doc false
  @spec test_app_data(AppData.t()) :: AppData.t()
  def test_app_data(_), do: :erlang.nif_error(:nif_not_loaded)

  # ----------------------------------------------------------------------------#
  #                                LogicVerifierInputs                          #
  # ----------------------------------------------------------------------------#

  @doc false
  @spec test_logic_verifier_inputs() :: LogicVerifierInputs.t()
  def test_logic_verifier_inputs, do: :erlang.nif_error(:nif_not_loaded)

  @doc false
  @spec test_logic_verifier_inputs(LogicVerifierInputs.t()) :: LogicVerifierInputs.t()
  def test_logic_verifier_inputs(_), do: :erlang.nif_error(:nif_not_loaded)

  # ----------------------------------------------------------------------------#
  #                                LogicVerifier                                #
  # ----------------------------------------------------------------------------#

  @doc false
  @spec test_logic_verifier() :: LogicVerifier.t()
  def test_logic_verifier, do: :erlang.nif_error(:nif_not_loaded)

  @doc false
  @spec test_logic_verifier(LogicVerifier.t()) :: LogicVerifier.t()
  def test_logic_verifier(_), do: :erlang.nif_error(:nif_not_loaded)
end
