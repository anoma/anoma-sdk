defmodule Anoma.Arm.MerklePath do
  @moduledoc """
  I define the datastructure `MerklePath` that defines the structure of a merkle path.
  """
  use TypedStruct

  typedstruct do
    field :auth_path, [{Leaf.t(), boolean()}]
  end
end
