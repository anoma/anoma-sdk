defmodule Anoma.Arm.Transaction do
  @moduledoc """
  I define the datastructure `Transaction` that defines the structure of a transaction for the resource machine.
  """
  use TypedStruct

  alias Anoma.Arm
  alias Anoma.Arm.Action
  alias Anoma.Arm.DeltaProof
  alias Anoma.Arm.DeltaWitness
  alias Anoma.Arm.Transaction

  typedstruct do
    field :actions, [Action.t()], default: []
    field :delta_proof, {:proof, DeltaProof.t()} | {:witness, DeltaWitness.t()}
    field :expected_balance, binary(), default: <<>>
  end

  defimpl Jason.Encoder, for: Anoma.Arm.Transaction do
    @spec encode(struct(), term()) :: term()
    def encode(struct, opts) do
      delta_proof =
        case struct.delta_proof do
          {:proof, delta_proof} ->
            %{delta_proof: delta_proof}

          {:witness, witness} ->
            %{witness: witness}
        end

      struct
      |> Map.put(:delta_proof, delta_proof)
      |> Anoma.Json.encode_keys([:expected_balance])
      |> Jason.Encode.map(opts)
    end
  end

  @spec from_map(map) :: t()
  def from_map(map) do
    actions = Enum.map(map.actions, &Action.from_map/1)
    map = Anoma.Json.decode_keys(map, [:expected_balance])

    delta_proof =
      case map.delta_proof do
        %{delta_proof: delta_proof} ->
          {:proof, DeltaProof.from_map(delta_proof)}

        %{witness: witness} ->
          {:witness, DeltaWitness.from_map(witness)}
      end

    struct(Transaction, %{map | actions: actions, delta_proof: delta_proof})
  end

  @doc """
  Given a transaction where the `delta_proof` field is a `{:witness,
  DeltaWitness.t()}`, I generate the proof for that witness.

  I then replace the `:delta_proof` field with a `{:proof, DeltaProof.t()}`.
  """
  @spec generate_delta_proof(t()) :: t()
  def generate_delta_proof(%{delta_proof: {:proof, _}} = transaction) do
    transaction
  end

  @doc false
  def generate_delta_proof(%{delta_proof: {:witness, _}} = transaction) do
    Arm.generate_delta_proof(transaction)
  end
end
