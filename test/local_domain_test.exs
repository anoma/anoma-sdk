defmodule AnomaSdkTest do
  use ExUnit.Case
  doctest AnomaSdk

  test "greets the world" do
    assert AnomaSdk.hello() == :world
  end
end
