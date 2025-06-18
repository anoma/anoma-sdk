defmodule Anoma.Arm.Resource do
  @moduledoc """
  I define the datastructure `Resource` that defines the structure of a resource for the resource machine.
  """
  use TypedStruct

  alias Anoma.Arm.NullifierKey

  import Anoma.Util

  typedstruct do
    field :logic_ref, [byte()]
    field :label_ref, [byte()]
    field :quantity, number()
    field :value_ref, [byte()]
    field :is_ephemeral, bool
    field :nonce, [byte()]
    field :nk_commitment, {[byte()]}
    field :rand_seed, [byte()]
  end

  @doc """
  Compute the commitment to the resource.
  """
  @spec commitment(t()) :: [byte()]
  def commitment(resource) do
    # pad the quantity with the bytes defined as QUANTITY_BYTES in aarm_core
    quantity_bytes =
      resource.quantity
      |> :binary.encode_unsigned()
      |> pad_bitstring(16)

    # construct a binary of RESOURCE_BYTES size (209)
    bytes =
      binlist2bin(resource.logic_ref) <>
        binlist2bin(resource.label_ref) <>
        quantity_bytes <>
        binlist2bin(resource.value_ref) <>
        if(resource.is_ephemeral, do: <<1>>, else: <<0>>) <>
        binlist2bin(resource.nonce) <>
        binlist2bin(resource.nk_commitment) <>
        rcm(resource)

    if byte_size(bytes) != 209 do
      raise ArgumentError, message: "commitment expected to be 209 bytes"
    end

    :crypto.hash(:sha256, bytes)
    |> :binary.bin_to_list()
  end

  @doc """
  Return the nullifier for this resource.
  """
  @spec nullifier(t(), NullifierKey.t()) :: [byte()]
  def nullifier(resource, nullifier_key) do
    commitment = commitment(resource)
    nullifier = nullifier_from_commitment(resource, nullifier_key, commitment)
    :binary.bin_to_list(nullifier)
  end

  @doc """
  Generate the nullifier from a commitment.
  """
  @spec nullifier_from_commitment(t(), NullifierKey.t(), [byte()]) :: binary()
  def nullifier_from_commitment(resource, nullifier_key, commitment) do
    key_commitment = NullifierKey.commit(nullifier_key)

    if resource.nk_commitment != key_commitment do
      raise ArgumentError,
        message:
          "Resource nullifier key commitment differs from the commitment derived from the nullifier key."
    end

    # construct a binary of RESOURCE_BYTES size (209)
    bytes =
      binlist2bin(nullifier_key) <>
        binlist2bin(resource.nonce) <>
        psi(resource) <>
        :binary.list_to_bin(commitment)

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
        binlist2bin(resource.rand_seed) <>
        binlist2bin(resource.nonce)

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
        binlist2bin(resource.rand_seed) <>
        binlist2bin(resource.nonce)

    if byte_size(bytes) != 81 do
      raise ArgumentError, message: "commitment expected to be 81 bytes"
    end

    :crypto.hash(:sha256, bytes)
  end
end
