defmodule Anoma.Arm do
  @moduledoc """
  I define functions to deal with Anoma Resource Machine structs.
  """
  use Rustler,
    otp_app: :anoma_sdk,
    crate: :zkvm

  alias Anoma.Arm.Action
  alias Anoma.Arm.ComplianceUnit
  alias Anoma.Arm.DeltaProof
  alias Anoma.Arm.DeltaWitness
  alias Anoma.Arm.ForwarderCalldata
  alias Anoma.Arm.LogicProof
  alias Anoma.Arm.Resource
  alias Anoma.Arm.Transaction

  @spec test_delta_witness() :: DeltaWitness.t()
  @spec test_delta_witness(DeltaWitness.t()) :: DeltaWitness.t()
  def test_delta_witness, do: :erlang.nif_error(:nif_not_loaded)
  def test_delta_witness(_), do: :erlang.nif_error(:nif_not_loaded)

  @spec test_delta_proof() :: DeltaProof.t()
  @spec test_delta_proof(DeltaProof.t()) :: DeltaProof.t()
  def test_delta_proof, do: :erlang.nif_error(:nif_not_loaded)
  def test_delta_proof(_), do: :erlang.nif_error(:nif_not_loaded)

  @spec test_delta_with_proof() :: {:proof, DeltaProof.t()}
  def test_delta_with_proof, do: :erlang.nif_error(:nif_not_loaded)

  @spec test_delta_with_witness() :: {:witness, DeltaWitness.t()}
  def test_delta_with_witness, do: :erlang.nif_error(:nif_not_loaded)

  @spec test_compliance_unit() :: ComplianceUnit.t()
  @spec test_compliance_unit(ComplianceUnit.t()) :: ComplianceUnit.t()
  def test_compliance_unit, do: :erlang.nif_error(:nif_not_loaded)
  def test_compliance_unit(_), do: :erlang.nif_error(:nif_not_loaded)

  @spec test_logic_proof() :: LogicProof.t()
  @spec test_logic_proof(LogicProof.t()) :: LogicProof.t()
  def test_logic_proof, do: :erlang.nif_error(:nif_not_loaded)
  def test_logic_proof(_), do: :erlang.nif_error(:nif_not_loaded)

  @spec test_forwarder_calldata() :: ForwarderCalldata.t()
  @spec test_forwarder_calldata(ForwarderCalldata.t()) :: ForwarderCalldata.t()
  def test_forwarder_calldata, do: :erlang.nif_error(:nif_not_loaded)
  def test_forwarder_calldata(_), do: :erlang.nif_error(:nif_not_loaded)

  @spec test_resource() :: Resource.t()
  @spec test_resource(Resource.t()) :: Resource.t()
  def test_resource, do: :erlang.nif_error(:nif_not_loaded)
  def test_resource(_), do: :erlang.nif_error(:nif_not_loaded)

  @spec test_action() :: Action.t()
  @spec test_action(Action.t()) :: Action.t()
  def test_action, do: :erlang.nif_error(:nif_not_loaded)
  def test_action(_), do: :erlang.nif_error(:nif_not_loaded)

  @spec test_transaction() :: Transaction.t()
  @spec test_transaction(Transaction.t()) :: Transaction.t()
  def test_transaction, do: :erlang.nif_error(:nif_not_loaded)
  def test_transaction(_), do: :erlang.nif_error(:nif_not_loaded)
end
