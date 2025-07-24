defmodule Anoma do
  @moduledoc false

  alias Anoma.Examples.SimpleTransaction

  @doc false
  @spec test :: term()
  def test do
    {actions, delta_witness} = SimpleTransaction.create_actions(10)
    {actions, delta_witness}
  end
end
