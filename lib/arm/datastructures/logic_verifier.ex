defmodule AnomaSDK.Arm.LogicVerifier do
  @moduledoc """
  I define the datastructure `Resource` that defines the structure of a resource for the resource machine.
  """
  use TypedStruct
  alias AnomaSDK.Arm.LogicVerifier

  typedstruct do
    field :instance, binary()
    field :proof, binary()
    field :verifying_key, binary()
  end

  defimpl Jason.Encoder, for: AnomaSDK.Arm.LogicVerifier do
    @spec encode(struct(), term()) :: term()
    def encode(struct, opts) do
      struct
      |> AnomaSDK.Json.encode_keys()
      |> Jason.Encode.map(opts)
    end
  end

  @spec from_map(map) :: t()
  def from_map(map) do
    struct(LogicVerifier, AnomaSDK.Json.decode_keys(map))
  end
end
