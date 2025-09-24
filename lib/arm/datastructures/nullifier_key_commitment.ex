defmodule AnomaSDK.Arm.NullifierKeyCommitment do
  @moduledoc """
  I define the datastructure `NullifierKeyCommitment` that defines the structure
  of a nullifierkey commitment for the resource machine.
  """

  alias AnomaSDK.Arm.NullifierKey

  @typedoc """
  The type of a nullifier key commitment.
  The length of the nullifier key commitment is 32 bytes.
  """
  @type t :: binary()

  @spec valid?(t()) :: boolean()
  def valid?(nkc), do: NullifierKey.valid?(nkc)
end
