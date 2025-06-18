defmodule Anoma.Zkvm do
  use Rustler,
    otp_app: :anoma_sdk,
    crate: :zkvm


  def testfunc(), do: :erlang.nif_error(:nif_not_loaded)
  def echofunc(_resource), do: :erlang.nif_error(:nif_not_loaded)
  def prove(_a, _b), do: :erlang.nif_error(:nif_not_loaded)
  def verify(_proof_str), do: :erlang.nif_error(:nif_not_loaded)

  def test do
    res = Anoma.Zkvm.testfunc()
    Anoma.Zkvm.echofunc(res)
  end
end
