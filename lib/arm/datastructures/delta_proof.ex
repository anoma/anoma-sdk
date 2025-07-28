defmodule Anoma.Arm.DeltaProof do
  @moduledoc """
  I define the datastructure `DeltaWitness` that defines the structure of a delta witness for the resource machine.
  """
  use TypedStruct

  alias Anoma.Arm.DeltaProof

  typedstruct do
    field :signature, binary()
    field :recid, binary()
  end

  # ----------------------------------------------------------------------------
  # JSON encoding

  # Encoding a LogicProof means that the proof, verifying_key and the instance
  # have to be represented as hexadecimal strings of the binaries.
  defimpl Jason.Encoder, for: [DeltaProof] do
    @spec encode(DeltaProof.t(), Jason.Encode.opts()) :: iodata()
    def encode(struct, opts) do
      struct
      |> Map.drop([:__struct__])
      |> Map.update!(:signature, &Base.encode16/1)
      |> Map.update!(:recid, &Base.encode16/1)
      |> Jason.Encode.map(opts)
    end
  end
end
