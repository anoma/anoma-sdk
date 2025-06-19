defmodule Anoma.Arm.Action do
  @moduledoc """
  I define the datastructure `Action` that defines the structure of an action for the resource machine.
  """
  use TypedStruct

  alias Anoma.Arm.DeltaProof
  alias Anoma.Arm.DeltaWitness

  typedstruct do
    field :compliance_units, [term()]
    field :logic_proofs, [term()]

    field :resource_forwarder_calldata_pairs, [
      {:proof, DeltaProof.t()} | {:witness, DeltaWitness.t()}
    ]
  end
end
