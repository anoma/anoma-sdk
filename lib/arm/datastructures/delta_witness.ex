defmodule Anoma.Arm.DeltaWitness do
  @moduledoc """
  I define the datastructure `DeltaWitness` that defines the structure of a delta witness for the resource machine.
  """
  use TypedStruct

  alias Anoma.Arm.DeltaWitness

  typedstruct do
    field :signing_key, binary()
  end

  defimpl Jason.Encoder, for: Anoma.Arm.DeltaWitness do
    @spec encode(struct(), term()) :: term()
    def encode(struct, opts) do
      struct
      |> Anoma.Json.encode_keys([:signing_key])
      |> Jason.Encode.map(opts)
    end
  end

  @spec from_map(map) :: t()
  def from_map(map) do
    struct(DeltaWitness, Anoma.Json.decode_keys(map))
  end
end
