defmodule Anoma.Arm.DeltaProof do
  @moduledoc """
  I define the datastructure `DeltaWitness` that defines the structure of a delta witness for the resource machine.
  """
  use TypedStruct

  typedstruct do
    field :signature, binary()
    field :recid, number()
  end
end
