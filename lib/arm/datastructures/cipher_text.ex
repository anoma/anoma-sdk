defmodule AnomaSDK.Arm.Ciphertext do
  @moduledoc """
  Defines the type for a Ciphertext, which is just a binary.
  """
  @type t :: binary()

  @spec valid?(t()) :: boolean()
  def valid?(nk) do
    is_binary(nk)
  end
end
