defmodule Anoma.Test.Native.CounterTest do
  use ExUnit.Case

  alias Anoma.Arm.LogicProof
  alias Anoma.Examples.Counter
  alias Anoma.Examples.Counter.CounterLogic
  alias Anoma.Examples.Counter.CounterWitness

  describe "test_counter_witness/0" do
    # return a `DeltaWitness` struct.
    test "test_counter_witness/0" do
      assert %CounterWitness{} = Counter.test_counter_witness()
    end
  end

  describe "test_counter_witness/1" do
    # return a `DeltaWitness` struct.
    test "test_counter_witness/1" do
      witness = Counter.test_counter_witness()
      assert witness == Counter.test_counter_witness(witness)
    end
  end

  describe "test_counter_logic/0" do
    # return a `DeltaWitness` struct.
    test "test_counter_logic/0" do
      assert %CounterLogic{} = Counter.test_counter_logic()
    end
  end

  describe "test_counter_logic/1" do
    # return a `DeltaWitness` struct.
    test "test_counter_logic/0" do
      logic = Counter.test_counter_logic()
      assert logic == Counter.test_counter_logic(logic)
    end
  end

  describe "counter_logic_ref/0" do
    test "counter_logic_ref/0" do
      Counter.counter_logic_ref() |> tap(&IO.inspect(&1, label: ""))
    end
  end

  describe "prove_counter_logic/1" do
    test "prove_counter_logic/1" do
      logic = Counter.test_counter_logic()

      assert %LogicProof{} = Counter.prove_counter_logic(logic)
    end
  end
end
