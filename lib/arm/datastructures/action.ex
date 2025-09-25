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

  defimpl AnomaSDK.Validate, for: __MODULE__ do
    @impl true
    def valid?(term) do
      is_list(term.compliance_units) &&
        is_list(term.logic_verifier_inputs) &&
        Enum.all?(term.compliance_units, &AnomaSDK.Validate.valid?/1) &&
        Enum.all?(term.logic_verifier_inputs, &AnomaSDK.Validate.valid?/1)
    end
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
