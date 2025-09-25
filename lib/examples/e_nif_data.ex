defmodule AnomaSDK.Examples.ENifData do
  @moduledoc """
  I provide examples for all NIF Data.

  Perhaps I should be split up to the proper modules where the data shows up in time
  """

  use ExUnit.Case

  alias AnomaSDK.Arm.Action
  alias AnomaSDK.Arm.AppData
  alias AnomaSDK.Arm.Ciphertext
  alias AnomaSDK.Arm.ComplianceUnit
  alias AnomaSDK.Arm.ComplianceWitness
  alias AnomaSDK.Arm.DeltaProof
  alias AnomaSDK.Arm.DeltaWitness
  alias AnomaSDK.Arm.ExpirableBlob
  alias AnomaSDK.Arm.Keypair
  alias AnomaSDK.Arm.LogicVerifier
  alias AnomaSDK.Arm.LogicVerifierInputs
  alias AnomaSDK.Arm.MerklePath
  alias AnomaSDK.Arm.MerkleTree
  alias AnomaSDK.Arm.NullifierKey
  alias AnomaSDK.Arm.NullifierKeyCommitment
  alias AnomaSDK.Arm.Resource
  alias AnomaSDK.Arm.Test
  alias AnomaSDK.Arm.Transaction
  alias AnomaSDK.Validate

  @spec roundtrip(term(), (term() -> term())) :: term()
  @spec roundtrip(term(), (term() -> term()), (term() -> term())) :: term()
  def roundtrip(data, decoder, validation \\ &Validate.valid?/1) do
    validation.(data)
    result = decoder.(data)
    assert result == data
    data
  end

  @spec nif_merkle_tree() :: MerkleTree.t()
  def nif_merkle_tree, do: roundtrip(Test.test_merkle_tree(), &Test.test_merkle_tree/1)

  @spec nif_secret_key() :: Keypair.t()
  def nif_secret_key,
    do: roundtrip(Test.test_secret_key(), &Test.test_secret_key/1, &Keypair.valid_secret?/1)

  @spec nif_cipher_text() :: Ciphertext.t()
  def nif_cipher_text,
    do: roundtrip(Test.test_cipher_text(), &Test.test_cipher_text/1, &Ciphertext.valid?/1)

  @spec nif_compliance_unit() :: ComplianceUnit.t()
  def nif_compliance_unit,
    do: roundtrip(Test.test_compliance_unit(), &Test.test_compliance_unit/1)

  @spec nif_expirable_blob() :: ExpirableBlob.t()
  def nif_expirable_blob,
    do: roundtrip(Test.test_expirable_blob(), &Test.test_expirable_blob/1)

  @spec nif_app_data() :: AppData.t()
  def nif_app_data, do: roundtrip(Test.test_app_data(), &Test.test_app_data/1)

  @spec nif_action() :: Action.t()
  def nif_action, do: roundtrip(Test.test_action(), &Test.test_action/1)

  @spec nif_logic_verifier_inputs() :: LogicVerifierInputs.t()
  def nif_logic_verifier_inputs,
    do: roundtrip(Test.test_logic_verifier_inputs(), &Test.test_logic_verifier_inputs/1)

  @spec nif_merkle_path() :: MerklePath.t()
  def nif_merkle_path,
    do: roundtrip(Test.test_merkle_path(), &Test.test_merkle_path/1, &MerklePath.valid?/1)

  @spec nif_compliance_instance() :: ComplianceUnit.t()
  def nif_compliance_instance,
    do: roundtrip(Test.test_compliance_instance(), &Test.test_compliance_instance/1)

  @spec nif_nullifier_key_commitment() :: NullifierKeyCommitment.t()
  def nif_nullifier_key_commitment,
    do:
      roundtrip(
        Test.test_nullifier_key_commitment(),
        &Test.test_nullifier_key_commitment/1,
        &NullifierKeyCommitment.valid?/1
      )

  @spec nif_nullifier_key() :: NullifierKey.t()
  def nif_nullifier_key,
    do: roundtrip(Test.test_nullifier_key(), &Test.test_nullifier_key/1, &NullifierKey.valid?/1)

  @spec nif_resource() :: Resource.t()
  def nif_resource, do: roundtrip(Test.test_resource(), &Test.test_resource/1)

  @spec nif_compliance_witness :: ComplianceWitness.t()
  def nif_compliance_witness,
    do: roundtrip(Test.test_compliance_witness(), &Test.test_compliance_witness/1)

  @spec nif_delta_proof :: DeltaProof.t()
  def nif_delta_proof, do: roundtrip(Test.test_delta_proof(), &Test.test_delta_proof/1)

  @spec nif_delta_witness :: DeltaWitness.t()
  def nif_delta_witness, do: roundtrip(Test.test_delta_witness(), &Test.test_delta_witness/1)

  @spec nif_logic_verifier :: LogicVerifier.t()
  def nif_logic_verifier,
    do: roundtrip(Test.test_logic_verifier(), &Test.test_logic_verifier/1)

  @spec nif_delta_with_witness :: {:witness, DeltaWitness.t()}
  def nif_delta_with_witness,
    do:
      roundtrip(
        Test.test_delta_with_witness(),
        &Test.test_delta_with_witness/1,
        &Transaction.valid_delta_proof?/1
      )

  @spec nif_delta_with_proof :: {:proof, DeltaProof.t()}
  def nif_delta_with_proof,
    do:
      roundtrip(
        Test.test_delta_with_proof(),
        &Test.test_delta_with_proof/1,
        &Transaction.valid_delta_proof?/1
      )

  @spec nif_transaction :: Transaction.t()
  def nif_transaction, do: roundtrip(Test.test_transaction(), &Test.test_transaction/1)
end
