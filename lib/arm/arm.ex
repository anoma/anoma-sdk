defmodule AnomaSDK.Arm do
  @moduledoc """
  I define a few functions to test the ARM repo NIF interface.
  """

  mix_config = Mix.Project.config()
  version = mix_config[:version]
  github_url = mix_config[:package][:links]["GitHub"]

  use RustlerPrecompiled,
    otp_app: :anoma_sdk,
    crate: :arm_bindings,
    base_url: "#{github_url}/releases/download/v#{version}",
    version: version,
    force_build: System.get_env("BUILD_NATIVE") in ["1", "true"]

  alias AnomaSDK.Arm.ComplianceInstance
  alias AnomaSDK.Arm.ComplianceUnit
  alias AnomaSDK.Arm.ComplianceWitness
  alias AnomaSDK.Arm.DeltaProof
  alias AnomaSDK.Arm.DeltaWitness
  alias AnomaSDK.Arm.Keypair
  alias AnomaSDK.Arm.LogicVerifier
  alias AnomaSDK.Arm.LogicVerifierInputs
  alias AnomaSDK.Arm.Transaction

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

  @doc """
  Verifies that a transaction its proofs are valid.
  """
  @spec verify_transaction(Transaction.t()) :: boolean()
  def verify_transaction(_), do: :erlang.nif_error(:nif_not_loaded)
end
