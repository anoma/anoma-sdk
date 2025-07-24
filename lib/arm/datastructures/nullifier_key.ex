defmodule Anoma.Arm.NullifierKey do
  @moduledoc """
  I define the datastructure `NullifierKey` that defines the structure of a nullifierkey for the resource machine.
  """
  use TypedStruct

  alias Anoma.Arm.NullifierKey
  alias Anoma.Arm.NullifierKeyCommitment

  @typedoc """
  The type of a nullifierkey.  32 bytes.

  This is a tuple to map properly on the NIF struct.
  """
  @type t :: {[byte()]}

  @doc """
  Generate a nullifier key with all zeros.
  """
  @spec default :: NullifierKey.t()
  def default do
    {List.duplicate(0, 32)}
  end

  @doc """
  Generate a new nullifier key based on 32 bytes.
  """
  @spec new(<<_::256>>) :: NullifierKey.t()
  def new(bytes) do
    bin_list = :binary.bin_to_list(bytes)
    {bin_list}
  end

  @doc """
  Create a commitment for the given nullifier key.
  """
  @spec commit(NullifierKey.t()) :: NullifierKeyCommitment.t()
  def commit({bin_list}) do
    hash = :crypto.hash(:sha256, bin_list)
    hash_bin_list = :binary.bin_to_list(hash)
    {hash_bin_list}
  end

  @doc """
  Create a random pair of keys
  """
  @spec random_pair :: {NullifierKey.t(), NullifierKeyCommitment.t()}
  def random_pair do
    bytes = :crypto.strong_rand_bytes(32)
    key = new(bytes)
    commitment = commit(key)
    {key, commitment}
  end
end
