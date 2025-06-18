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

  typedstruct do
    field(:consumed_resource, Resource.t())
    field(:merkle_path, MerklePath.t())
    field(:ephemeral_root, binary())
    field(:nf_key, NullifierKey.t())
    field(:created_resource, Resource.t())
    field(:rcv, binary())
  end

  @doc false
  @spec with_fixed_rcv(Resource.t(), NullifierKey.t(), Resource.t()) :: t()
  def with_fixed_rcv(consumed, nullifier_key, created) do
    %ComplianceWitness{
      consumed_resource: consumed,
      created_resource: created,
      merkle_path: MerklePath.default(),
      rcv: <<0::31*8, 1>>,
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
      rcv: :crypto.strong_rand_bytes(32),
      nf_key: nullifier_key,
      # this value is taken from arm/src/compliance.rs:72
      ephemeral_root:
        <<204, 29, 47, 131, 132, 69, 219, 122, 236, 67, 29, 249, 238, 138, 135, 31, 64, 231, 170,
          94, 6, 79, 192, 86, 99, 62, 248, 198, 15, 171, 123, 6>>
    }
  end
end
