defmodule Anoma.Arm.AppData do
  @moduledoc """
  I define the datastructure `AppData` that defines the structure of an app data
  for the resource machine.
  """
  use TypedStruct

  alias Anoma.Arm.AppData
  alias Anoma.Arm.ExpirableBlob

  typedstruct do
    @derive Jason.Encoder
    field :resource_payload, [ExpirableBlob.t()], default: []
    field :discovery_payload, [ExpirableBlob.t()], default: []
    field :external_payload, [ExpirableBlob.t()], default: []
    field :application_payload, [ExpirableBlob.t()], default: []
  end

  @spec from_map(map) :: t()
  def from_map(map) do
    map =
      map
      |> Enum.map(fn {k, vs} ->
        {k, Enum.map(vs, &ExpirableBlob.from_map/1)}
      end)

    struct(AppData, map)
  end
end
