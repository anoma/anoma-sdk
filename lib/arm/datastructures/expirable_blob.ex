defmodule Anoma.Arm.ExpirableBlob do
  @moduledoc """
  I define the datastructure `ExpirableBlob` that defines the structure of an expirable blob
  for the resource machine.
  """
  use TypedStruct

  alias Anoma.Arm.ExpirableBlob

  typedstruct do
    field :blob, binary()
    field :deletion_criteria, number()
  end

  defimpl Jason.Encoder, for: Anoma.Arm.ExpirableBlob do
    @spec encode(struct(), term()) :: term()
    def encode(struct, opts) do
      struct
      |> Anoma.Json.encode_keys([:blob])
      |> Jason.Encode.map(opts)
    end
  end

  @spec from_map(map) :: t()
  def from_map(map) do
    struct(ExpirableBlob, Anoma.Json.decode_keys(map, [:blob]))
  end
end
