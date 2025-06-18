defmodule Anoma.Arm.MerklePath do
  @moduledoc """
  I define the datastructure `MerklePath` that defines the structure of a merkle path.
  """
  use TypedStruct

  @type path_node :: {[byte()], boolean()}

  @type t :: {[path_node()]}

  @doc """
  Generate a default merkle tree with 32 empty leaves.
  """
  @spec default :: t()
  def default do
    # note: 32 here matches the value of COMMITMENT_TREE_DEPTH
    leaf = List.duplicate(0, 8)
    auth_path = List.duplicate({leaf, false}, 32)

    {auth_path}
  end
end
