defmodule Anoma.Arm.Keypair do
  @moduledoc """
  I define the datastructure `Keypair` that holds a public key and a private key.
  """
  use TypedStruct

  alias Anoma.Arm
  alias Anoma.Arm.Keypair

  typedstruct do
    field :secret_key, binary()
    field :public_key, binary()
  end

  defimpl Jason.Encoder, for: Anoma.Arm.Keypair do
    @spec encode(struct(), term()) :: term()
    def encode(struct, opts) do
      struct
      |> Anoma.Json.encode_keys([:secret_key, :public_key])
      |> Jason.Encode.map(opts)
    end
  end

  @spec from_map(map) :: t()
  def from_map(map) do
    struct(Keypair, Anoma.Json.decode_keys(map))
  end

  @doc """
  Generate a random keypair.
  """
  @spec random :: t()
  def random do
    Arm.random_key_pair()
  end
end
