defmodule Anoma.Arm.TrivialLogicWitness do
  @moduledoc """
  I define the datastructure `TrivialLogicWitness` that defines the structure of a
  trivial logic witness for the resource machine.
  """
  use TypedStruct

  alias Anoma.Arm.MerklePath
  alias Anoma.Arm.NullifierKey
  alias Anoma.Arm.Resource
  alias Anoma.Arm.TrivialLogicWitness

  typedstruct do
    field :resource, Resource.t()
    field :receive_existence_path, MerklePath.t()
    field :is_consumed, boolean()
    field :nf_key, NullifierKey.t()
  end

  @doc """
  Create a new trivial logic witness.
  """
  @spec new(Resource.t(), MerklePath.t(), NullifierKey.t(), boolean()) :: TrivialLogicWitness.t()
  def new(consumed_resource, merkle_tree_path, nullifier_key, consumed?) do
    %TrivialLogicWitness{
      resource: consumed_resource,
      receive_existence_path: merkle_tree_path,
      is_consumed: consumed?,
      nf_key: nullifier_key
    }
  end
end
