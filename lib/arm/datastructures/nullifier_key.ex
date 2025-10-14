defmodule Anoma.Arm.NullifierKey do
  @moduledoc """
  I define the datastructure `NullifierKey` that defines the structure of a nullifierkey for the resource machine.
  """
  use TypedStruct

  alias Anoma.Arm.NullifierKey
  alias Anoma.Arm.NullifierKeyCommitment

  @typedoc """
  The type of a nullifierkey.
  The length of a nullifier key is 32 bytes.
  """
  @type t :: binary()

  @doc """
  Generate a nullifier key with all zeros.
  """
  @spec default :: NullifierKey.t()
  def default do
    <<0::8*32>>
  end

  @doc """
  Create a commitment for the given nullifier key.
  """
  @spec commit(NullifierKey.t()) :: NullifierKeyCommitment.t()
  def commit(binary) do
    :crypto.hash(:sha256, binary)
  end

  @doc """
  Create a random pair of keys
  """
  @spec random_pair :: {NullifierKey.t(), NullifierKeyCommitment.t()}
  def random_pair do
    key = :crypto.strong_rand_bytes(32)
    commitment = commit(key)
    {key, commitment}
  end
end
