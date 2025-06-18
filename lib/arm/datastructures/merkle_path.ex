defmodule Anoma.Arm.MerklePath do
  @moduledoc """
  I define the datastructure `MerklePath` that defines the structure of a merkle path.
  """
  use TypedStruct

  alias Anoma.Arm.Leaf
  alias Anoma.Arm.MerklePath

  @type path_node :: {Leaf.t(), boolean()}

  typedstruct do
    # the boolean indicates whether this leaf is left in the tree or not.
    field :auth_path, [path_node()]
  end

  @doc """
  Generate a default merkle tree with 32 empty leaves.
  """
  @spec default :: t()
  def default do
    # note: 32 here matches the value of COMMITMENT_TREE_DEPTH
    leaf = Leaf.default()
    auth_path = List.duplicate({leaf, false}, 32)

    %MerklePath{auth_path: auth_path}
  end
end
