defmodule AnomaSDK.Examples.JsonEncoding do
  @moduledoc """
  I have examples of encoding JSON
  """

  use ExUnit.Case

  alias AnomaSDK.Arm.Action
  alias AnomaSDK.Arm.AppData
  alias AnomaSDK.Arm.ComplianceInstance
  alias AnomaSDK.Arm.ComplianceUnit
  alias AnomaSDK.Arm.ComplianceWitness
  alias AnomaSDK.Arm.DeltaProof
  alias AnomaSDK.Arm.DeltaWitness
  alias AnomaSDK.Arm.ExpirableBlob
  alias AnomaSDK.Arm.LogicVerifier
  alias AnomaSDK.Arm.LogicVerifierInputs
  alias AnomaSDK.Arm.MerkleTree
  alias AnomaSDK.Arm.Resource
  alias AnomaSDK.Arm.Test
  alias AnomaSDK.Arm.Transaction

  @spec json_roundtrip(any(), (map() -> term())) :: map()
  def json_roundtrip(data, decoder) do
    # Encode to JSON
    json_string = Jason.encode!(data)

    # Decode from JSON to map and convert keys to atoms
    decoded_map =
      json_string
      |> Jason.decode!()
      |> AnomaSDK.Json.keys_to_atoms()

    # Convert map back to struct using from_map
    recovered = decoder.(decoded_map)

    # Verify the decoded version matches the original
    assert recovered == data
    decoded_map
  end

  @spec basic_action() :: map()
  @spec basic_app_data() :: map()
  @spec basic_compliance_instance() :: map()
  @spec basic_compliance_unit() :: map()
  @spec basic_compliance_witness() :: map()
  @spec basic_delta_proof() :: map()
  @spec basic_delta_witness() :: map()
  @spec basic_logic_verifier() :: map()
  @spec basic_expirable_blob() :: map()
  @spec basic_verifier_inputs() :: map()
  @spec basic_merkle_tree() :: map()
  @spec basic_resource() :: map()
  @spec basic_transaction() :: map()
  def basic_action, do: json_roundtrip(Test.test_action(), &Action.from_map/1)
  def basic_app_data, do: json_roundtrip(Test.test_app_data(), &AppData.from_map/1)

  def basic_compliance_instance,
    do: json_roundtrip(Test.test_compliance_instance(), &ComplianceInstance.from_map/1)

  def basic_compliance_unit,
    do: json_roundtrip(Test.test_compliance_unit(), &ComplianceUnit.from_map/1)

  def basic_compliance_witness,
    do: json_roundtrip(Test.test_compliance_witness(), &ComplianceWitness.from_map/1)

  def basic_delta_proof, do: json_roundtrip(Test.test_delta_proof(), &DeltaProof.from_map/1)

  def basic_delta_witness,
    do: json_roundtrip(Test.test_delta_witness(), &DeltaWitness.from_map/1)

  def basic_expirable_blob,
    do: json_roundtrip(Test.test_expirable_blob(), &ExpirableBlob.from_map/1)

  def basic_logic_verifier,
    do: json_roundtrip(Test.test_logic_verifier(), &LogicVerifier.from_map/1)

  def basic_verifier_inputs,
    do: json_roundtrip(Test.test_logic_verifier_inputs(), &LogicVerifierInputs.from_map/1)

  def basic_merkle_tree, do: json_roundtrip(Test.test_merkle_tree(), &MerkleTree.from_map/1)
  def basic_resource, do: json_roundtrip(Test.test_resource(), &Resource.from_map/1)
  def basic_transaction, do: json_roundtrip(Test.test_transaction(), &Transaction.from_map/1)
end
