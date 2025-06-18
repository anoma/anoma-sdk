defmodule AnomaSDK.Arm.Action do
  @moduledoc """
  I define the datastructure `Action` that defines the structure of an action
  for the resource machine.
  """
  use TypedStruct

  alias AnomaSDK.Arm.Action
  alias AnomaSDK.Arm.ComplianceUnit
  alias AnomaSDK.Arm.LogicVerifierInputs

  typedstruct do
    @derive Jason.Encoder
    field :compliance_units, [ComplianceUnit.t()], default: []
    field :logic_verifier_inputs, [LogicVerifierInputs.t()], default: []
  end

  @spec from_map(map) :: t()
  def from_map(map) do
    map =
      map
      |> Map.update(:compliance_units, [], fn x -> Enum.map(x, &ComplianceUnit.from_map/1) end)
      |> Map.update(:logic_verifier_inputs, [], fn x ->
        Enum.map(x, &LogicVerifierInputs.from_map/1)
      end)

    struct(Action, map)
  end
end
