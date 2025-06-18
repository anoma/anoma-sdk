defmodule Anoma.Arm.MerklePath do
  @moduledoc """
  I define the datastructure `MerklePath` that defines the structure of a merkle path.
  """
  use TypedStruct

  @type path_node :: {binary(), boolean()}

  @type t :: [path_node()]

  @doc """
  Generate a default merkle tree with 32 empty leaves.
  """
  @spec default :: t()
  def default do
    List.duplicate({<<0::8*32>>, false}, 32)
  end
end
