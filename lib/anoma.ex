defmodule Anoma do
  @moduledoc false

  def test do
    {a, b} = Anoma.Examples.Counter.keypair()
    rust_tx = Anoma.Examples.Counter.create_tx_in_rust(a, b) |> elem(0)
    local_tx = Anoma.Examples.Counter.App.create_counter_transaction(a, b)

  end
end
