defmodule Anoma.Arm.LogicVerifierInputs do
  @moduledoc """
  I define the datastructure `LogicVerifierInput` that defines the structure of
  a logic verifier input for the resource machine.
  """
  use TypedStruct

  alias Anoma.Arm.LogicVerifierInputs

  typedstruct do
    field :tag, [byte()]
    field :verifying_key, [byte()]
    field :app_data, AppData.t()
    field :proof, [byte()]
  end

end
