defmodule AnomaSDK.Examples.ETransaction do
  @moduledoc """
  I provide examples for Transactions
  """
  alias AnomaSDK.Arm.Test
  alias AnomaSDK.Arm.Transaction
  alias AnomaSDK.Examples.ENifData

  @spec empty_balance_tx() :: Transaction.t()
  def empty_balance_tx,
    do:
      ENifData.nif_transaction()
      |> Map.put(:expected_balance, nil)
      |> ENifData.roundtrip(&Test.test_transaction/1)

  @spec basic_balance_tx() :: Transaction.t()
  def basic_balance_tx,
    do:
      ENifData.nif_transaction()
      |> Map.put(:expected_balance, <<1, 2, 3>>)
      |> ENifData.roundtrip(&Test.test_transaction/1)
end
