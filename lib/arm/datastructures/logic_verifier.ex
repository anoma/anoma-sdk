defmodule Anoma.Arm.LogicVerifier do
  @moduledoc """
  I define the datastructure `Resource` that defines the structure of a resource for the resource machine.
  """
  use TypedStruct

  typedstruct do
    field :instance, binary()
    field :proof, binary()
    field :verifying_key, binary()
  end
end
