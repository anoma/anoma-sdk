defmodule Anoma.Arm.Action do
  @moduledoc """
  I define the datastructure `Action` that defines the structure of an action
  for the resource machine.
  """
  use TypedStruct

  alias Anoma.Arm.ComplianceUnit
  alias Anoma.Arm.LogicVerifierInputs

  typedstruct do
    field :compliance_units, [ComplianceUnit.t()], default: []
    field :logic_verifier_inputs, [LogicVerifierInputs.t()], default: []
  end
end
