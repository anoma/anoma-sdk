defmodule Anoma.Arm.ComplianceUnit do
  @moduledoc """
  I define the datastructure `ComplianceUnit` that defines the structure of a compliance unit for the resource machine.
  """
  use TypedStruct
  use Anoma.Arm.Inspect

  alias Anoma.Arm
  alias Anoma.Arm.ComplianceInstance
  alias Anoma.Arm.ComplianceUnit

  import Anoma.Util
  alias Anoma.Arm.ComplianceInstance

  typedstruct do
    field :instance, [byte()]
    field :proof, [byte()]
  end

  @doc """
  I return the compliance instance for this compliance unit.
  """
  @spec instance(t()) :: ComplianceInstance.t()
  def instance(compliance_unit) do
    Arm.unit_instance(compliance_unit)
  end

  # ----------------------------------------------------------------------------
  # JSON encoding

  # Encoding a ComplianceUnit means that the proof and the instance have to be
  # represented as hexadecimal strings of the binaries.
  defimpl Jason.Encoder, for: [ComplianceUnit] do
    @doc false
    @spec encode(ComplianceUnit.t(), Jason.Encode.opts()) :: iodata()
    def encode(struct, opts) do
      struct
      |> Map.drop([:__struct__])
      |> Map.update(:proof, "", &Base.encode16(binlist2bin(&1)))
      |> Map.update(:instance, "", &Base.encode16(binlist2bin(&1)))
      |> Jason.Encode.map(opts)
    end
  end
end
