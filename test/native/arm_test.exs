defmodule AnomaSDK.Test.Native.ArmTest do
  @moduledoc """
  This module tests the test NIF bindings from the `native/arm_test` repo.

  It's goal is to ensure that data structures are serialized properly back and
  forth between Rust and Elixir.
  """
  use ExUnit.Case

  alias AnomaSDK.Arm.Ciphertext
  alias AnomaSDK.Arm.Keypair
  alias AnomaSDK.Arm.LogicVerifier
  alias AnomaSDK.Arm.MerklePath
  alias AnomaSDK.Arm.NullifierKey
  alias AnomaSDK.Arm.NullifierKeyCommitment
  alias AnomaSDK.Arm.Test
  alias AnomaSDK.Arm.Transaction

  test "verify ciphertext encrypt and decrypt" do
    # generate a keypair to encrypt a cipher
    sender_keypair = AnomaSDK.Arm.random_key_pair()
    receiver_keypair = AnomaSDK.Arm.random_key_pair()
    # data to encrypt
    cipher = :crypto.strong_rand_bytes(32)
    # nonce
    nonce = :crypto.strong_rand_bytes(12)

    encrypted =
      AnomaSDK.Arm.encrypt_cipher(
        :binary.bin_to_list(cipher),
        %Keypair{secret_key: sender_keypair.secret_key, public_key: receiver_keypair.public_key},
        :binary.bin_to_list(nonce)
      )

    AnomaSDK.Arm.decrypt_cipher(:binary.bin_to_list(encrypted), receiver_keypair)
  end

  # ----------------------------------------------------------------------------#
  #                                SecretKey                                   #
  # ----------------------------------------------------------------------------#

  describe "secret key" do
    test "test_secret_key/0" do
      secret_key = Test.test_secret_key()
      Keypair.valid_secret?(secret_key)
    end

    test "test_secret_key/1" do
      secret_key = Test.test_secret_key()
      secret_key_return = Test.test_secret_key(secret_key)
      Keypair.valid_secret?(secret_key_return)
    end
  end

  # ----------------------------------------------------------------------------#
  #                                Ciphertext                                   #
  # ----------------------------------------------------------------------------#

  describe "cipher text" do
    test "test_cipher_text/0" do
      cipher_text = Test.test_cipher_text()
      Ciphertext.valid?(cipher_text)
    end

    test "test_compliance_unit/1" do
      cipher_text = Test.test_cipher_text()
      cipher_text_return = Test.test_cipher_text(cipher_text)
      Ciphertext.valid?(cipher_text_return)
    end
  end

  # ----------------------------------------------------------------------------#
  #                                ComplianceUnit                               #
  # ----------------------------------------------------------------------------#

  describe "compliance unit" do
    test "test_compliance_unit/0" do
      compliance_unit = Test.test_compliance_unit()
      AnomaSDK.Validate.valid?(compliance_unit)
    end

    test "test_compliance_unit/1" do
      compliance_unit = Test.test_compliance_unit()
      compliance_unit_return = Test.test_compliance_unit(compliance_unit)

      assert compliance_unit == compliance_unit_return

      AnomaSDK.Validate.valid?(compliance_unit_return)
    end
  end

  # ----------------------------------------------------------------------------#
  #                                ExpirableBlob                                #
  # ----------------------------------------------------------------------------#

  describe "expirable blob" do
    test "expirable_blob/0" do
      expirable_blob = Test.test_expirable_blob()

      AnomaSDK.Validate.valid?(expirable_blob)
    end

    test "expirable_blob/1" do
      expirable_blob = Test.test_expirable_blob()
      expirable_blob_return = Test.test_expirable_blob(expirable_blob)

      assert expirable_blob == expirable_blob_return
      AnomaSDK.Validate.valid?(expirable_blob_return)
    end
  end

  # ----------------------------------------------------------------------------#
  #                                AppData                                      #
  # ----------------------------------------------------------------------------#

  describe "app data" do
    test "app_data/0" do
      app_data = Test.test_app_data()

      AnomaSDK.Validate.valid?(app_data)
    end

    test "app_data/1" do
      app_data = Test.test_app_data()
      app_data_return = Test.test_app_data(app_data)

      assert app_data == app_data_return

      AnomaSDK.Validate.valid?(app_data_return)
    end
  end

  # ----------------------------------------------------------------------------#
  #                                Action                                       #
  # ----------------------------------------------------------------------------#

  describe "action" do
    test "test_action/0" do
      action = Test.test_action()

      AnomaSDK.Validate.valid?(action)
    end

    test "test_action/1" do
      action = Test.test_action()
      action_return = Test.test_action(action)
      assert action == action_return

      AnomaSDK.Validate.valid?(action_return)
    end
  end

  # ----------------------------------------------------------------------------#
  #                                LogicVerifierInputs                          #
  # ----------------------------------------------------------------------------#

  describe "logic verifier inputs" do
    test "logic_verifier_inputs/0" do
      logic_verifier_inputs = Test.test_logic_verifier_inputs()
      AnomaSDK.Validate.valid?(logic_verifier_inputs)
    end

    test "logic_verifier_inputs/1" do
      logic_verifier_inputs = Test.test_logic_verifier_inputs()
      logic_verifier_inputs_return = Test.test_logic_verifier_inputs(logic_verifier_inputs)

      AnomaSDK.Validate.valid?(logic_verifier_inputs_return)
    end
  end

  # ----------------------------------------------------------------------------#
  #                                Merkle Tree                                  #
  # ----------------------------------------------------------------------------#

  describe "merkle tree" do
    test "test_merkle_tree/0" do
      merkle_tree = Test.test_merkle_tree()

      AnomaSDK.Validate.valid?(merkle_tree)
    end

    test "test_merkle_tree/1" do
      merkle_tree = Test.test_merkle_tree()

      merkle_tree_return = Test.test_merkle_tree(merkle_tree)
      AnomaSDK.Validate.valid?(merkle_tree_return)
    end
  end

  # ----------------------------------------------------------------------------#
  #                                MerklePath                                   #
  # ----------------------------------------------------------------------------#

  describe "merkle path" do
    test "test_merkle_path/0" do
      merkle_path = Test.test_merkle_path()

      MerklePath.valid?(merkle_path)
    end

    test "test_merkle_path/1" do
      merkle_path = Test.test_merkle_path()
      merkle_path_return = Test.test_merkle_path(merkle_path)
      assert merkle_path == merkle_path_return

      MerklePath.valid?(merkle_path_return)
    end
  end

  # ----------------------------------------------------------------------------#
  #                                ComplianceInstance                           #
  # ----------------------------------------------------------------------------#

  describe "compliance instance" do
    test "test_compliance_instance/0" do
      compliance_instance = Test.test_compliance_instance()

      AnomaSDK.Validate.valid?(compliance_instance)
    end

    @tag :this
    test "test_compliance_instance/1" do
      compliance_instance = Test.test_compliance_instance()
      compliance_instance_return = Test.test_compliance_instance(compliance_instance)

      assert compliance_instance == compliance_instance_return

      AnomaSDK.Validate.valid?(compliance_instance_return)
    end
  end

  # ----------------------------------------------------------------------------#
  #                                NullifierKeyCommitment                       #
  # ----------------------------------------------------------------------------#

  describe "nullifier key commitment" do
    test "test_nullifier_key_commitment/0" do
      nf_key_commitment = Test.test_nullifier_key_commitment()
      NullifierKeyCommitment.valid?(nf_key_commitment)
    end

    test "test_nullifier_key_commitment/1" do
      nf_key_commitment = Test.test_nullifier_key_commitment()
      nf_key_commitment_return = Test.test_nullifier_key_commitment(nf_key_commitment)
      NullifierKeyCommitment.valid?(nf_key_commitment_return)
    end
  end

  # ----------------------------------------------------------------------------#
  #                                NullifierKey                                 #
  # ----------------------------------------------------------------------------#

  describe "nullifier key" do
    test "test_nullifier_key/0" do
      nf_key = Test.test_nullifier_key()
      assert NullifierKey.valid?(nf_key)
    end

    test "test_nullifier_key/1" do
      nf_key = Test.test_nullifier_key()
      nf_key_return = Test.test_nullifier_key(nf_key)
      assert nf_key == nf_key_return
      assert NullifierKey.valid?(nf_key_return)
    end
  end

  # ----------------------------------------------------------------------------#
  #                                Resource                                   #
  # ----------------------------------------------------------------------------#

  describe "resource" do
    test "test_resource/0" do
      resource = Test.test_resource()
      AnomaSDK.Validate.valid?(resource)
    end

    test "test_resource/1" do
      resource = Test.test_resource()
      resource_return = Test.test_resource(resource)
      assert resource == resource_return
      AnomaSDK.Validate.valid?(resource_return)
    end
  end

  # ----------------------------------------------------------------------------#
  #                                ComplianceWitness                            #
  # ----------------------------------------------------------------------------#

  describe "compliance witness" do
    test "test_compliance_witness/0" do
      compliance_witness = Test.test_compliance_witness()
      AnomaSDK.Validate.valid?(compliance_witness)
    end

    test "test_compliance_witness/1" do
      compliance_witness = Test.test_compliance_witness()
      compliance_witness_return = Test.test_compliance_witness(compliance_witness)
      AnomaSDK.Validate.valid?(compliance_witness_return)
    end
  end

  # ----------------------------------------------------------------------------#
  #                                DeltaProof                                   #
  # ----------------------------------------------------------------------------#

  describe "delta proof" do
    test "delta_proof/0" do
      delta_proof = Test.test_delta_proof()
      AnomaSDK.Validate.valid?(delta_proof)
    end

    test "delta_proof/1" do
      delta_proof = Test.test_delta_proof()
      delta_proof_return = Test.test_delta_proof(delta_proof)

      AnomaSDK.Validate.valid?(delta_proof_return)
    end
  end

  # ----------------------------------------------------------------------------#
  #                                DeltaWitness                                 #
  # ----------------------------------------------------------------------------#

  describe "delta witness" do
    test "delta_witness/0" do
      delta_witness = Test.test_delta_witness()
      AnomaSDK.Validate.valid?(delta_witness)
    end

    test "delta_witness/1" do
      delta_witness = Test.test_delta_witness()
      delta_witness_return = Test.test_delta_witness(delta_witness)
      assert delta_witness == delta_witness_return
      AnomaSDK.Validate.valid?(delta_witness_return)
    end
  end

  # ----------------------------------------------------------------------------#
  #                                LogicVerifier                                   #
  # ----------------------------------------------------------------------------#

  describe "logic proof" do
    test "test_logic_verifier/0" do
      logic_verifier = Test.test_logic_verifier()
      AnomaSDK.Validate.valid?(logic_verifier)
    end

    test "test_logic_verifier/1" do
      logic_verifier = Test.test_logic_verifier()
      logic_verifier_return = Test.test_logic_verifier(logic_verifier)
      AnomaSDK.Validate.valid?(logic_verifier_return)
    end
  end

  # ----------------------------------------------------------------------------#
  #                                Delta                                        #
  # ----------------------------------------------------------------------------#

  describe "delta" do
    test "test_delta_with_witness/0" do
      delta = Test.test_delta_with_witness()
      Transaction.valid_delta_proof?(delta)
    end

    test "test_delta_with_witness/1" do
      delta = Test.test_delta_with_witness()
      delta_return = Test.test_delta_with_witness(delta)
      Transaction.valid_delta_proof?(delta_return)
    end

    test "test_delta_with_proof/0" do
      delta = Test.test_delta_with_proof()
      Transaction.valid_delta_proof?(delta)
    end

    test "test_delta_with_proof/1" do
      delta = Test.test_delta_with_proof()
      delta_return = Test.test_delta_with_proof(delta)
      Transaction.valid_delta_proof?(delta_return)
    end
  end

  # ----------------------------------------------------------------------------#
  #                                Transaction                                  #
  # ----------------------------------------------------------------------------#

  describe "transaction" do
    test "test_transaction/0" do
      res = Test.test_transaction()
      AnomaSDK.Validate.valid?(res)
    end

    test "test_transaction/1" do
      transaction = Test.test_transaction()
      assert transaction == Test.test_transaction(transaction)
    end

    test "test_transaction/1 with no expected_balance" do
      transaction = Test.test_transaction() |> Map.put(:expected_balance, nil)
      assert transaction == Test.test_transaction(transaction)
    end

    test "test_transaction/1 with expected_balance" do
      transaction = Test.test_transaction() |> Map.put(:expected_balance, <<1, 2, 3>>)
      assert transaction == Test.test_transaction(transaction)
    end
  end

  # ----------------------------------------------------------------------------#
  #                                LogicVerifier                                #
  # ----------------------------------------------------------------------------#

  describe "logic verifier" do
    test "logic_verifier/0" do
      assert %LogicVerifier{} = Test.test_logic_verifier()
    end

    test "logic_verifier/1" do
      test_logic_verifier = Test.test_logic_verifier()
      assert test_logic_verifier == Test.test_logic_verifier(test_logic_verifier)
    end
  end
end
