defmodule Anoma.Arm do
  @moduledoc """
  I define functions to deal with Anoma Resource Machine structs.
  """
  use Rustler,
    otp_app: :anoma_sdk,
    crate: :zkvm

  def test_delta_witness, do: :erlang.nif_error(:nif_not_loaded)
  def test_delta_witness(_delta_witness), do: :erlang.nif_error(:nif_not_loaded)

  # def test_delta_proof, do: :erlang.nif_error(:nif_not_loaded)
  def test_delta_proof(_delta_proof), do: :erlang.nif_error(:nif_not_loaded)
end
