defmodule Anoma.Examples.Counter do
  @moduledoc """
  Example application for the Anoma ARM.
  """

  alias Anoma.Arm.NullifierKey
  alias Anoma.Util
  alias Anoma.Arm.Resource

  import Anoma.Util

  @doc """
  Create a new ephemeral counter.

  A counter is represented by its owner, and a unique label.
  """
  def create_ephemeral_counter do
    {key, commitment} = NullifierKey.random_pair()

    # Create a counter resource
    resource = %Resource{
      logic_ref: nil,
      label_ref: randombinlist(32),
      quantity: 1,
      value_ref: Util.bin2binlist(Util.pad_bitstring(<<0>>, 32)),
      is_ephemeral: true,
      nonce: Util.randombinlist(32),
      nk_commitment: commitment
    }

    {resource, key}
  end
end
