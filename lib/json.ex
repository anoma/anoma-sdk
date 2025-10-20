defmodule Anoma.Json do
  @moduledoc """
  Contains various functions to deal with json data decoding and encoding.
  """
  @doc """
  Given a map or list, turns it into a map or list where all map keys are atoms,
  instead of strings.

  JSON cannot contain tuples, so these are not present here.
  """
  @spec keys_to_atoms(term()) :: term()
  def keys_to_atoms([]), do: []

  def keys_to_atoms([h | tail]) do
    [keys_to_atoms(h) | keys_to_atoms(tail)]
  end

  def keys_to_atoms(string_key_map) when is_map(string_key_map) do
    for {key, val} <- string_key_map,
        into: %{},
        do: {String.to_atom(key), keys_to_atoms(val)}
  end

  def keys_to_atoms(value), do: value

  @doc """
  Turns a struct into a map and encodes the given keys from binary() to String
  using Base64 encoding.
  """
  @spec encode_keys(struct(), [atom()]) :: map()
  def encode_keys(struct, keys) do
    struct
    |> Map.from_struct()
    |> Enum.map(fn {key, value} ->
      if key in keys do
        {key, Base.encode64(value)}
      else
        {key, value}
      end
    end)
    |> Enum.into(%{})
  end

  @spec encode_keys(struct()) :: map()
  def encode_keys(struct) do
    encode_keys(struct, Map.keys(struct))
  end

  @doc """
  Given a map, base64 decodes all the given keys.
  """
  @spec decode_keys(map(), [atom()]) :: map()
  def decode_keys(map, keys) do
    map
    |> Enum.map(fn {key, value} ->
      if key in keys do
        {key, Base.decode64!(value)}
      else
        {key, value}
      end
    end)
    |> Enum.into(%{})
  end

  @spec decode_keys(map()) :: map()
  def decode_keys(struct) do
    decode_keys(struct, Map.keys(struct))
  end
end
