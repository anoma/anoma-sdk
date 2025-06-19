defmodule Anoma.Arm.Delta do
  @moduledoc """
  I define the datastructure `DeltaWitness` that defines the structure of a delta witness for the resource machine.
  """
  use TypedStruct

  typedstruct do
    field :witness, term()
    field :proof, term()
  end
end
