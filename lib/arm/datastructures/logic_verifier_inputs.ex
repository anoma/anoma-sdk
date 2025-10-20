defmodule Anoma.Arm.LogicVerifierInputs do
  @moduledoc """
  I define the datastructure `LogicVerifierInput` that defines the structure of
  a logic verifier input for the resource machine.
  """
  use TypedStruct

  alias Anoma.Arm.AppData
  alias Anoma.Arm.LogicVerifierInputs

  typedstruct do
    field :tag, binary()
    field :verifying_key, binary()
    field :app_data, AppData.t()
    field :proof, binary()
  end

  defimpl Jason.Encoder, for: Anoma.Arm.LogicVerifierInputs do
    @spec encode(struct(), term()) :: term()
    def encode(struct, opts) do
      struct
      |> Anoma.Json.encode_keys([:tag, :verifying_key, :proof])
      |> Jason.Encode.map(opts)
    end
  end

  @spec from_map(map) :: t()
  def from_map(map) do
    map =
      map
      |> Map.update!(:app_data, &AppData.from_map(&1))
      |> Anoma.Json.decode_keys([:tag, :verifying_key, :proof])

    struct(LogicVerifierInputs, map)
  end
end
