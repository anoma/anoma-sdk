defmodule Anoma.Arm.Action do
  @moduledoc """
  I define the datastructure `Action` that defines the structure of an action for the resource machine.
  """
  use TypedStruct

  typedstruct do
    field :compliance_units, [term()]
    field :logic_proofs, [term()]
    field :resource_forwarder_calldata_pairs, [{term(), term()}]
  end
end
