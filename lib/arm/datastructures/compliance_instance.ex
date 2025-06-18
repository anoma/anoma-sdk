defmodule Anoma.Arm.ComplianceInstance do
  @moduledoc """
  I define the datastructure `ComplianceInstance` that defines the structure of
  a compliance instance for the resource machine.
  """
  use TypedStruct
  use Anoma.Arm.Inspect

  typedstruct do
    field :consumed_nullifier, binary()
    field :consumed_logic_ref, binary()
    field :consumed_commitment_tree_root, binary()
    field :created_commitment, binary()
    field :created_logic_ref, binary()
    field :delta_x, binary()
    field :delta_y, binary()
  end
end
