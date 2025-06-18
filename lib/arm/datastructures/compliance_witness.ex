defmodule Anoma.Arm.ComplianceWitness do
  @moduledoc """
  I define the datastructure `DeltaWitness` that defines the structure of a delta witness for the resource machine.
  """
  use TypedStruct

  alias Anoma.Arm.ComplianceWitness
  alias Anoma.Arm.MerklePath
  alias Anoma.Arm.NullifierKey
  alias Anoma.Arm.Resource
  alias Anoma.Util

  import Anoma.Arm.Constants
  #

  typedstruct do
    @derive Jason.Encoder
    field :consumed_resource, Resource.t()
    field :merkle_path, MerklePath.t()
    field :ephemeral_root, [byte()]
    field :nf_key, NullifierKey.t()
    field :created_resource, Resource.t()
    field :rcv, [byte()]
  end

  @doc false
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

  @doc false
  @spec from_resources_with_path(Resource.t(), NullifierKey.t(), MerklePath.t(), Resource.t()) ::
          t()
  def from_resources_with_path(consumed, nullifier_key, merkle_path, created) do
    %ComplianceWitness{
      consumed_resource: consumed,
      created_resource: created,
      merkle_path: merkle_path,
      rcv: Util.bin2binlist(:crypto.strong_rand_bytes(32)),
      nf_key: nullifier_key,
      # this value is taken from arm/src/compliance.rs:72
      ephemeral_root: [1803055230, 83644957, 55760658, 767699695, 2526363105, 2712004780, 3273937901, 3274801133]
    }
  end
end
