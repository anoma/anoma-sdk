defmodule Anoma.Arm.ComplianceUnit do
  @moduledoc """
  I define the datastructure `ComplianceUnit` that defines the structure of a compliance unit for the resource machine.
  """
  use TypedStruct
  use Anoma.Arm.Inspect

  alias Anoma.Arm
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
end
