defmodule Anoma.Arm.DeltaWitness do
  @moduledoc """
  I define the datastructure `DeltaWitness` that defines the structure of a delta witness for the resource machine.
  """
  use TypedStruct

  alias Anoma.Arm.DeltaWitness
  alias Anoma.Util

  typedstruct do
    field :signing_key, binary()
  end

  @doc """
  Given a list of delta witnesses, I compress them into a single delta witness.
  """
  @spec compress([DeltaWitness.t()]) :: DeltaWitness.t()
  def compress(delta_witnesses) do
    Enum.reduce(delta_witnesses, &compose/2)
  end

  @doc """
  Composing two delta witnesses means adding the two signing keys together as integers.
  """
  @spec compose(DeltaWitness.t(), DeltaWitness.t()) :: DeltaWitness.t()
  def compose(delta_witness, _other_delta_witness) do
    sum =
      :binary.decode_unsigned(delta_witness.signing_key) +
        :binary.decode_unsigned(delta_witness.signing_key)

    binary = Util.to_fixed_bitstring(sum)
    %DeltaWitness{signing_key: binary}
  end
end
