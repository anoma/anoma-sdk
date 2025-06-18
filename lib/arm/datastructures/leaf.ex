defmodule Anoma.Arm.Leaf do
  @moduledoc """
  I define the datastructure `Leaf` that defines the structure of a leaf in the merkle tree.
  """

  @type t :: {[byte()]}

  alias Anoma.Arm.Constants

  import Anoma.Util

  @doc """
  Generate a default leaf.
  """
  @spec default :: t()
  def default do
    # note: 32 here matches the value of DIGEST_BYTES
    Constants.padding_leaf()
  end

  @doc """
  Create a leaf from a binary.
  """
  @spec from(binary()) :: t()
  def from(binary) when is_binary(binary) do
    {bin2binlist(binary)}
  end
end
