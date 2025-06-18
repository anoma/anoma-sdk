defmodule Anoma.Arm.LogicVerifierInputs do
  @moduledoc """
  I define the datastructure `LogicVerifierInput` that defines the structure of
  a logic verifier input for the resource machine.
  """
  use TypedStruct

  alias Anoma.Arm.AppData

  typedstruct do
    @derive Jason.Encoder
    field :tag, binary()
    field :verifying_key, binary()
    field :app_data, AppData.t()
    field :proof, binary()
  end
end
