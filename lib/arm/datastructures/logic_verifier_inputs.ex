defmodule AnomaSDK.Arm.LogicVerifierInputs do
  @moduledoc """
  I define the datastructure `LogicVerifierInput` that defines the structure of
  a logic verifier input for the resource machine.
  """
  use TypedStruct

  alias AnomaSDK.Arm.AppData
  alias AnomaSDK.Arm.LogicVerifierInputs

  typedstruct do
    field :tag, binary()
    field :verifying_key, binary()
    field :app_data, AppData.t()
    field :proof, binary()
  end

  defimpl Jason.Encoder, for: AnomaSDK.Arm.LogicVerifierInputs do
    @spec encode(struct(), term()) :: term()
    def encode(struct, opts) do
      struct
      |> AnomaSDK.Json.encode_keys([:tag, :verifying_key, :proof])
      |> Jason.Encode.map(opts)
    end
  end

  defimpl AnomaSDK.Validate, for: __MODULE__ do
    @impl true
    def valid?(term) do
      is_binary(term.tag) &&
        is_binary(term.verifying_key) &&
        AnomaSDK.Validate.valid?(term.app_data) &&
        is_binary(term.proof)
    end
  end

  @spec from_map(map) :: t()
  def from_map(map) do
    map =
      map
      |> Map.update!(:app_data, &AppData.from_map(&1))
      |> AnomaSDK.Json.decode_keys([:tag, :verifying_key, :proof])

    struct(LogicVerifierInputs, map)
  end
end
