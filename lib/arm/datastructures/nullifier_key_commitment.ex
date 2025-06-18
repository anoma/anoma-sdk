defmodule Anoma.Arm.NullifierKeyCommitment do
  @moduledoc """
  I define the datastructure `NullifierKeyCommitment` that defines the structure
  of a nullifierkey commitment for the resource machine.
  """

  @typedoc """
  The type of a nullifier key commitment.  32 bytes.

  This is a tuple to map properly on the NIF struct.
  """
  @type t :: {[byte()]}
end
