defmodule Anoma.Zkvm.ForwarderCalldata do
  use TypedStruct

  typedstruct do
    field :untrusted_forwarder, binary()
    # field :input, binary()
    # field :output, binary()
    field :name, number()
  end
end
