defmodule Anoma.Arm.MerklePath do
  @moduledoc """
  I define the datastructure `MerklePath` that defines the structure of a merkle path.
  """
  use TypedStruct

  alias Anoma.Arm.MerklePath

  @type path_node :: {[byte()], boolean()}

  typedstruct do
    @derive {Jason.Encoder, except: [:auth_path]}
    # the boolean indicates whether this leaf is left in the tree or not.
    field :auth_path, [path_node()]
  end

  @doc """
  Generate a default merkle tree with 32 empty leaves.
  """
  @spec default :: t()
  def default do
    # note: 32 here matches the value of COMMITMENT_TREE_DEPTH
    leaf = List.duplicate(0, 8)
    auth_path = List.duplicate({leaf, false}, 32)

    %MerklePath{auth_path: auth_path}
  end

  # ----------------------------------------------------------------------------
  # JSON encoding

  # Encoding a LogicProof means that the proof, verifying_key and the instance
  # have to be represented as hexadecimal strings of the binaries.
  defimpl Jason.Encoder, for: [MerklePath] do
    # encode a node as a path for json
    defp encode_node({bytes, boolean}) do
      %{node: bytes, left: boolean}
    end

    @doc false
    @spec encode(MerklePath.t(), Jason.Encode.opts()) :: iodata()
    def encode(struct, opts) do
      struct
      |> Map.update(:auth_path, fn ns -> Enum.map(ns, &encode_node/1) end)
      |> Map.drop([:__struct__])
      |> Jason.Encode.map(opts)
    end
  end
end
