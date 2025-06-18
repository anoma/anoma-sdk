defmodule Anoma.Arm do
  @moduledoc """
  I define a few functions to test the ARM repo NIF interface.
  """

  alias Anoma.Arm.ComplianceInstance
  alias Anoma.Arm.ComplianceUnit
  alias Anoma.Arm.ComplianceWitness
  alias Anoma.Arm.DeltaProof
  alias Anoma.Arm.DeltaWitness
  alias Anoma.Arm.Keypair
  alias Anoma.Arm.LogicVerifier
  alias Anoma.Arm.LogicVerifierInputs
  alias Anoma.Arm.Transaction

  use Rustler,
    otp_app: :anoma_sdk,
    crate: :arm

  @doc """
  Generates a random private key (Scalar) and its corresponding public key (ProjectivePoint)
  """
  @spec random_key_pair :: Keypair.t()
  def random_key_pair, do: :erlang.nif_error(:nif_not_loaded)

  @doc """
    Encrypt a cipher.
  """
  @spec encrypt_cipher([byte()], Keypair.t(), [byte()]) :: [byte()]
  def encrypt_cipher(_, _, _), do: :erlang.nif_error(:nif_not_loaded)

  @doc """
  Decrypt a ciphertext using a private key and public key.
  """
  @spec decrypt_cipher([byte()], Keypair.t()) :: [byte()]
  def decrypt_cipher(_, _), do: :erlang.nif_error(:nif_not_loaded)

  @doc """
  Returns the compliance instance for a given compliance unit.
  """
  @spec compliance_unit_instance(ComplianceUnit.t()) :: ComplianceInstance.t()
  def compliance_unit_instance(_), do: :erlang.nif_error(:nif_not_loaded)

  @doc """
  Proves a compliance witness and returns a compliance unit.
  """
  @spec prove_compliance_witness(ComplianceWitness.t()) :: ComplianceUnit.t()
  def prove_compliance_witness(_), do: :erlang.nif_error(:nif_not_loaded)

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
