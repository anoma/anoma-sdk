defmodule AnomaSDK.Arm.ComplianceInstance do
  @moduledoc """
  I define the datastructure `ComplianceInstance` that defines the structure of
  a compliance instance for the resource machine.
  """
  use TypedStruct
  use AnomaSDK.Arm.Inspect
  alias AnomaSDK.Arm.ComplianceInstance

  typedstruct do
    field :consumed_nullifier, binary()
    field :consumed_logic_ref, binary()
    field :consumed_commitment_tree_root, binary()
    field :created_commitment, binary()
    field :created_logic_ref, binary()
    field :delta_x, binary()
    field :delta_y, binary()
  end

  defimpl Jason.Encoder, for: ComplianceInstance do
    @spec encode(struct(), term()) :: term()
    def encode(struct, opts) do
      struct
      |> Map.from_struct()
      |> Enum.map(fn {k, v} -> {k, Base.encode64(v)} end)
      |> Enum.into(%{})
      |> Jason.Encode.map(opts)
    end
  end

  defimpl AnomaSDK.Validate, for: __MODULE__ do
    @impl true
    def valid?(term) do
      is_binary(term.consumed_nullifier) &&
        is_binary(term.consumed_logic_ref) &&
        is_binary(term.consumed_commitment_tree_root) &&
        is_binary(term.created_commitment) &&
        is_binary(term.created_logic_ref) &&
        is_binary(term.delta_x) &&
        is_binary(term.delta_y)
    end
  end

  @spec from_map(map) :: t()
  def from_map(map) do
    struct(ComplianceInstance, AnomaSDK.Json.decode_keys(map))
  end
end
