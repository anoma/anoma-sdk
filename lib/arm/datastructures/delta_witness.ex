defmodule AnomaSDK.Arm.DeltaWitness do
  @moduledoc """
  I define the datastructure `DeltaWitness` that defines the structure of a delta witness for the resource machine.
  """
  use TypedStruct

  alias AnomaSDK.Arm.DeltaWitness

  typedstruct do
    field :signing_key, binary()
  end

  defimpl Jason.Encoder, for: AnomaSDK.Arm.DeltaWitness do
    @spec encode(struct(), term()) :: term()
    def encode(struct, opts) do
      struct
      |> AnomaSDK.Json.encode_keys([:signing_key])
      |> Jason.Encode.map(opts)
    end
  end

  @spec from_map(map) :: t()
  def from_map(map) do
    struct(DeltaWitness, AnomaSDK.Json.decode_keys(map))
  end
end
