defmodule Anoma.Arm.DeltaProof do
  @moduledoc """
  I define the datastructure `DeltaWitness` that defines the structure of a delta witness for the resource machine.
  """
  use TypedStruct

  alias Anoma.Arm.DeltaProof

  typedstruct do
    field :signature, binary()
    field :recid, number()
  end

  defimpl Jason.Encoder, for: Anoma.Arm.DeltaProof do
    @spec encode(struct(), term()) :: term()
    def encode(struct, opts) do
      struct
      |> Anoma.Json.encode_keys([:signature])
      |> Jason.Encode.map(opts)
    end
  end

  @spec from_map(map) :: t()
  def from_map(map) do
    struct(DeltaProof, Anoma.Json.decode_keys(map, [:signature]))
  end
end
