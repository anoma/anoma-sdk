defmodule AnomaSDK.Arm.Keypair do
  @moduledoc """
  I define the datastructure `Keypair` that holds a public key and a private key.
  """
  use TypedStruct

  alias AnomaSDK.Arm
  alias AnomaSDK.Arm.Keypair

  typedstruct do
    field :secret_key, binary()
    field :public_key, binary()
  end

  defimpl Jason.Encoder, for: AnomaSDK.Arm.Keypair do
    @spec encode(struct(), term()) :: term()
    def encode(struct, opts) do
      struct
      |> AnomaSDK.Json.encode_keys([:secret_key, :public_key])
      |> Jason.Encode.map(opts)
    end
  end

  defimpl AnomaSDK.Validate, for: __MODULE__ do
    @impl true
    def valid?(term) do
      Keypair.valid_secret?(term.secret_key) && Keypair.valid_public?(term.public_key)
    end
  end

  # I add these two functions due to the secret being used

  @spec valid_secret?(t()) :: boolean()
  def valid_secret?(secret_key) do
    is_binary(secret_key)
  end

  @spec valid_public?(t()) :: boolean()
  def valid_public?(public_key) do
    is_binary(public_key)
  end

  @spec from_map(map) :: t()
  def from_map(map) do
    struct(Keypair, AnomaSDK.Json.decode_keys(map))
  end

  @doc """
  Generate a random keypair.
  """
  @spec random :: t()
  def random do
    Arm.random_key_pair()
  end
end
