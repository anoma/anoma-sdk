defmodule Anoma.Arm.ComplianceWitness do
  @moduledoc """
  I define the datastructure `DeltaWitness` that defines the structure of a delta witness for the resource machine.
  """
  use TypedStruct

  alias Anoma.Arm.ComplianceWitness
  alias Anoma.Arm.MerklePath
  alias Anoma.Arm.NullifierKey
  alias Anoma.Arm.Resource

  import Anoma.Arm.Constants
  #

  typedstruct do
    field :consumed_resource, Resource.t()
    field :merkle_path, MerklePath.t()
    field :ephemeral_root, [byte()]
    field :nf_key, NullifierKey.t()
    field :created_resource, Resource.t()
    field :rcv, [byte()]
  end

  @spec with_fixed_rcv(Resource.t(), NullifierKey.t(), Resource.t()) :: t()
  def with_fixed_rcv(consumed, nullifier_key, created) do
    %ComplianceWitness{
      consumed_resource: consumed,
      created_resource: created,
      merkle_path: MerklePath.default(),
      # <<0, 0, ..., 1>>
      rcv: :binary.bin_to_list(<<0::31*8, 1>>),
      nf_key: nullifier_key,
      ephemeral_root: initial_root()
    }
  end
end
