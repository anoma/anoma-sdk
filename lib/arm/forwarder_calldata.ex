defmodule Anoma.Arm.ForwarderCalldata do
  @moduledoc """
  I define the datastructure `Resource` that defines the structure of a resource for the resource machine.
  """
  use TypedStruct

  typedstruct do
    field :signing_key, term()
  end
end
