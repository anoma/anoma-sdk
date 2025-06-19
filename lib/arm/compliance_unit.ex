defmodule Anoma.Arm.ComplianceUnit do
  @moduledoc """
  I define the datastructure `ComplianceUnit` that defines the structure of a compliance unit for the resource machine.
  """
  use TypedStruct

  typedstruct do
    field :instance, [byte()]
    field :proof, [byte()]
  end
end
