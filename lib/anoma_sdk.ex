defmodule AnomaSdk do
  defmacro __using__(_opts) do
    quote do
      @typedoc """
      The type of a nullifierkey.  32 bytes.

      This is a tuple to map properly on the NIF struct.
      """
      @type nullifier_key :: {[byte()]}

      @typedoc """
      The type of a nullifier key commitment.  32 bytes.

      This is a tuple to map properly on the NIF struct.
      """
      @type nullifier_key_commitment :: {[byte()]}
    end
  end
end
