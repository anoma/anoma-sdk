defmodule Anoma.Arm.ComplianceUnit do
  @moduledoc """
  I define the datastructure `ComplianceUnit` that defines the structure of a compliance unit for the resource machine.
  """
  use TypedStruct
  alias Anoma.Arm
  alias Anoma.Arm.ComplianceInstance
  alias Anoma.Arm.ComplianceUnit

  typedstruct do
    field :instance, binary()
    field :proof, binary()
  end

  defimpl Jason.Encoder, for: Anoma.Arm.ComplianceUnit do
    @spec encode(struct(), term()) :: term()
    def encode(struct, opts) do
      struct
      |> Map.from_struct()
      |> Enum.map(fn {k, v} -> {k, Base.encode64(v)} end)
      |> Enum.into(%{})
      |> Jason.Encode.map(opts)
    end
  end

  @spec from_map(map) :: t()
  def from_map(map) do
    struct(ComplianceUnit, Anoma.Json.decode_keys(map))
  end

  @doc """
  I return the compliance instance for this compliance unit.
  """
  @spec instance(t()) :: ComplianceInstance.t()
  def instance(compliance_unit) do
    Arm.compliance_unit_instance(compliance_unit)
  end
end
