defmodule Anoma.Test.Native.ArmTest do
  @moduledoc """
  This module tests the test NIF bindings from the `native/arm_test` repo.

  It's goal is to ensure that data structures are serialized properly back and
  forth between Rust and Elixir.
  """
  use ExUnit.Case

  alias Anoma.Arm.Action
  alias Anoma.Arm.ComplianceInstance
  alias Anoma.Arm.ComplianceUnit
  alias Anoma.Arm.ComplianceWitness
  alias Anoma.Arm.DeltaProof
  alias Anoma.Arm.DeltaWitness
  alias Anoma.Arm.LogicVerifier
  alias Anoma.Arm.MerklePath
  alias Anoma.Arm.MerkleTree
  alias Anoma.Arm.Resource
  alias Anoma.Arm.Transaction
  alias Anoma.Arm.TrivialLogicWitness
  alias Anoma.Arm.Test
  alias Anoma.Arm.ExpirableBlob
  alias Anoma.Arm.LogicVerifierInputs

  # ----------------------------------------------------------------------------#
  #                                DeltaWitness                                 #
  # ----------------------------------------------------------------------------#

  describe "delta witness" do
    test "delta_witness/0" do
      assert %DeltaWitness{} = Test.test_delta_witness()
    end

    test "delta_witness/1" do
      delta_witness = Test.test_delta_witness()
      assert delta_witness == Test.test_delta_witness(delta_witness)
    end
  end

  # ----------------------------------------------------------------------------#
  #                                Delta                                        #
  # ----------------------------------------------------------------------------#

  describe "delta" do
    test "test_delta_with_witness/0" do
      assert {:witness, %DeltaWitness{}} = Test.test_delta_with_witness()
    end

    test "test_delta_with_witness/1" do
      delta_witness = Test.test_delta_with_witness()
      assert delta_witness == Test.test_delta_with_witness(delta_witness)
    end

    test "test_delta_with_proof/0" do
      assert {:proof, %DeltaProof{}} = Test.test_delta_with_proof()
    end

    test "test_delta_with_proof/1" do
      delta_proof = Test.test_delta_with_proof()
      assert delta_proof == Test.test_delta_with_proof(delta_proof)
    end
  end

  # ----------------------------------------------------------------------------#
  #                                ComplianceInstance                           #
  # ----------------------------------------------------------------------------#

  describe "compliance instance" do
    test "test_compliance_instance/0" do
      assert %ComplianceInstance{} = Test.test_compliance_instance()
    end

    @tag :this
    test "test_compliance_instance/1" do
      compliance_instance = Test.test_compliance_instance()
      assert %ComplianceInstance{} = Test.test_compliance_instance(compliance_instance)
    end
  end

  # ----------------------------------------------------------------------------#
  #                                ComplianceUnit                               #
  # ----------------------------------------------------------------------------#

  describe "compliance unit" do
    test "test_compliance_unit/0" do
      assert %ComplianceUnit{} = Test.test_compliance_unit()
    end

    test "test_compliance_unit/1" do
      compliance_unit = Test.test_compliance_unit()
      assert compliance_unit == Test.test_compliance_unit(compliance_unit)
    end
  end

  # ----------------------------------------------------------------------------#
  #                                LogicVerifier                                   #
  # ----------------------------------------------------------------------------#

  describe "logic proof" do
    test "test_logic_verifier/0" do
      assert %LogicVerifier{} = Test.test_logic_verifier()
    end

    test "test_logic_verifier/1" do
      logic_verifier = Test.test_logic_verifier()
      assert logic_verifier == Test.test_logic_verifier(logic_verifier)
    end
  end

  # ----------------------------------------------------------------------------#
  #                                Resource                                   #
  # ----------------------------------------------------------------------------#

  describe "resource" do
    test "test_resource/0" do
      assert %Resource{} = Test.test_resource()
    end

    test "test_resource/1" do
      resource = Test.test_resource()
      assert resource == Test.test_resource(resource)
    end
  end

  # ----------------------------------------------------------------------------#
  #                                MerklePath                                   #
  # ----------------------------------------------------------------------------#

  describe "merkle path" do
    test "test_merkle_path/0" do
      assert %MerklePath{} = Test.test_merkle_path()
    end

    test "test_merkle_path/1" do
      merkle_path = Test.test_merkle_path()
      assert merkle_path == Test.test_merkle_path(merkle_path)
    end
  end

  # ----------------------------------------------------------------------------#
  #                                Merkle Tree                                  #
  # ----------------------------------------------------------------------------#

  describe "merkle tree" do
    test "test_merkle_tree/0" do
      assert %MerkleTree{} = Test.test_merkle_tree()
    end

    test "test_merkle_tree/1" do
      merkle_tree = Test.test_merkle_tree()
      assert merkle_tree == Test.test_merkle_tree(merkle_tree)
    end
  end

  # ----------------------------------------------------------------------------#
  #                                ComplianceWitness                            #
  # ----------------------------------------------------------------------------#

  describe "compliance witness" do
    test "test_compliance_witness/0" do
      assert %ComplianceWitness{} = Test.test_compliance_witness()
    end

    test "test_compliance_witness/1" do
      compliance_witness = Test.test_compliance_witness()
      assert compliance_witness == Test.test_compliance_witness(compliance_witness)
    end
  end

  # ----------------------------------------------------------------------------#
  #                                Action                                       #
  # ----------------------------------------------------------------------------#

  describe "action" do
    test "test_action/0" do
      assert %Action{} = Test.test_action()
    end

    test "test_action/1" do
      action = Test.test_action()
      assert action == Test.test_action(action)
    end
  end

  # ----------------------------------------------------------------------------#
  #                                Transaction                                  #
  # ----------------------------------------------------------------------------#

  describe "transaction" do
    test "test_transaction/0" do
      assert %Transaction{} = Test.test_transaction()
    end

    test "test_transaction/1" do
      transaction = Test.test_transaction()
      assert transaction == Test.test_transaction(transaction)
    end
  end

  # ----------------------------------------------------------------------------#
  #                                NullifierKey                                 #
  # ----------------------------------------------------------------------------#

  describe "nullifier key" do
    test "test_nullifier_key/0" do
      assert {_key_bytes} = Test.test_nullifier_key()
    end

    test "test_nullifier_key/1" do
      nullifier_key = Test.test_nullifier_key()
      assert nullifier_key == Test.test_nullifier_key(nullifier_key)
    end
  end

  # ----------------------------------------------------------------------------#
  #                                NullifierKeyCommitment                       #
  # ----------------------------------------------------------------------------#

  describe "nullifier key commitment" do
    test "test_nullifier_key_commitment/0" do
      assert {_commitment_bytes} = Test.test_nullifier_key_commitment()
    end

    test "test_nullifier_key_commitment/1" do
      nullifier_key = Test.test_nullifier_key()
      assert _commitment_bytes = Test.test_nullifier_key_commitment(nullifier_key)
    end
  end

  # ----------------------------------------------------------------------------#
  #                                DeltaProof                                   #
  # ----------------------------------------------------------------------------#

  describe "delta proof" do
    test "delta_proof/0" do
      assert %DeltaProof{} = Test.test_delta_proof()
    end

    test "delta_proof/1" do
      delta_proof = Test.test_delta_proof()
      assert delta_proof == Test.test_delta_proof(delta_proof)
    end
  end

  # ----------------------------------------------------------------------------#
  #                                DeltaProof                                   #
  # ----------------------------------------------------------------------------#

  describe "expirable blob" do
    test "expirable_blob/0" do
      assert %ExpirableBlob{} = Test.test_expirable_blob()
    end

    test "expirable_blob/1" do
      expirable_blob = Test.test_expirable_blob()
      assert expirable_blob == Test.test_expirable_blob(expirable_blob)
    end
  end

  # ----------------------------------------------------------------------------#
  #                                AppData                                      #
  # ----------------------------------------------------------------------------#

  describe "app data" do
    test "app_data/0" do
      assert %ExpirableBlob{} = Test.test_expirable_blob()
    end

    test "app_data/1" do
      app_data = Test.test_app_data()
      assert app_data == Test.test_app_data(app_data)
    end
  end

  # ----------------------------------------------------------------------------#
  #                                LogicVerifierInputs                                      #
  # ----------------------------------------------------------------------------#

  describe "logic verifier inputs" do
    test "logic_verifier_inputs/0" do
      assert %LogicVerifierInputs{} = Test.test_logic_verifier_inputs()
    end

    test "logic_verifier_inputs/1" do
      logic_verifier_inputs = Test.test_logic_verifier_inputs()
      assert logic_verifier_inputs == Test.test_logic_verifier_inputs(logic_verifier_inputs)
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
