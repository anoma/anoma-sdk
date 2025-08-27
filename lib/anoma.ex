defmodule Anoma do
  @moduledoc false

  def test do
    Anoma.Arm.Test.test_merkle_path()
    Anoma.Examples.Counter.App.create_counter_transaction()
  end
end
