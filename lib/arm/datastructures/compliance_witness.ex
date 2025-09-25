defmodule AnomaSDK.Arm.ComplianceWitness do
  @moduledoc """
  I define the datastructure `DeltaWitness` that defines the structure of a delta witness for the resource machine.
  """
  use TypedStruct

  alias AnomaSDK.Arm.ComplianceWitness
  alias AnomaSDK.Arm.MerklePath
  alias AnomaSDK.Arm.NullifierKey
  alias AnomaSDK.Arm.Resource

  import AnomaSDK.Arm.Constants

  typedstruct do
    field(:consumed_resource, Resource.t())
    field(:merkle_path, MerklePath.t())
    field(:ephemeral_root, binary())
    field(:nf_key, NullifierKey.t())
    field(:created_resource, Resource.t())
    field(:rcv, binary())
  end

  defimpl Jason.Encoder, for: AnomaSDK.Arm.ComplianceWitness do
    @spec encode(struct(), term()) :: term()
    @spec encode(struct(), term()) :: term()
    def encode(struct, opts) do
      struct
      |> AnomaSDK.Json.encode_keys([:ephemeral_root, :nf_key, :rcv])
      |> Map.update!(:merkle_path, &MerklePath.to_map/1)
      |> Jason.Encode.map(opts)
    end
  end

  defimpl AnomaSDK.Validate, for: __MODULE__ do
    @impl true
    def valid?(term) do
      is_binary(term.ephemeral_root) &&
        is_binary(term.rcv) &&
        AnomaSDK.Validate.valid?(term.consumed_resource) &&
        AnomaSDK.Validate.valid?(term.created_resource) &&
        MerklePath.valid?(term.merkle_path) &&
        NullifierKey.valid?(term.nf_key)
    end
  end

  @spec from_map(map) :: t()
  def from_map(map) do
    consumed_resource = Resource.from_map(map.consumed_resource)
    merkle_path = MerklePath.from_map(map.merkle_path)
    created_resource = Resource.from_map(map.created_resource)
    map = AnomaSDK.Json.decode_keys(map, [:ephemeral_root, :nf_key, :rcv])

    struct(ComplianceWitness, %{
      map
      | consumed_resource: consumed_resource,
        merkle_path: merkle_path,
        created_resource: created_resource
    })
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
