defmodule AnomaSDK.Arm.Test do
  @moduledoc """
  I define a few functions to test the ARM repo NIF interface.
  """

  mix_config = Mix.Project.config()
  version = mix_config[:version]
  github_url = mix_config[:package][:links]["GitHub"]

  use RustlerPrecompiled,
    otp_app: :anoma_sdk,
    crate: :arm_bindings_test,
    base_url: "#{github_url}/releases/download/v#{version}",
    version: "0.0.0",
    force_build: System.get_env("BUILD_NATIVE") in ["1", "true"],
    targets: Application.compile_env(:anoma_sdk, :targets)

  alias AnomaSDK.Arm.Action
  alias AnomaSDK.Arm.AppData
  alias AnomaSDK.Arm.Ciphertext
  alias AnomaSDK.Arm.ComplianceInstance
  alias AnomaSDK.Arm.ComplianceUnit
  alias AnomaSDK.Arm.ComplianceWitness
  alias AnomaSDK.Arm.DeltaProof
  alias AnomaSDK.Arm.DeltaWitness
  alias AnomaSDK.Arm.ExpirableBlob
  alias AnomaSDK.Arm.LogicVerifier
  alias AnomaSDK.Arm.LogicVerifierInputs
  alias AnomaSDK.Arm.MerklePath
  alias AnomaSDK.Arm.MerkleTree
  alias AnomaSDK.Arm.Resource
  alias AnomaSDK.Arm.Transaction

  # ----------------------------------------------------------------------------#
  #                                SecretKey                                    #
  # ----------------------------------------------------------------------------#

  @spec test_secret_key() :: binary()
  def test_secret_key, do: :erlang.nif_error(:nif_not_loaded)

  @spec test_secret_key(binary()) :: binary()
  def test_secret_key(_), do: :erlang.nif_error(:nif_not_loaded)

  # ----------------------------------------------------------------------------#
  #                                Ciphertext                                   #
  # ----------------------------------------------------------------------------#

  @spec test_cipher_text() :: Ciphertext.t()
  def test_cipher_text, do: :erlang.nif_error(:nif_not_loaded)

  @spec test_cipher_text(Ciphertext.t()) :: Ciphertext.t()
  def test_cipher_text(_), do: :erlang.nif_error(:nif_not_loaded)

  # ----------------------------------------------------------------------------#
  #                                ComplianceUnit                               #
  # ----------------------------------------------------------------------------#

  @spec test_compliance_unit() :: ComplianceUnit.t()
  def test_compliance_unit, do: :erlang.nif_error(:nif_not_loaded)

  @spec test_compliance_unit(ComplianceUnit.t()) :: ComplianceUnit.t()
  def test_compliance_unit(_), do: :erlang.nif_error(:nif_not_loaded)

  # ----------------------------------------------------------------------------#
  #                                ExpirableBlob                                #
  # ----------------------------------------------------------------------------#

  @spec test_expirable_blob() :: ExpirableBlob.t()
  def test_expirable_blob, do: :erlang.nif_error(:nif_not_loaded)

  @spec test_expirable_blob(ExpirableBlob.t()) :: ExpirableBlob.t()
  def test_expirable_blob(_), do: :erlang.nif_error(:nif_not_loaded)

  # ----------------------------------------------------------------------------#
  #                                AppData                                      #
  # ----------------------------------------------------------------------------#

  @spec test_app_data() :: AppData.t()
  def test_app_data, do: :erlang.nif_error(:nif_not_loaded)

  @spec test_app_data(AppData.t()) :: AppData.t()
  def test_app_data(_), do: :erlang.nif_error(:nif_not_loaded)

  # ----------------------------------------------------------------------------#
  #                                LogicVerifierInputs                          #
  # ----------------------------------------------------------------------------#

  @spec test_logic_verifier_inputs() :: LogicVerifierInputs.t()
  def test_logic_verifier_inputs, do: :erlang.nif_error(:nif_not_loaded)

  @spec test_logic_verifier_inputs(LogicVerifierInputs.t()) :: LogicVerifierInputs.t()
  def test_logic_verifier_inputs(_), do: :erlang.nif_error(:nif_not_loaded)

  # ----------------------------------------------------------------------------#
  #                                MerkleTree                                   #
  # ----------------------------------------------------------------------------#

  @spec test_merkle_tree :: MerkleTree.t()
  def test_merkle_tree, do: :erlang.nif_error(:nif_not_loaded)

  @spec test_merkle_tree(MerkleTree.t()) :: MerkleTree.t()
  def test_merkle_tree(_), do: :erlang.nif_error(:nif_not_loaded)

  # ----------------------------------------------------------------------------#
  #                                Action                                       #
  # ----------------------------------------------------------------------------#

  @spec test_action() :: Action.t()
  def test_action, do: :erlang.nif_error(:nif_not_loaded)

  @spec test_action(Action.t()) :: Action.t()
  def test_action(_), do: :erlang.nif_error(:nif_not_loaded)

  # ----------------------------------------------------------------------------#
  #                                MerklePath                                   #
  # ----------------------------------------------------------------------------#

  @spec test_merkle_path :: MerklePath.t()
  def test_merkle_path, do: :erlang.nif_error(:nif_not_loaded)

  @spec test_merkle_path(MerklePath.t()) :: MerklePath.t()
  def test_merkle_path(_), do: :erlang.nif_error(:nif_not_loaded)

  # ----------------------------------------------------------------------------#
  #                                ComplianceInstance                           #
  # ----------------------------------------------------------------------------#

  @spec test_compliance_instance() :: ComplianceInstance.t()
  def test_compliance_instance, do: :erlang.nif_error(:nif_not_loaded)

  @spec test_compliance_instance(ComplianceInstance.t()) :: ComplianceInstance.t()
  def test_compliance_instance(_), do: :erlang.nif_error(:nif_not_loaded)

  # ----------------------------------------------------------------------------#
  #                                ComplianceWitness                            #
  # ----------------------------------------------------------------------------#

  @spec test_compliance_witness :: ComplianceWitness.t()
  def test_compliance_witness, do: :erlang.nif_error(:nif_not_loaded)

  @spec test_compliance_witness(ComplianceWitness.t()) :: ComplianceWitness.t()
  def test_compliance_witness(_), do: :erlang.nif_error(:nif_not_loaded)

  # ----------------------------------------------------------------------------#
  #                                NullifierKeyCommitment                       #
  # ----------------------------------------------------------------------------#

  @spec test_nullifier_key_commitment :: {[byte()]}
  def test_nullifier_key_commitment, do: :erlang.nif_error(:nif_not_loaded)

  @spec test_nullifier_key_commitment({[byte()]}) :: [byte()]
  def test_nullifier_key_commitment(_), do: :erlang.nif_error(:nif_not_loaded)

  # ----------------------------------------------------------------------------#
  #                                NullifierKey                                 #
  # ----------------------------------------------------------------------------#

  @spec test_nullifier_key :: {[byte()]}
  def test_nullifier_key, do: :erlang.nif_error(:nif_not_loaded)

  @spec test_nullifier_key({[byte()]}) :: {[byte()]}
  def test_nullifier_key(_), do: :erlang.nif_error(:nif_not_loaded)

  # ----------------------------------------------------------------------------#
  #                                Resource                                     #
  # ----------------------------------------------------------------------------#

  @spec test_resource() :: Resource.t()
  def test_resource, do: :erlang.nif_error(:nif_not_loaded)

  @spec test_resource(Resource.t()) :: Resource.t()
  def test_resource(_), do: :erlang.nif_error(:nif_not_loaded)

  # ----------------------------------------------------------------------------#
  #                                DeltaProof                                   #
  # ----------------------------------------------------------------------------#

  @spec test_delta_proof() :: DeltaProof.t()
  def test_delta_proof, do: :erlang.nif_error(:nif_not_loaded)

  @spec test_delta_proof(DeltaProof.t()) :: DeltaProof.t()
  def test_delta_proof(_), do: :erlang.nif_error(:nif_not_loaded)

  # ----------------------------------------------------------------------------#
  #                                DeltaWitness                                 #
  # ----------------------------------------------------------------------------#

  @spec test_delta_witness() :: DeltaWitness.t()
  def test_delta_witness, do: :erlang.nif_error(:nif_not_loaded)

  @spec test_delta_witness(DeltaWitness.t()) :: DeltaWitness.t()
  def test_delta_witness(_), do: :erlang.nif_error(:nif_not_loaded)

  # ----------------------------------------------------------------------------#
  #                                LogicVerifier                                #
  # ----------------------------------------------------------------------------#

  @spec test_logic_verifier() :: LogicVerifier.t()
  def test_logic_verifier, do: :erlang.nif_error(:nif_not_loaded)

  @spec test_logic_verifier(LogicVerifier.t()) :: LogicVerifier.t()
  def test_logic_verifier(_), do: :erlang.nif_error(:nif_not_loaded)

  # ----------------------------------------------------------------------------#
  #                                Transaction                                  #
  # ----------------------------------------------------------------------------#

  @spec test_transaction() :: Transaction.t()
  def test_transaction, do: :erlang.nif_error(:nif_not_loaded)

  @spec test_transaction(Transaction.t()) :: Transaction.t()
  def test_transaction(_), do: :erlang.nif_error(:nif_not_loaded)

  # ----------------------------------------------------------------------------#
  #                                Delta                                        #
  # ----------------------------------------------------------------------------#

  @spec test_delta_with_proof({:proof, DeltaProof.t()}) :: {:proof, DeltaProof.t()}
  def test_delta_with_proof(_), do: :erlang.nif_error(:nif_not_loaded)

  @spec test_delta_with_proof() :: {:proof, DeltaProof.t()}
  def test_delta_with_proof, do: :erlang.nif_error(:nif_not_loaded)

  @spec test_delta_with_witness({:witness, DeltaWitness.t()}) :: {:witness, DeltaWitness.t()}
  def test_delta_with_witness(_), do: :erlang.nif_error(:nif_not_loaded)

  @spec test_delta_with_witness() :: {:witness, DeltaWitness.t()}
  def test_delta_with_witness, do: :erlang.nif_error(:nif_not_loaded)
end
