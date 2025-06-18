defmodule Anoma.Arm.DeltaWitness do
  @moduledoc """
  I define the datastructure `DeltaWitness` that defines the structure of a delta witness for the resource machine.
  """
  use TypedStruct

  typedstruct do
    field :signing_key, binary()
  end
end
