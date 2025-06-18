defmodule Anoma.Arm.Keypair do
  @moduledoc """
  I define the datastructure `Keypair` that holds a public key and a private key.
  """
  use TypedStruct

  alias Anoma.Arm

  typedstruct do
    field :secret_key, binary()
    field :public_key, binary()
  end

  @doc """
  Generate a random keypair.
  """
  @spec random :: t()
  def random do
    Arm.random_key_pair()
  end
end
