defmodule AnomaSDK.Arm.MerklePath do
  @moduledoc """
  I define the datastructure `MerklePath` that defines the structure of a merkle path.
  """
  use TypedStruct

  alias AnomaSDK.Arm.MerkleTree

  @type path_node :: {binary(), boolean()}

  @type t :: [path_node()]

  @doc """
  Generate a default merkle tree with 32 empty leaves.
  """
  @spec default :: t()
  def default do
    List.duplicate({<<0::8*32>>, false}, 10)
  end

  @spec valid?(t()) :: boolean()
  def valid?(path) do
    is_list(path) &&
      Enum.all?(
        path,
        fn {hash, left?} -> MerkleTree.leaf_valid?(hash) && is_boolean(left?) end
      )
  end

  @spec to_map(map) :: [map()]
  def to_map(merkle_path) do
    Enum.map(merkle_path, fn {node, left} ->
      %{node: Base.encode64(node), left: left}
    end)
  end

  @spec from_map(map) :: t()
  def from_map(maps) do
    Enum.map(maps, fn map ->
      {Base.decode64!(map.node), map.left}
    end)
  end
end
