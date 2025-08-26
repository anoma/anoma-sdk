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

  # ----------------------------------------------------------------------------#
  #                                DeltaWitness                                 #
  # ----------------------------------------------------------------------------#

  describe "delta witness" do
    # return a `DeltaWitness` struct.
    test "delta_witness/0" do
      assert %DeltaWitness{} = Test.test_delta_witness()
    end

    # A struct is not altered after decoding/encoding it in Rust.
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
    # return a `DeltaWitness` struct.
    test "delta_proof/0" do
      assert %DeltaProof{} = Test.test_delta_proof()
    end

    # A struct is not altered after decoding/encoding it in Rust.
    test "delta_proof/1" do
      delta_proof = Test.test_delta_proof()
      assert delta_proof == Test.test_delta_proof(delta_proof)
    end
  end

  #####

  # describe "main ARM functions" do
  #   test "prove/1" do
  #     witness = Test.test_compliance_witness()
  #     assert %ComplianceUnit{} = Test.prove(witness)
  #   end

  #   test "prove_trivial_logic_witness/1" do
  #     logic_witness = Test.test_trivial_logic_witness()
  #     assert %LogicVerifier{} = Test.prove_trivial_logic_witness(logic_witness)
  #   end

  #   test "unit_instance/1" do
  #     unit = Test.test_compliance_unit()
  #     assert %ComplianceInstance{} = Test.unit_instance(unit)
  #   end

  #   test "prove_delta_witness/2" do
  #     delta_witness = Test.test_delta_witness()
  #     arbitrary_bytes = [1, 2, 3, 4, 5]
  #     assert %DeltaProof{} = Test.prove_delta_witness(delta_witness, arbitrary_bytes)
  #   end
  # end

  # describe "forwarder calldata" do
  #   test "test_forwarder_calldata/0" do
  #     assert %ForwarderCalldata{} = Test.test_forwarder_calldata()
  #   end

  #   test "test_forwarder_calldata/1" do
  #     calldata = Test.test_forwarder_calldata()
  #     assert calldata == Test.test_forwarder_calldata(calldata)
  #   end
  # end

  # describe "trivial logic witness" do
  #   test "test_trivial_logic_witness/0" do
  #     assert %TrivialLogicWitness{} = Test.test_trivial_logic_witness()
  #   end

  #   test "test_trivial_logic_witness/1" do
  #     trivial_logic_witness = Test.test_trivial_logic_witness()
  #     assert trivial_logic_witness == Test.test_trivial_logic_witness(trivial_logic_witness)
  #   end
  # end
end
