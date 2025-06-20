defmodule Anoma.Arm.ComplianceWitness do
  @moduledoc """
  I define the datastructure `DeltaWitness` that defines the structure of a delta witness for the resource machine.
  """
  use TypedStruct

  alias Anoma.Arm.MerklePath
  alias Anoma.Arm.NullifierKey
  alias Anoma.Arm.Resource

  typedstruct do
    field :consumed_resource, Resource.t()
    field :merkle_path, MerklePath.t()
    field :ephemeral_root, [byte()]
    field :nf_key, NullifierKey.t()
    field :created_resource, Resource.t()
    field :rcv, [byte()]
  end
end
