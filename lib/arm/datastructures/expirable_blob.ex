defmodule Anoma.Arm.ExpirableBlob do
  @moduledoc """
  I define the datastructure `ExpirableBlob` that defines the structure of an expirable blob
  for the resource machine.
  """
  use TypedStruct

  typedstruct do
    @derive Jason.Encoder
    field :blob, binary()
    field :deletion_criteria, number()
  end
end
