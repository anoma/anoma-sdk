defmodule Anoma.Arm do
  @moduledoc """
  I define a few functions to test the ARM repo NIF interface.
  """

  alias Anoma.Arm.ComplianceInstance
  alias Anoma.Arm.ComplianceUnit
  alias Anoma.Arm.ComplianceWitness
  alias Anoma.Arm.DeltaProof
  alias Anoma.Arm.DeltaWitness
  alias Anoma.Arm.LogicVerifier
  alias Anoma.Arm.LogicVerifierInputs
  alias Anoma.Arm.Transaction

  use Rustler,
    otp_app: :anoma_sdk,
    crate: :arm

  @doc """
  Generates a random private key (Scalar) and its corresponding public key (ProjectivePoint)
  """
  @spec random_key_pair :: {binary(), [byte()]}
  def random_key_pair, do: :erlang.nif_error(:nif_not_loaded)

  @doc """
  Proves a compliance witness and returns a compliance unit.
  """
  @spec prove(ComplianceWitness.t()) :: ComplianceUnit.t()
  def prove(_), do: :erlang.nif_error(:nif_not_loaded)

  # todo: this might be a simple byte operation and doesnt need a nif, checkout later
  @doc """
  Returns the compliance instance for a given compliance unit.
  """
  @spec unit_instance(ComplianceUnit.t()) :: ComplianceInstance.t()
  def unit_instance(_), do: :erlang.nif_error(:nif_not_loaded)

  @doc """
  Proves the given deltawitness
  """
  @spec prove_delta_witness(DeltaWitness.t(), [byte()]) :: DeltaProof.t()
  def prove_delta_witness(_, _), do: :erlang.nif_error(:nif_not_loaded)

  @doc """
  Encode a LogicVerifier into a LogicVerifierInputs struct.
  """
  @spec convert(LogicVerifier.t()) :: LogicVerifierInputs.t()
  def convert(_), do: :erlang.nif_error(:nif_not_loaded)

  @doc """
  Given a compliance instance, returns its delta message.
  """
  @spec generate_delta_proof(Transaction.t()) :: Transaction.t()
  def generate_delta_proof(_), do: :erlang.nif_error(:nif_not_loaded)
end
