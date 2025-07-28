defmodule Anoma.Arm.LogicProof do
  @moduledoc """
  I define the datastructure `Resource` that defines the structure of a resource for the resource machine.
  """
  use TypedStruct

  alias Anoma.Arm.LogicProof

  import Anoma.Util

  typedstruct do
    field :instance, [byte()]
    field :proof, [byte()]
    field :verifying_key, [byte()]
  end

  # ----------------------------------------------------------------------------
  # JSON encoding

  # Encoding a LogicProof means that the proof, verifying_key and the instance
  # have to be represented as hexadecimal strings of the binaries.
  defimpl Jason.Encoder, for: [LogicProof] do
    @spec encode(LogicProof.t(), Jason.Encode.opts()) :: iodata()
    def encode(struct, opts) do
      struct
      |> Map.drop([:__struct__])
      |> Map.update(:instance, "", &Base.encode16(binlist2bin(&1)))
      |> Map.update(:proof, "", &Base.encode16(binlist2bin(&1)))
      |> Map.update(:verifying_key, "", &Base.encode16(binlist2bin(&1)))
      |> Jason.Encode.map(opts)
    end
  end
end
