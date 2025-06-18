defmodule Anoma.Util do
  @moduledoc """
  Various utility functions used in different modules in the SDK.
  """

  @doc """
  Given an integer, I return its bitstring in a fixed size.
  """
  @spec to_fixed_bitstring(non_neg_integer()) :: <<_::256>>
  def to_fixed_bitstring(n) do
    :binary.encode_unsigned(n)
    |> pad_bitstring(32, 0)
  end

  @doc """
  Pads a bitstring with the given `value` up to the length given.

  Raises if the length is shorter than the length of the bitstring.
  """
  @spec pad_bitstring(binary(), non_neg_integer(), non_neg_integer()) :: binary()
  def pad_bitstring(bitstring, length, value \\ 0) do
    needed = length - byte_size(bitstring)

    if needed < 0 do
      raise ArgumentError, message: "bitstring length larger than length"
    end

    <<value::needed*8, bitstring::binary>>
  end

  @doc """
  Turns a binlist into a binary.

  A binlist is {[0,0,0]}.
  A binary is <<0,0,0>>.

  ## Examples

      iex> Anoma.Util.binlist2bin({[72, 101, 108, 108, 111]})
      "Hello"

      iex> Anoma.Util.binlist2bin({[0, 1, 2, 3]})
      <<0, 1, 2, 3>>
  """
  @spec binlist2bin([byte()] | {[byte()]}) :: binary()
  def binlist2bin(bin_list) do
    case bin_list do
      {binlist} -> binlist2bin(binlist)
      binlist -> :binary.list_to_bin(binlist)
    end
  end

  @doc """
  Turns a binary into a binlist.

  A binlist is {[0,0,0]}.
  A binary is <<0,0,0>>.

  ## Examples

      iex> Anoma.Util.bin2binlist("Hello")
      ~c"Hello"

      iex> Anoma.Util.bin2binlist(<<0, 1, 2, 3>>)
      {[0, 1, 2, 3]}
  """
  @spec bin2binlist(binary()) :: [byte()]
  def bin2binlist(binary) do
    :binary.bin_to_list(binary)
  end

  @doc """
  Turns a binlist into a binary.

  A binlist is {[0,0,0]}.
  A binary is <<0,0,0>>.

  ## Examples

      iex> Anoma.Util.binlist2bin({[72, 101, 108, 108, 111]})
      "Hello"

      iex> Anoma.Util.binlist2bin({[0, 1, 2, 3]})
      <<0, 1, 2, 3>>
  """
  @spec binlist2hex([byte()] | {[byte()]}) :: String.t()
  def binlist2hex(bin_list) do
    case bin_list do
      {binlist} -> binlist2bin(binlist)
      binlist -> :binary.list_to_bin(binlist)
    end
  end

  @doc """
  Generate `len` random bytes.
  """
  @spec randombinlist(non_neg_integer()) :: [byte()]
  def randombinlist(len \\ 32) do
    :crypto.strong_rand_bytes(len)
    |> bin2binlist()
  end

  @doc """
  An iolist consists of elements that each represent a byte (e.g., [1, 255]).
  This function converts that list into a list of 32-bit integers.
  """
  @spec binlist2vec32([byte()]) :: [number()]
  def binlist2vec32(binlist) do
    binlist
    |> Enum.chunk_every(4)
    |> Enum.map(fn chunk ->
      chunk
      |> binlist2bin()
      |> :binary.decode_unsigned(:little)
    end)
  end

  @doc """
  Given a list of 32-bit integers, turns this into a list of bytes.
  """
  @spec vec322binlist([number()]) :: binary()
  def vec322binlist(vec32) do
    vec32
    |> Enum.map_join(&:binary.encode_unsigned(&1, :little))
  end
end
