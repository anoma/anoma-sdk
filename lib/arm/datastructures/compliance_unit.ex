defmodule Anoma.Arm.ComplianceUnit do
  @moduledoc """
  I define the datastructure `ComplianceUnit` that defines the structure of a compliance unit for the resource machine.
  """
  use TypedStruct
  alias Anoma.Arm
  alias Anoma.Arm.ComplianceInstance

  typedstruct do
    field :instance, binary()
    field :proof, binary()
  end

  @doc """
  I return the compliance instance for this compliance unit.
  """
  @spec instance(t()) :: ComplianceInstance.t()
  def instance(compliance_unit) do
    Arm.compliance_unit_instance(compliance_unit)
  end
end
