defmodule AnomaSDK.Arm.DeltaProof do
  @moduledoc """
  I define the datastructure `DeltaWitness` that defines the structure of a delta witness for the resource machine.
  """
  use TypedStruct

  alias AnomaSDK.Arm.DeltaProof

  typedstruct do
    field :signature, binary()
    field :recid, number()
  end

  defimpl Jason.Encoder, for: AnomaSDK.Arm.DeltaProof do
    @spec encode(struct(), term()) :: term()
    def encode(struct, opts) do
      struct
      |> AnomaSDK.Json.encode_keys([:signature])
      |> Jason.Encode.map(opts)
    end
  end

  defimpl AnomaSDK.Validate, for: __MODULE__ do
    @impl true
    def valid?(term) do
      is_binary(term.signature) &&
        is_number(term.recid)
    end
  end

  @spec from_map(map) :: t()
  def from_map(map) do
    struct(DeltaProof, AnomaSDK.Json.decode_keys(map, [:signature]))
  end
end
