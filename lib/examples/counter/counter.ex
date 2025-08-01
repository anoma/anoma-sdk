defmodule Anoma.Examples.Counter do
  @moduledoc """
  I define an example application to work with counters as resources.
  """
  use Rustler,
    otp_app: :anoma_sdk,
    crate: :counter_lib

  alias Anoma.Arm.LogicProof
  alias Anoma.Examples.Counter.CounterLogic
  alias Anoma.Examples.Counter.CounterWitness

  # ----------------------------------------------------------------------------
  # Functions

  @doc """
  Prove the a counter logic witness and return a logic proof.
  """
  @spec prove_counter_logic(CounterLogic.t()) :: LogicProof.t()
  def prove_counter_logic(_), do: :erlang.nif_error(:nif_not_loaded)

  @doc """
  Returns the counter logic reference bytes.
  """
  @spec counter_logic_ref :: [byte()]
  def counter_logic_ref, do: :erlang.nif_error(:nif_not_loaded)

  # ----------------------------------------------------------------------------
  # Test Functions

  @doc false
  @spec test_counter_witness() :: CounterWitness.t()
  def test_counter_witness, do: :erlang.nif_error(:nif_not_loaded)

  @doc false
  @spec test_counter_witness(CounterWitness.t()) :: CounterWitness.t()
  def test_counter_witness(_), do: :erlang.nif_error(:nif_not_loaded)

  @doc false
  @spec test_counter_logic :: CounterLogic.t()
  def test_counter_logic, do: :erlang.nif_error(:nif_not_loaded)

  @doc false
  @spec test_counter_logic(CounterLogic.t()) :: CounterLogic.t()
  def test_counter_logic(_), do: :erlang.nif_error(:nif_not_loaded)
end
