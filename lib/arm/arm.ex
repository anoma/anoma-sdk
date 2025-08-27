defmodule Anoma.Arm do
  @moduledoc """
  I define a few functions to test the ARM repo NIF interface.
  """

  use Rustler,
    otp_app: :anoma_sdk,
    crate: :arm

  @doc """
  Proves a compliance witness and returns a compliance unit.
  """
  @spec prove(ComplianceWitness.t()) :: ComplianceUnit.t()
  def prove(_), do: :erlang.nif_error(:nif_not_loaded)
end
