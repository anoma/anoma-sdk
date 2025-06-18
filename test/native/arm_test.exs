defmodule Anoma.Test.Native.ArmTest do
  @moduledoc """
  This module tests the test NIF bindings from the `native/arm_test` repo.

  It's goal is to ensure that data structures are serialized properly back and
  forth between Rust and Elixir.
  """
  use ExUnit.Case

  alias Anoma.Arm.Action
  alias Anoma.Arm.AppData
  alias Anoma.Arm.ComplianceInstance
  alias Anoma.Arm.ComplianceUnit
  alias Anoma.Arm.ComplianceWitness
  alias Anoma.Arm.ExpirableBlob
  alias Anoma.Arm.Keypair
  alias Anoma.Arm.LogicVerifier
  alias Anoma.Arm.LogicVerifierInputs
  alias Anoma.Arm.MerkleTree
  alias Anoma.Arm.Resource
  alias Anoma.Arm.Test

  test "verify ciphertext encrypt and decrypt" do
    # generate a keypair to encrypt a cipher
    sender_keypair = Anoma.Arm.random_key_pair()
    receiver_keypair = Anoma.Arm.random_key_pair()
    # data to encrypt
    cipher = :crypto.strong_rand_bytes(32)
    # nonce
    nonce = :crypto.strong_rand_bytes(12)

    encrypted =
      Anoma.Arm.encrypt_cipher(
        :binary.bin_to_list(cipher),
        %Keypair{secret_key: sender_keypair.secret_key, public_key: receiver_keypair.public_key},
        :binary.bin_to_list(nonce)
      )

    Anoma.Arm.decrypt_cipher(:binary.bin_to_list(encrypted), receiver_keypair)
  end

  # ----------------------------------------------------------------------------#
  #                                SecretKey                                   #
  # ----------------------------------------------------------------------------#

  defp verify_secret_key_types(secret_key) do
    assert is_binary(secret_key)
  end

  describe "secret key" do
    test "test_secret_key/0" do
      secret_key = Test.test_secret_key()
      verify_secret_key_types(secret_key)
    end

    test "test_secret_key/1" do
      secret_key = Test.test_secret_key()
      secret_key_return = Test.test_secret_key(secret_key)
      verify_secret_key_types(secret_key_return)
    end
  end

  # ----------------------------------------------------------------------------#
  #                                Ciphertext                                   #
  # ----------------------------------------------------------------------------#

  defp verify_cipher_text_types(cipher_text) do
    assert is_binary(cipher_text)
  end

  describe "cipher text" do
    test "test_cipher_text/0" do
      cipher_text = Test.test_cipher_text()
      verify_cipher_text_types(cipher_text)
    end

    test "test_compliance_unit/1" do
      cipher_text = Test.test_cipher_text()
      cipher_text_return = Test.test_cipher_text(cipher_text)
      verify_cipher_text_types(cipher_text_return)
    end
  end

  # ----------------------------------------------------------------------------#
  #                                ComplianceUnit                               #
  # ----------------------------------------------------------------------------#

  defp verify_compliance_unit_types(compliance_unit) do
    assert %ComplianceUnit{} = compliance_unit
    assert is_binary(compliance_unit.instance)
    assert is_binary(compliance_unit.proof)
  end

  describe "compliance unit" do
    test "test_compliance_unit/0" do
      compliance_unit = Test.test_compliance_unit()
      verify_compliance_unit_types(compliance_unit)
    end

    test "test_compliance_unit/1" do
      compliance_unit = Test.test_compliance_unit()
      compliance_unit_return = Test.test_compliance_unit(compliance_unit)

      assert compliance_unit == compliance_unit_return

      verify_compliance_unit_types(compliance_unit_return)
    end
  end

  # ----------------------------------------------------------------------------#
  #                                ExpirableBlob                                #
  # ----------------------------------------------------------------------------#

  defp verify_expirable_blob_types(expirable_blob) do
    assert %ExpirableBlob{} = expirable_blob
    assert is_binary(expirable_blob.blob)
    assert is_number(expirable_blob.deletion_criteria)
  end

  describe "expirable blob" do
    test "expirable_blob/0" do
      expirable_blob = Test.test_expirable_blob()

      verify_expirable_blob_types(expirable_blob)
    end

    test "expirable_blob/1" do
      expirable_blob = Test.test_expirable_blob()
      expirable_blob_return = Test.test_expirable_blob(expirable_blob)

      assert expirable_blob == expirable_blob_return
      verify_expirable_blob_types(expirable_blob_return)
    end
  end

  # ----------------------------------------------------------------------------#
  #                                AppData                                      #
  # ----------------------------------------------------------------------------#

  defp verify_app_data_types(app_data) do
    assert %AppData{} = app_data
    assert is_list(app_data.resource_payload)
    Enum.each(app_data.resource_payload, &verify_expirable_blob_types/1)

    assert is_list(app_data.discovery_payload)
    Enum.each(app_data.discovery_payload, &verify_expirable_blob_types/1)

    assert is_list(app_data.external_payload)
    Enum.each(app_data.external_payload, &verify_expirable_blob_types/1)

    assert is_list(app_data.application_payload)
    Enum.each(app_data.application_payload, &verify_expirable_blob_types/1)
  end

  describe "app data" do
    test "app_data/0" do
      app_data = Test.test_app_data()

      verify_app_data_types(app_data)
    end

    test "app_data/1" do
      app_data = Test.test_app_data()
      app_data_return = Test.test_app_data(app_data)

      assert app_data == app_data_return

      verify_app_data_types(app_data_return)
    end
  end

  # ----------------------------------------------------------------------------#
  #                                Action                                       #
  # ----------------------------------------------------------------------------#

  defp verify_action_types(action) do
    assert %Action{} = action
    assert is_list(action.compliance_units)
    Enum.each(action.compliance_units, &verify_compliance_unit_types/1)

    assert is_list(action.logic_verifier_inputs)
    Enum.each(action.logic_verifier_inputs, &verify_logic_verifier_inputs_types/1)
  end

  describe "action" do
    test "test_action/0" do
      action = Test.test_action()

      verify_action_types(action)
    end

    test "test_action/1" do
      action = Test.test_action()
      action_return = Test.test_action(action)
      assert action == action_return

      verify_action_types(action_return)
    end
  end

  # ----------------------------------------------------------------------------#
  #                                LogicVerifierInputs                          #
  # ----------------------------------------------------------------------------#

  defp verify_logic_verifier_inputs_types(logic_verifier_inputs) do
    assert %LogicVerifierInputs{} = logic_verifier_inputs
    assert is_binary(logic_verifier_inputs.tag)
    assert is_binary(logic_verifier_inputs.verifying_key)
    verify_app_data_types(logic_verifier_inputs.app_data)
    assert is_binary(logic_verifier_inputs.proof)
  end

  describe "logic verifier inputs" do
    test "logic_verifier_inputs/0" do
      logic_verifier_inputs = Test.test_logic_verifier_inputs()
      # assert is struct
      assert %LogicVerifierInputs{} = logic_verifier_inputs

      # assert types
      assert is_binary(logic_verifier_inputs.tag)
      assert is_binary(logic_verifier_inputs.verifying_key)
      assert %AppData{} = logic_verifier_inputs.app_data
      assert is_binary(logic_verifier_inputs.proof)
    end

    test "logic_verifier_inputs/1" do
      logic_verifier_inputs = Test.test_logic_verifier_inputs()
      logic_verifier_inputs_return = Test.test_logic_verifier_inputs(logic_verifier_inputs)
      # assert is struct
      assert %LogicVerifierInputs{} = logic_verifier_inputs_return

      # assert types
      assert is_binary(logic_verifier_inputs_return.tag)
      assert is_binary(logic_verifier_inputs_return.verifying_key)
      assert %AppData{} = logic_verifier_inputs_return.app_data
      assert is_binary(logic_verifier_inputs_return.proof)
    end
  end

  # ----------------------------------------------------------------------------#
  #                                Merkle Tree                                  #
  # ----------------------------------------------------------------------------#

  defp verify_merkle_tree_types(merkle_tree) do
    assert %MerkleTree{} = merkle_tree
    for leaf <- merkle_tree.leaves, do: assert(is_binary(leaf))
  end

  describe "merkle tree" do
    test "test_merkle_tree/0" do
      merkle_tree = Test.test_merkle_tree()

      verify_merkle_tree_types(merkle_tree)
    end

    test "test_merkle_tree/1" do
      merkle_tree = Test.test_merkle_tree()

      merkle_tree_return = Test.test_merkle_tree(merkle_tree)
      verify_merkle_tree_types(merkle_tree_return)
    end
  end

  # ----------------------------------------------------------------------------#
  #                                MerklePath                                   #
  # ----------------------------------------------------------------------------#

  defp verify_merkle_path_types(merkle_path) do
    # assert type
    assert is_list(merkle_path)

    for node <- merkle_path do
      {hash, left?} = node
      assert is_binary(hash)
      assert is_boolean(left?)
    end
  end

  describe "merkle path" do
    test "test_merkle_path/0" do
      merkle_path = Test.test_merkle_path()

      verify_merkle_path_types(merkle_path)
    end

    test "test_merkle_path/1" do
      merkle_path = Test.test_merkle_path()
      merkle_path_return = Test.test_merkle_path(merkle_path)
      assert merkle_path == merkle_path_return

      verify_merkle_path_types(merkle_path_return)
    end
  end

  # ----------------------------------------------------------------------------#
  #                                ComplianceInstance                           #
  # ----------------------------------------------------------------------------#

  defp verify_compliance_instance_types(compliance_instance) do
    assert %ComplianceInstance{} = compliance_instance
    assert is_binary(compliance_instance.consumed_nullifier)
    assert is_binary(compliance_instance.consumed_logic_ref)
    assert is_binary(compliance_instance.consumed_commitment_tree_root)
    assert is_binary(compliance_instance.created_commitment)
    assert is_binary(compliance_instance.created_logic_ref)
    assert is_binary(compliance_instance.delta_x)
    assert is_binary(compliance_instance.delta_y)
  end

  describe "compliance instance" do
    test "test_compliance_instance/0" do
      compliance_instance = Test.test_compliance_instance()

      verify_compliance_instance_types(compliance_instance)
    end

    @tag :this
    test "test_compliance_instance/1" do
      compliance_instance = Test.test_compliance_instance()
      compliance_instance_return = Test.test_compliance_instance(compliance_instance)

      assert compliance_instance == compliance_instance_return

      verify_compliance_instance_types(compliance_instance_return)
    end
  end

  # ----------------------------------------------------------------------------#
  #                                NullifierKeyCommitment                       #
  # ----------------------------------------------------------------------------#

  defp verify_nullifier_key_commitment_types(nf_key_commitment) do
    assert is_binary(nf_key_commitment)
  end

  describe "nullifier key commitment" do
    test "test_nullifier_key_commitment/0" do
      nf_key_commitment = Test.test_nullifier_key_commitment()
      verify_nullifier_key_commitment_types(nf_key_commitment)
    end

    test "test_nullifier_key_commitment/1" do
      nf_key_commitment = Test.test_nullifier_key_commitment()
      nf_key_commitment_return = Test.test_nullifier_key_commitment(nf_key_commitment)
      verify_nullifier_key_commitment_types(nf_key_commitment_return)
    end
  end

  # ----------------------------------------------------------------------------#
  #                                NullifierKey                                 #
  # ----------------------------------------------------------------------------#

  defp verify_nullifier_key_types(nf_key) do
    assert is_binary(nf_key)
  end

  describe "nullifier key" do
    test "test_nullifier_key/0" do
      nf_key = Test.test_nullifier_key()
      assert is_binary(nf_key)
    end

    test "test_nullifier_key/1" do
      nf_key = Test.test_nullifier_key()
      nf_key_return = Test.test_nullifier_key(nf_key)
      assert nf_key == nf_key_return
      assert is_binary(nf_key_return)
    end
  end

  # ----------------------------------------------------------------------------#
  #                                Resource                                   #
  # ----------------------------------------------------------------------------#

  defp verify_resource_types(resource) do
    # assert struct
    assert %Resource{} = resource

    # assert types
    assert is_binary(resource.logic_ref)
    assert is_binary(resource.label_ref)
    assert is_number(resource.quantity)
    assert is_binary(resource.value_ref)
    assert is_boolean(resource.is_ephemeral)
    assert is_binary(resource.nonce)
    assert is_binary(resource.nk_commitment)
    assert is_binary(resource.rand_seed)
  end

  describe "resource" do
    test "test_resource/0" do
      resource = Test.test_resource()
      verify_resource_types(resource)
    end

    test "test_resource/1" do
      resource = Test.test_resource()
      resource_return = Test.test_resource(resource)
      assert resource == resource_return
      verify_resource_types(resource_return)
    end
  end

  # ----------------------------------------------------------------------------#
  #                                ComplianceWitness                            #
  # ----------------------------------------------------------------------------#

  defp verify_compliance_witness_types(compliance_witness) do
    assert %ComplianceWitness{} = compliance_witness

    verify_resource_types(compliance_witness.consumed_resource)
    verify_merkle_path_types(compliance_witness.merkle_path)
    assert is_binary(compliance_witness.ephemeral_root)
    verify_nullifier_key_types(compliance_witness.nf_key)
    verify_resource_types(compliance_witness.created_resource)
    assert is_binary(compliance_witness.rcv)
  end

  describe "compliance witness" do
    test "test_compliance_witness/0" do
      compliance_witness = Test.test_compliance_witness()
      verify_compliance_witness_types(compliance_witness)
    end

    test "test_compliance_witness/1" do
      compliance_witness = Test.test_compliance_witness()
      compliance_witness_return = Test.test_compliance_witness(compliance_witness)
      verify_compliance_witness_types(compliance_witness_return)
    end
  end

  # ----------------------------------------------------------------------------#
  #                                DeltaProof                                   #
  # ----------------------------------------------------------------------------#

  defp verify_delta_proof_types(delta_proof) do
    assert is_binary(delta_proof.signature)
    assert is_number(delta_proof.recid)
  end

  describe "delta proof" do
    test "delta_proof/0" do
      delta_proof = Test.test_delta_proof()
      verify_delta_proof_types(delta_proof)
    end

    test "delta_proof/1" do
      delta_proof = Test.test_delta_proof()
      delta_proof_return = Test.test_delta_proof(delta_proof)

      verify_delta_proof_types(delta_proof_return)
    end
  end

  # ----------------------------------------------------------------------------#
  #                                DeltaWitness                                 #
  # ----------------------------------------------------------------------------#

  defp verify_delta_witness_types(delta_witness) do
    assert is_binary(delta_witness.signing_key)
  end

  describe "delta witness" do
    test "delta_witness/0" do
      delta_witness = Test.test_delta_witness()
      verify_delta_witness_types(delta_witness)
    end

    test "delta_witness/1" do
      delta_witness = Test.test_delta_witness()
      delta_witness_return = Test.test_delta_witness(delta_witness)
      assert delta_witness == delta_witness_return
      verify_delta_witness_types(delta_witness_return)
    end
  end

  # ----------------------------------------------------------------------------#
  #                                LogicVerifier                                   #
  # ----------------------------------------------------------------------------#

  defp verify_logic_verifier_types(logic_verifier) do
    assert %LogicVerifier{} = logic_verifier
    assert is_binary(logic_verifier.instance)
    assert is_binary(logic_verifier.proof)
    assert is_binary(logic_verifier.verifying_key)
  end

  describe "logic proof" do
    test "test_logic_verifier/0" do
      logic_verifier = Test.test_logic_verifier()
      verify_logic_verifier_types(logic_verifier)
    end

    test "test_logic_verifier/1" do
      logic_verifier = Test.test_logic_verifier()
      logic_verifier_return = Test.test_logic_verifier(logic_verifier)
      verify_logic_verifier_types(logic_verifier_return)
    end
  end

  # ----------------------------------------------------------------------------#
  #                                Delta                                        #
  # ----------------------------------------------------------------------------#

  defp verify_delta_types({:witness, delta_witness}) do
    verify_delta_witness_types(delta_witness)
  end

  defp verify_delta_types({:proof, delta_proof}) do
    verify_delta_proof_types(delta_proof)
  end

  describe "delta" do
    test "test_delta_with_witness/0" do
      delta = Test.test_delta_with_witness()
      verify_delta_types(delta)
    end

    test "test_delta_with_witness/1" do
      delta = Test.test_delta_with_witness()
      delta_return = Test.test_delta_with_witness(delta)
      verify_delta_types(delta_return)
    end

    test "test_delta_with_proof/0" do
      delta = Test.test_delta_with_proof()
      verify_delta_types(delta)
    end

    test "test_delta_with_proof/1" do
      delta = Test.test_delta_with_proof()
      delta_return = Test.test_delta_with_proof(delta)
      verify_delta_types(delta_return)
    end
  end

  #
  #  # ----------------------------------------------------------------------------#
  #  #                                Transaction                                  #
  #  # ----------------------------------------------------------------------------#
  #
  #  describe "transaction" do
  #    test "test_transaction/0" do
  #      assert %Transaction{} = Test.test_transaction()
  #    end
  #
  #    test "test_transaction/1" do
  #      transaction = Test.test_transaction()
  #      assert transaction == Test.test_transaction(transaction)
  #    end
  #  end
  #

  #  # ----------------------------------------------------------------------------#
  #  #                                LogicVerifier                                #
  #  # ----------------------------------------------------------------------------#
  #
  #  describe "logic verifier" do
  #    test "logic_verifier/0" do
  #      assert %LogicVerifier{} = Test.test_logic_verifier()
  #    end
  #
  #    test "logic_verifier/1" do
  #      test_logic_verifier = Test.test_logic_verifier()
  #      assert test_logic_verifier == Test.test_logic_verifier(test_logic_verifier)
  #    end
  #  end
end
