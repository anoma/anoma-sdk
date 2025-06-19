defmodule Anoma.Arm do
  @moduledoc """
  I define functions to deal with Anoma Resource Machine structs.
  """
  use Rustler,
    otp_app: :anoma_sdk,
    crate: :zkvm

  def test_delta_witness, do: :erlang.nif_error(:nif_not_loaded)
  def test_delta_witness(_), do: :erlang.nif_error(:nif_not_loaded)

  def test_delta_proof, do: :erlang.nif_error(:nif_not_loaded)
  def test_delta_proof(_), do: :erlang.nif_error(:nif_not_loaded)

  def test_delta_with_proof, do: :erlang.nif_error(:nif_not_loaded)
  def test_delta_with_witness, do: :erlang.nif_error(:nif_not_loaded)

  def test_compliance_unit, do: :erlang.nif_error(:nif_not_loaded)
  def test_compliance_unit(_), do: :erlang.nif_error(:nif_not_loaded)

  def test_logic_proof, do: :erlang.nif_error(:nif_not_loaded)
  def test_logic_proof(_), do: :erlang.nif_error(:nif_not_loaded)

  def test_forwarder_calldata, do: :erlang.nif_error(:nif_not_loaded)
  def test_forwarder_calldata(_), do: :erlang.nif_error(:nif_not_loaded)

  def test_resource, do: :erlang.nif_error(:nif_not_loaded)
  def test_resource(_), do: :erlang.nif_error(:nif_not_loaded)

  def test_action, do: :erlang.nif_error(:nif_not_loaded)
  def test_action(_), do: :erlang.nif_error(:nif_not_loaded)
end
