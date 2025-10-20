defmodule Anoma.Arm.Inspect do
  @moduledoc """
  I define helpers for the inspect protocol for Anoma Arm structs.
  """

  import Inspect.Algebra
  alias Anoma.Arm.Inspect, as: I

  defmacro __using__(_opts) do
    quote do
      defimpl Inspect, for: __MODULE__ do
        import Inspect.Algebra

        @doc false
        def inspect(resource, opts) do
          concat(["##{__MODULE__}<", I.format_fields(resource, opts), line(), ">"])
        end
      end
    end
  end

  @doc """
  Given an arbitrary struct, I format all the fields.
  """
  @spec format_fields(term(), Inspect.Opts.t()) :: Inspect.Algebra.t()
  def format_fields(struct, opts) do
    struct
    |> Map.delete(:__struct__)
    |> Map.to_list()
    |> Enum.map(&format_field(&1, opts))
    |> Enum.intersperse(line())
    |> List.insert_at(0, line())
    |> concat()
    |> nest(2)
  end

  @doc """
  I format a field such that its key is shown, along with its byte size if
  relevant.
  """
  @spec format_field({atom(), term()}, Inspect.Opts.t()) :: Inspect.Algebra.t()
  def format_field({key, value}, opts) do
    key = color(to_doc(key, opts), :blue, opts)

    case size(value) do
      nil ->
        concat([key, " ", to_doc(value, opts)])

      n ->
        concat([key, " (#{n} bytes) ", to_doc(value, opts)])
    end
  end

  @doc """
  I return the size in bytes of a term. If the term is not a byte list, a byte
  list in a tuple, or binary, I return nil.
  """
  @spec size(term()) :: nil | non_neg_integer()
  def size({bytes}) do
    size(bytes)
  end

  @doc false
  def size(bin) when is_binary(bin) do
    byte_size(bin)
  end

  @doc false
  def size(xs) when is_list(xs) do
    if Enum.all?(xs, &is_integer/1) do
      Enum.count(xs)
    else
      nil
    end
  end

  @doc false
  def size(_), do: nil
end
