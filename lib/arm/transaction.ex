defmodule Anoma.Arm.Transaction do
  @moduledoc """
  I define the datastructure `Transaction` that defines the structure of a transaction for the resource machine.
  """
  use TypedStruct

  alias Anoma.Arm.Action
  alias Anoma.Arm.DeltaProof
  alias Anoma.Arm.DeltaWitness

  typedstruct do
    field :actions, [Action.t()]
    field :delta_proof, {:proof, DeltaProof.t()} | {:witness, DeltaWitness.t()}
  end
end
