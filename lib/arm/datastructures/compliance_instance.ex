defmodule Anoma.Arm.ComplianceInstance do
  @moduledoc """
  I define the datastructure `ComplianceInstance` that defines the structure of
  a compliance instance for the resource machine.
  """
  use TypedStruct
  use Anoma.Arm.Inspect
  alias Anoma.Arm.ComplianceInstance

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
      |> tap(&IO.inspect(&1, label: ""))
      |> Jason.Encode.map(opts)
    end
  end

  @spec from_map(map) :: t()
  def from_map(map) do
    struct(ComplianceInstance, Anoma.Json.decode_keys(map))
  end
end
