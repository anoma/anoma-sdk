defmodule Anoma.Test.Native.ArmTest do
  use ExUnit.Case

  alias Anoma.Arm.Action
  alias Anoma.Arm.ComplianceInstance
  alias Anoma.Arm.ComplianceUnit
  alias Anoma.Arm.ComplianceWitness
  alias Anoma.Arm.DeltaProof
  alias Anoma.Arm.DeltaWitness
  alias Anoma.Arm.ForwarderCalldata
  alias Anoma.Arm.LogicProof
  alias Anoma.Arm.MerklePath
  alias Anoma.Arm.MerkleTree
  alias Anoma.Arm.Resource
  alias Anoma.Arm.Transaction
  alias Anoma.Arm.TrivialLogicWitness

  test "foo" do
    IO.puts(System.get_env("RISC0_DEV_MODE"))
  end

  describe "delta witness" do
    # return a `DeltaWitness` struct.
    test "delta_witness/0" do
      assert %DeltaWitness{} = Anoma.Arm.test_delta_witness()
    end

    # A struct is not altered after decoding/encoding it in Rust.
    test "delta_witness/1" do
      delta_witness = Anoma.Arm.test_delta_witness()
      assert delta_witness == Anoma.Arm.test_delta_witness(delta_witness)
    end

    test "test_delta_with_witness/0" do
      assert {:witness, %DeltaWitness{}} = Anoma.Arm.test_delta_with_witness()
    end
  end

  describe "delta proof" do
    # return a `DeltaWitness` struct.
    test "test_delta_proof/0" do
      assert %DeltaProof{} = Anoma.Arm.test_delta_proof()
    end

    # A struct is not altered after decoding/encoding it in Rust.
    test "test_delta_proof/1" do
      delta_proof = Anoma.Arm.test_delta_proof()
      assert delta_proof == Anoma.Arm.test_delta_proof(delta_proof)
    end

    test "test_delta_with_proof/0" do
      assert {:proof, %DeltaProof{}} = Anoma.Arm.test_delta_with_proof()
    end
  end

  describe "compliance instance" do
    test "test_compliance_instance/0" do
      assert %ComplianceInstance{} = Anoma.Arm.test_compliance_instance()
    end

    test "test_compliance_instance/1" do
      compliance_instance = Anoma.Arm.test_compliance_instance()
      assert %ComplianceInstance{} = Anoma.Arm.test_compliance_instance(compliance_instance)
    end
  end

  describe "main ARM functions" do
    test "prove/1" do
      witness = Anoma.Arm.test_compliance_witness()
      assert %ComplianceUnit{} = Anoma.Arm.prove(witness)
    end

    test "prove_trivial_logic_witness/1" do
      logic_witness = Anoma.Arm.test_trivial_logic_witness()
      assert %LogicProof{} = Anoma.Arm.prove_trivial_logic_witness(logic_witness)
    end

    test "unit_instance/1" do
      unit = Anoma.Arm.test_compliance_unit()
      assert %ComplianceInstance{} = Anoma.Arm.unit_instance(unit)
    end

    test "prove_delta_witness/2" do
      delta_witness = Anoma.Arm.test_delta_witness()
      arbitrary_bytes = [1, 2, 3, 4, 5]
      assert %DeltaProof{} = Anoma.Arm.prove_delta_witness(delta_witness, arbitrary_bytes)
    end
  end

  describe "compliance unit" do
    test "test_compliance_unit/0" do
      assert %ComplianceUnit{} = Anoma.Arm.test_compliance_unit()
    end

    test "test_compliance_unit/1" do
      compliance_unit = Anoma.Arm.test_compliance_unit()
      assert compliance_unit == Anoma.Arm.test_compliance_unit(compliance_unit)
    end
  end

  describe "logic proof" do
    test "test_logic_proof/0" do
      assert %LogicProof{} = Anoma.Arm.test_logic_proof()
    end

    test "test_logic_proof/1" do
      logic_proof = Anoma.Arm.test_logic_proof()
      assert logic_proof == Anoma.Arm.test_logic_proof(logic_proof)
    end
  end

  describe "forwarder calldata" do
    test "test_forwarder_calldata/0" do
      assert %ForwarderCalldata{} = Anoma.Arm.test_forwarder_calldata()
    end

    test "test_forwarder_calldata/1" do
      calldata = Anoma.Arm.test_forwarder_calldata()
      assert calldata == Anoma.Arm.test_forwarder_calldata(calldata)
    end
  end

  describe "resource" do
    test "test_resource/0" do
      assert %Resource{} = Anoma.Arm.test_resource()
    end

    test "test_resource/1" do
      resource = Anoma.Arm.test_resource()
      assert resource == Anoma.Arm.test_resource(resource)
    end
  end

  describe "action" do
    test "test_action/0" do
      assert %Action{} = Anoma.Arm.test_action()
    end

    test "test_action/1" do
      action = Anoma.Arm.test_action()
      assert action == Anoma.Arm.test_action(action)
    end
  end

  describe "transaction" do
    test "test_transaction/0" do
      assert %Transaction{} = Anoma.Arm.test_transaction()
    end

    test "test_transaction/1" do
      transaction = Anoma.Arm.test_transaction()
      assert transaction == Anoma.Arm.test_transaction(transaction)
    end
  end

  describe "nullifier key" do
    test "test_nullifier_key/0" do
      assert {_key_bytes} = Anoma.Arm.test_nullifier_key()
    end

    test "test_nullifier_key/1" do
      nullifier_key = Anoma.Arm.test_nullifier_key()
      assert nullifier_key == Anoma.Arm.test_nullifier_key(nullifier_key)
    end

    test "test_nullifier_key_commitment/0" do
      assert {_commitment_bytes} = Anoma.Arm.test_nullifier_key_commitment()
    end

    test "test_nullifier_key_commitment/1" do
      nullifier_key = Anoma.Arm.test_nullifier_key()
      assert _commitment_bytes = Anoma.Arm.test_nullifier_key_commitment(nullifier_key)
    end
  end

  describe "leaf" do
    test "test_leaf/0" do
      assert {_bin} = Anoma.Arm.test_leaf()
    end

    test "test_leaf/1" do
      leaf = Anoma.Arm.test_leaf()
      assert leaf == Anoma.Arm.test_leaf(leaf)
    end
  end

  describe "merkle path" do
    test "test_merkle_path/0" do
      assert %MerklePath{} = Anoma.Arm.test_merkle_path()
    end

    test "test_merkle_path/1" do
      merkle_path = Anoma.Arm.test_merkle_path()
      assert merkle_path == Anoma.Arm.test_merkle_path(merkle_path)
    end
  end

  describe "merkle tree" do
    test "test_merkle_tree/0" do
      assert %MerkleTree{} = Anoma.Arm.test_merkle_tree()
    end

    test "test_merkle_tree/1" do
      merkle_tree = Anoma.Arm.test_merkle_tree()
      assert merkle_tree == Anoma.Arm.test_merkle_tree(merkle_tree)
    end
  end

  describe "compliance witness" do
    test "test_compliance_witness/0" do
      assert %ComplianceWitness{} = Anoma.Arm.test_compliance_witness()
    end

    test "test_compliance_witness/1" do
      compliance_witness = Anoma.Arm.test_compliance_witness()
      assert compliance_witness == Anoma.Arm.test_compliance_witness(compliance_witness)
    end
  end

  describe "trivial logic witness" do
    test "test_trivial_logic_witness/0" do
      assert %TrivialLogicWitness{} = Anoma.Arm.test_trivial_logic_witness()
    end

    test "test_trivial_logic_witness/1" do
      trivial_logic_witness = Anoma.Arm.test_trivial_logic_witness()
      assert trivial_logic_witness == Anoma.Arm.test_trivial_logic_witness(trivial_logic_witness)
    end
  end
end
