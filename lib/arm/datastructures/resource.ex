defmodule Anoma.Arm.Resource do
  @moduledoc """
  I define the datastructure `Resource` that defines the structure of a resource for the resource machine.
  """
  use TypedStruct

  alias Anoma.Arm.NullifierKey
  alias Anoma.Arm.NullifierKeyCommitment
  import Anoma.Util

  typedstruct do
    @derive {Jason.Encoder, except: [:nk_commitment]}
    field :logic_ref, binary()
    field :label_ref, binary()
    field :quantity, number()
    field :value_ref, binary()
    field :is_ephemeral, bool
    field :nonce, binary()
    field :nk_commitment, NullifierKeyCommitment.t()
    field :rand_seed, binary(), default: :crypto.strong_rand_bytes(32)
  end

  @doc """
  Compute the commitment to the resource.
  """
  @spec commitment(t()) :: binary()
  def commitment(resource) do
    # pad the quantity with the bytes defined as QUANTITY_BYTES in aarm_core
    quantity_bytes =
      resource.quantity
      |> :binary.encode_unsigned()
      |> pad_bitstring(16)

    # construct a binary of RESOURCE_BYTES size (209)
    bytes =
      resource.logic_ref <>
        resource.label_ref <>
        quantity_bytes <>
        resource.value_ref <>
        if(resource.is_ephemeral, do: <<1>>, else: <<0>>) <>
        resource.nonce <>
        resource.nk_commitment <>
        rcm(resource)

    if byte_size(bytes) != 209 do
      raise ArgumentError, message: "commitment expected to be 209 bytes"
    end

    :crypto.hash(:sha256, bytes)
  end

  @doc """
  Return the nullifier for this resource.
  """
  @spec nullifier(t(), NullifierKey.t()) :: binary()
  def nullifier(resource, nullifier_key) do
    commitment = commitment(resource)
    nullifier_from_commitment(resource, nullifier_key, commitment)
  end

  @doc """
  Generate the nullifier from a commitment.
  """
  @spec nullifier_from_commitment(t(), NullifierKey.t(), binary()) :: binary()
  def nullifier_from_commitment(resource, nullifier_key, commitment) do
    key_commitment = NullifierKey.commit(nullifier_key)

    if resource.nk_commitment != key_commitment do
      raise ArgumentError,
        message:
          "Resource nullifier key commitment differs from the commitment derived from the nullifier key."
    end

    # construct a binary of RESOURCE_BYTES size (209)
    bytes =
      nullifier_key <>
        resource.nonce <>
        psi(resource) <>
        commitment

    if byte_size(bytes) != 128 do
      raise ArgumentError, message: "commitment expected to be 209 bytes"
    end

    :crypto.hash(:sha256, bytes)
  end

  # @doc """
  # Generate the commitment for this resource
  # """
  # def nullifier(nullifier_key) do
  # end

  # this maps onto the constant PRF_EXPAND_RCM
  @prf_expand_rcm <<1>>

  # this maps onto the value for the constant PRF_EXPAND_PERSONALIZATION_LEN
  @prf_expand_personalization "RISC0_ExpandSeed"

  # this maps onto the constant PRF_EXPAND_PSI
  @prf_expand_psi <<0>>

  @doc """
  Returns the rcm for the given resource.

  This is the hash of a byte list of a fixed length (81 bytes):
   - 16 bytes for prf_expand_personalization
   - 1 byte for prf_expand_rcm
   - 32 bytes for the rand_seed
   - 32 bytes for the nonce

  """
  @spec rcm(t()) :: binary()
  def rcm(resource) do
    bytes =
      @prf_expand_personalization <>
        @prf_expand_rcm <>
        resource.rand_seed <>
        resource.nonce

    if byte_size(bytes) != 81 do
      raise ArgumentError, message: "commitment expected to be 81 bytes"
    end

    :crypto.hash(:sha256, bytes)
  end

  @doc """
  Returns the psi for the given resource.

  This is the hash of a byte list of a fixed length (81 bytes):
   - 16 bytes for prf_expand_personalization
   - 1 byte for prf_expand_psi
   - 32 bytes for the rand_seed
   - 32 bytes for the nonce
  """
  @spec psi(t()) :: binary()
  def psi(resource) do
    bytes =
      @prf_expand_personalization <>
        @prf_expand_psi <>
        resource.rand_seed <>
        resource.nonce

    if byte_size(bytes) != 81 do
      raise ArgumentError, message: "commitment expected to be 81 bytes"
    end

    :crypto.hash(:sha256, bytes)
  end
end
