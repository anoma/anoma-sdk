defmodule Anoma.Arm.Transaction do
  @moduledoc """
  I define the datastructure `Transaction` that defines the structure of a transaction for the resource machine.
  """
  use TypedStruct

  alias Anoma.Arm
  alias Anoma.Arm.Action
  alias Anoma.Arm.DeltaProof
  alias Anoma.Arm.DeltaWitness

  typedstruct do
    field :actions, [Action.t()]
    field :delta_proof, {:proof, DeltaProof.t()} | {:witness, DeltaWitness.t()}
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
    {:witness, witness} = transaction.delta_proof
    message = delta_message(transaction)
    proof = Arm.prove_delta_witness(witness, message)
    %{transaction | delta_proof: {:proof, proof}}
  end

  @doc """
  I return the delta message for this transaction.
  """
  @spec delta_message(t()) :: term()
  def delta_message(transaction) do
    transaction.actions
    |> Enum.flat_map(&Action.delta_message/1)
  end
end
