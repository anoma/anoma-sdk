defmodule Anoma.Arm.MerkleTree do
  @moduledoc """
  I define the datastructure `MerkleTree` that defines the structure of a merkle tree for the resource machine.
  """
  use TypedStruct

  alias Anoma.Arm.Constants
  alias Anoma.Arm.Leaf
  alias Anoma.Arm.MerklePath
  alias Anoma.Arm.MerkleTree

  import Bitwise
  import Anoma.Util

  @action_tree_depth 4
  @action_tree_max_leaves 1 <<< @action_tree_depth

  typedstruct do
    field :leaves, [Leaf.t()]
  end

  @doc """
  Create a merkletree with the given leaves.
  """
  @spec new([Leaf.t()]) :: t()
  def new(leaves) do
    %MerkleTree{leaves: leaves}
  end

  @doc """
  Generate the path in the merkle tree for the given leaf.
  """
  @spec path_of(MerkleTree.t(), Leaf.t() | binary()) :: MerklePath.t()
  def path_of(tree, leaf) when is_binary(leaf) do
    path_of(tree, {bin2binlist(leaf)})
  end

  def path_of(%MerkleTree{} = tree, leaf) do
    tree = pad_tree(tree)
    position = Enum.find_index(tree.leaves, &(&1 == leaf))

    if position == nil do
      raise ArgumentError, message: "Leaf not found in tree"
    end

    path = generate_path(tree.leaves, position)
    %MerklePath{auth_path: path}
  end

  @spec generate_path([Leaf.t()], non_neg_integer()) :: [MerklePath.path_node()]
  def generate_path([_], _), do: []

  @spec generate_path(term(), term()) :: term()
  def generate_path(leaves, position) do
    sibling_on_my_left? = rem(position, 2) != 0

    # the leaves are stored from left to right, so the right-most leaf is in the last position.
    sibling =
      if sibling_on_my_left? do
        sibling = Enum.at(leaves, position - 1)
        {sibling, true}
      else
        sibling = Enum.at(leaves, position + 1)
        {sibling, false}
      end

    # construct the hashes of the previous layer
    # these are the hashes of each pairwise leaves
    previous_layer =
      leaves
      |> Enum.chunk_every(2)
      |> Enum.map(fn [{l1}, {l2}] ->
        # concat the two hashes into a 64 byte list.
        hashes = l1 ++ l2
        new_hash = :crypto.hash(:sha256, hashes)
        new_hash_list = bin2binlist(new_hash)
        {new_hash_list}
      end)

    [sibling | generate_path(previous_layer, div(position, 2))]
  end

  # ----------------------------------------------------------------------------#
  #                                Helpers                                     #
  # ----------------------------------------------------------------------------#

  @doc """
  Pads a merkle tree with padding leafs to its maximum size.
  """
  @spec pad_tree(MerkleTree.t()) :: MerkleTree.t()
  def pad_tree(merkle_tree) do
    case Enum.count(merkle_tree.leaves) do
      c when c < @action_tree_max_leaves ->
        padding = List.duplicate(Constants.padding_leaf(), @action_tree_max_leaves - c)
        %{merkle_tree | leaves: merkle_tree.leaves ++ padding}

      _ ->
        merkle_tree
    end
  end
end
