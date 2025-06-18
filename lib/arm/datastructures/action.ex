defmodule Anoma.Arm.Action do
  @moduledoc """
  I define the datastructure `Action` that defines the structure of an action
  for the resource machine.
  """
  use TypedStruct

  alias Anoma.Arm.ComplianceInstance
  alias Anoma.Arm.ComplianceUnit
  alias Anoma.Arm.DeltaProof
  alias Anoma.Arm.DeltaWitness

  typedstruct do
    @derive Jason.Encoder
    field :compliance_units, [ComplianceUnit.t()], default: []
    field :logic_verifier_inputs, [LogicVerifierInputs.t()], default: []
  end

  @doc """
  I return the delta message for the given action.
  """
  @spec delta_message(t()) :: [byte()]
  def delta_message(action) do
    action.compliance_units
    |> Enum.map(&ComplianceUnit.instance/1)
    |> Enum.flat_map(&ComplianceInstance.delta_message/1)
  end
end
