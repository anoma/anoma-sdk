defmodule Anoma.Test.JSONRoundtripTest do
  use ExUnit.Case

  alias Anoma.Arm.Action
  alias Anoma.Arm.AppData
  alias Anoma.Arm.ComplianceInstance
  alias Anoma.Arm.ComplianceUnit
  alias Anoma.Arm.ComplianceWitness
  alias Anoma.Arm.DeltaProof
  alias Anoma.Arm.DeltaWitness
  alias Anoma.Arm.ExpirableBlob
  alias Anoma.Arm.LogicVerifier
  alias Anoma.Arm.LogicVerifierInputs
  alias Anoma.Arm.MerkleTree
  alias Anoma.Arm.Resource
  alias Anoma.Arm.Test
  alias Anoma.Arm.Transaction

  describe "JSON roundtrip tests" do
    test "Action - encode to JSON, decode back, and convert with from_map" do
      original = Test.test_action()

      # Encode to JSON
      json_string = Jason.encode!(original)

      # Decode from JSON to map and convert keys to atoms
      decoded_map =
        json_string
        |> Jason.decode!()
        |> Anoma.Json.keys_to_atoms()

      # Convert map back to struct using from_map
      recovered = Action.from_map(decoded_map)

      # Verify the decoded version matches the original
      assert recovered == original
    end

    test "AppData - encode to JSON, decode back, and convert with from_map" do
      original = Test.test_app_data()

      # Encode to JSON
      json_string = Jason.encode!(original)

      # Decode from JSON to map and convert keys to atoms
      decoded_map =
        json_string
        |> Jason.decode!()
        |> Anoma.Json.keys_to_atoms()

      # Convert map back to struct using from_map
      recovered = AppData.from_map(decoded_map)

      # Verify the decoded version matches the original
      assert recovered == original
    end

    test "ComplianceInstance - encode to JSON, decode back, and convert with from_map" do
      original = Test.test_compliance_instance()

      # Encode to JSON
      json_string = Jason.encode!(original)

      # Decode from JSON to map and convert keys to atoms
      decoded_map =
        json_string
        |> Jason.decode!()
        |> Anoma.Json.keys_to_atoms()

      # Convert map back to struct using from_map
      recovered = ComplianceInstance.from_map(decoded_map)

      # Verify the decoded version matches the original
      assert recovered == original
    end

    test "ComplianceUnit - encode to JSON, decode back, and convert with from_map" do
      original = Test.test_compliance_unit()

      # Encode to JSON
      json_string = Jason.encode!(original)

      # Decode from JSON to map and convert keys to atoms
      decoded_map =
        json_string
        |> Jason.decode!()
        |> Anoma.Json.keys_to_atoms()

      # Convert map back to struct using from_map
      recovered = ComplianceUnit.from_map(decoded_map)

      # Verify the decoded version matches the original
      assert recovered == original
    end

    test "ComplianceWitness - encode to JSON, decode back, and convert with from_map" do
      original = Test.test_compliance_witness()

      # Encode to JSON
      json_string = Jason.encode!(original)

      # Decode from JSON to map and convert keys to atoms
      decoded_map =
        json_string
        |> Jason.decode!()
        |> Anoma.Json.keys_to_atoms()

      # Convert map back to struct using from_map
      recovered = ComplianceWitness.from_map(decoded_map)

      # Verify the decoded version matches the original
      assert recovered == original
    end

    test "DeltaProof - encode to JSON, decode back, and convert with from_map" do
      original = Test.test_delta_proof()

      # Encode to JSON
      json_string = Jason.encode!(original)

      # Decode from JSON to map and convert keys to atoms
      decoded_map =
        json_string
        |> Jason.decode!()
        |> Anoma.Json.keys_to_atoms()

      # Convert map back to struct using from_map
      recovered = DeltaProof.from_map(decoded_map)

      # Verify the decoded version matches the original
      assert recovered == original
    end

    test "DeltaWitness - encode to JSON, decode back, and convert with from_map" do
      original = Test.test_delta_witness()

      # Encode to JSON
      json_string = Jason.encode!(original)

      # Decode from JSON to map and convert keys to atoms
      decoded_map =
        json_string
        |> Jason.decode!()
        |> Anoma.Json.keys_to_atoms()

      # Convert map back to struct using from_map
      recovered = DeltaWitness.from_map(decoded_map)

      # Verify the decoded version matches the original
      assert recovered == original
    end

    test "ExpirableBlob - encode to JSON, decode back, and convert with from_map" do
      original = Test.test_expirable_blob()

      # Encode to JSON
      json_string = Jason.encode!(original)

      # Decode from JSON to map and convert keys to atoms
      decoded_map =
        json_string
        |> Jason.decode!()
        |> Anoma.Json.keys_to_atoms()

      # Convert map back to struct using from_map
      recovered = ExpirableBlob.from_map(decoded_map)

      # Verify the decoded version matches the original
      assert recovered == original
    end

    test "LogicVerifier - encode to JSON, decode back, and convert with from_map" do
      original = Test.test_logic_verifier()

      # Encode to JSON
      json_string = Jason.encode!(original)

      # Decode from JSON to map and convert keys to atoms
      decoded_map =
        json_string
        |> Jason.decode!()
        |> Anoma.Json.keys_to_atoms()

      # Convert map back to struct using from_map
      recovered = LogicVerifier.from_map(decoded_map)

      # Verify the decoded version matches the original
      assert recovered == original
    end

    test "LogicVerifierInputs - encode to JSON, decode back, and convert with from_map" do
      original = Test.test_logic_verifier_inputs()

      # Encode to JSON
      json_string = Jason.encode!(original)

      # Decode from JSON to map and convert keys to atoms
      decoded_map =
        json_string
        |> Jason.decode!()
        |> Anoma.Json.keys_to_atoms()

      # Convert map back to struct using from_map
      recovered = LogicVerifierInputs.from_map(decoded_map)

      # Verify the decoded version matches the original
      assert recovered == original
    end

    test "MerkleTree - encode to JSON, decode back, and convert with from_map" do
      original = Test.test_merkle_tree()

      # Encode to JSON
      json_string = Jason.encode!(original)

      # Decode from JSON to map and convert keys to atoms
      decoded_map =
        json_string
        |> Jason.decode!()
        |> Anoma.Json.keys_to_atoms()

      # Convert map back to struct using from_map
      recovered = MerkleTree.from_map(decoded_map)

      # Verify the decoded version matches the original
      assert recovered == original
    end

    test "Resource - encode to JSON, decode back, and convert with from_map" do
      original = Test.test_resource()

      # Encode to JSON
      json_string = Jason.encode!(original)

      # Decode from JSON to map and convert keys to atoms
      decoded_map =
        json_string
        |> Jason.decode!()
        |> Anoma.Json.keys_to_atoms()

      # Convert map back to struct using from_map
      recovered = Resource.from_map(decoded_map)

      # Verify the decoded version matches the original
      assert recovered == original
    end
  end

  test "Transaction - encode to JSON, decode back, and convert with from_map" do
    original = Test.test_transaction()

    # Encode to JSON
    json_string = Jason.encode!(original)

    # Decode from JSON to map and convert keys to atoms
    decoded_map =
      json_string
      |> Jason.decode!()
      |> Anoma.Json.keys_to_atoms()

    # Convert map back to struct using from_map
    recovered = Transaction.from_map(decoded_map)

    # Verify the decoded version matches the original
    assert recovered == original
  end
end
