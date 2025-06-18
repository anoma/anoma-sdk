defmodule Anoma.Arm.ComplianceInstance do
  @moduledoc """
  I define the datastructure `ComplianceInstance` that defines the structure of
  a compliance instance for the resource machine.
  """
  use TypedStruct
  use Anoma.Arm.Inspect

  alias Anoma.Arm

  typedstruct do
    @derive Jason.Encoder
    field :consumed_nullifier, [byte()]
    field :consumed_logic_ref, [byte()]
    field :consumed_commitment_tree_root, [byte()]
    field :created_commitment, [byte()]
    field :created_logic_ref, [byte()]
    field :delta_x, [byte()]
    field :delta_y, [byte()]
  end

  @doc """
  I return the delta message for this compliance instance.
  """
  @spec delta_message(t()) :: [byte()]
  def delta_message(instance) do
    Arm.delta_message(instance)
  end
end
