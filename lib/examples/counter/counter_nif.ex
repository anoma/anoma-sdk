defmodule Anoma.Examples.Counter do
  @moduledoc """
  I define a few functions work with the counter application.
  """

  alias Anoma.Examples.Counter.CounterLogic
  alias Anoma.Arm.LogicVerifier
  alias Anoma.Arm.Transaction

  use Rustler,
    otp_app: :anoma_sdk,
    crate: :counter_nif

  @doc """
  Returns the logic ref for the counter binary.
  """
  @spec counter_logic_ref :: [byte()]
  def counter_logic_ref, do: :erlang.nif_error(:nif_not_loaded)
  def test, do: :erlang.nif_error(:nif_not_loaded)

  @doc """
  Prove the a counter logic witness and return a logic proof.
  """
  @spec prove_counter_logic(CounterLogic.t()) :: LogicVerifier.t()
  def prove_counter_logic(_), do: :erlang.nif_error(:nif_not_loaded)

  @doc """
  Submit a transaction to the protocol adapter.
  """
  @spec submit_transaction(Transaction.t()) :: :ok
  def submit_transaction(_), do: :erlang.nif_error(:nif_not_loaded)

  def keypair(), do: :erlang.nif_error(:nif_not_loaded)
  def create_tx_in_rust(_, _), do: :erlang.nif_error(:nif_not_loaded)
  def delta_message(_), do: :erlang.nif_error(:nif_not_loaded)

end
