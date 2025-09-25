defmodule AnomaSDK.Test.Native.ArmTest do
  @moduledoc """
  This module tests the test NIF bindings from the `native/arm_test` repo.

  It's goal is to ensure that data structures are serialized properly back and
  forth between Rust and Elixir.
  """
  use ExUnit.Case

  alias AnomaSDK.Arm.Keypair
  alias AnomaSDK.Examples.ENifData
  alias AnomaSDK.Examples.ETransaction

  test "run decoding and encoding examples" do
    ENifData.nif_merkle_tree()
    ENifData.nif_secret_key()
    ENifData.nif_cipher_text()
    ENifData.nif_compliance_unit()
    ENifData.nif_expirable_blob()
    ENifData.nif_app_data()
    ENifData.nif_action()
    ENifData.nif_logic_verifier_inputs()
    ENifData.nif_merkle_path()
    ENifData.nif_compliance_instance()
    ENifData.nif_nullifier_key_commitment()
    ENifData.nif_nullifier_key()
    ENifData.nif_resource()
    ENifData.nif_compliance_witness()
    ENifData.nif_delta_proof()
    ENifData.nif_delta_witness()
    ENifData.nif_logic_verifier()
    ENifData.nif_delta_with_witness()
    ENifData.nif_delta_with_proof()
    ENifData.nif_transaction()
    ETransaction.basic_balance_tx()
    ETransaction.empty_balance_tx()
  end

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
end
