defmodule Anoma.Arm.AppData do
  @moduledoc """
  I define the datastructure `AppData` that defines the structure of an app data
  for the resource machine.
  """
  use TypedStruct

  alias Anoma.Arm.ExpirableBlob

  typedstruct do
    field :resource_payload, [ExpirableBlob.t()], default: []
    field :discovery_payload, [ExpirableBlob.t()], default: []
    field :external_payload, [ExpirableBlob.t()], default: []
    field :application_payload, [ExpirableBlob.t()], default: []
  end
end
