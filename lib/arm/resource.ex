defmodule Anoma.Arm.Resource do
  @moduledoc """
  I define the datastructure `Resource` that defines the structure of a resource for the resource machine.
  """
  use TypedStruct

  typedstruct do
    field :logic_ref, [byte()]
    field :label_ref, [byte()]
    field :quantity, number()
    field :value_ref, [byte()]
    field :is_ephemeral, bool
    field :nonce, [byte()]
    field :nullifier_key_commitment, {[byte()]}
    field :rand_seed, [byte()]
  end
end
