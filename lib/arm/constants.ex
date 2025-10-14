defmodule Anoma.Arm.Constants do
  @moduledoc """
  I define a list of constants used in the Anoma resource machine.
  """

  @test_guest_id [
    115,
    46,
    90,
    182,
    221,
    164,
    139,
    3,
    72,
    121,
    239,
    156,
    172,
    144,
    63,
    152,
    226,
    182,
    236,
    83,
    133,
    151,
    61,
    113,
    135,
    101,
    21,
    20,
    64,
    143,
    50,
    150
  ]

  @initial_root_hex "7e70786b1d52fc0412d75203ef2ac22de13d9596ace8a5a1ed5324c3ed7f31c3"
  @initial_root :binary.encode_unsigned(String.to_integer(@initial_root_hex, 16))

  @padding_leaf_hex "cc1d2f838445db7aec431df9ee8a871f40e7aa5e064fc056633ef8c60fab7b06"
  @padding_leaf :binary.encode_unsigned(String.to_integer(@padding_leaf_hex, 16))

  @doc """
  The initial root of the merkle tree.
  """
  @spec initial_root :: binary()
  def initial_root, do: @initial_root

  @doc """
  Returns a padding leaf.
  """
  @spec padding_leaf :: binary()
  def padding_leaf, do: @padding_leaf

  @doc """
  The test_guest_id is the verifying key to create a resource.
  """
  @spec test_guest_id :: [byte()]
  def test_guest_id, do: @test_guest_id
end
