defmodule Anoma.Arm.LogicProof do
  @moduledoc """
  I define the datastructure `Resource` that defines the structure of a resource for the resource machine.
  """
  use TypedStruct

  typedstruct do
    field :instance, [byte()]
    field :proof, [byte()]
    field :verifying_key, [byte()]
  end
end
