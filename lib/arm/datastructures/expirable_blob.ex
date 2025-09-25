defmodule AnomaSDK.Arm.ExpirableBlob do
  @moduledoc """
  I define the datastructure `ExpirableBlob` that defines the structure of an expirable blob
  for the resource machine.
  """
  use TypedStruct

  alias AnomaSDK.Arm.ExpirableBlob

  typedstruct do
    field :blob, binary()
    field :deletion_criteria, number()
  end

  defimpl Jason.Encoder, for: AnomaSDK.Arm.ExpirableBlob do
    @spec encode(struct(), term()) :: term()
    def encode(struct, opts) do
      struct
      |> AnomaSDK.Json.encode_keys([:blob])
      |> Jason.Encode.map(opts)
    end
  end

  defimpl AnomaSDK.Validate, for: __MODULE__ do
    @impl true
    def valid?(blob) do
      is_binary(blob.blob) && is_number(blob.deletion_criteria)
    end
  end

  @spec from_map(map) :: t()
  def from_map(map) do
    struct(ExpirableBlob, AnomaSDK.Json.decode_keys(map, [:blob]))
  end
end
