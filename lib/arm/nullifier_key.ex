defmodule Anoma.Arm.NullifierKey do
  @moduledoc """
  I define the datastructure `NullifierKey` that defines the structure of a nullifierkey for the resource machine.
  """
  use TypedStruct

  use AnomaSdk

  @doc """
  Generate a new nullifier key based on 32 bytes.
  """
  @spec new(<<_::256>>) :: nullifier_key()
  def new(bytes) do
    bin_list = :binary.bin_to_list(bytes)
    {bin_list}
  end

  @doc """
  Create a commitment for the given nullifier key.
  """
  @spec commit(nullifier_key()) :: nullifier_key_commitment()
  def commit({bin_list}) do
    hash = :crypto.hash(:sha256, bin_list)
    hash_bin_list = :binary.bin_to_list(hash)
    {hash_bin_list}
  end

  @doc """
  Generate a random nullifier key and its commitment.
  """
  @spec random_pair :: {nullifier_key(), nullifier_key_commitment()}
  def random_pair do
    bytes = :crypto.strong_rand_bytes(32)
    key = new(bytes)
    commitment = commit(key)
    {key, commitment}
  end
end
