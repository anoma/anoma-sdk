defmodule AnomaSDK.Arm.AppData do
  @moduledoc """
  I define the datastructure `AppData` that defines the structure of an app data
  for the resource machine.
  """
  use TypedStruct

  alias AnomaSDK.Arm.AppData
  alias AnomaSDK.Arm.ExpirableBlob

  typedstruct do
    @derive Jason.Encoder
    field :resource_payload, [ExpirableBlob.t()], default: []
    field :discovery_payload, [ExpirableBlob.t()], default: []
    field :external_payload, [ExpirableBlob.t()], default: []
    field :application_payload, [ExpirableBlob.t()], default: []
  end

  defimpl AnomaSDK.Validate, for: __MODULE__ do
    @impl true
    def valid?(app) do
      is_list(app.resource_payload) &&
        is_list(app.discovery_payload) &&
        is_list(app.external_payload) &&
        is_list(app.application_payload) &&
        Enum.all?(app.resource_payload, &AnomaSDK.Validate.valid?/1) &&
        Enum.all?(app.discovery_payload, &AnomaSDK.Validate.valid?/1) &&
        Enum.all?(app.external_payload, &AnomaSDK.Validate.valid?/1) &&
        Enum.all?(app.application_payload, &AnomaSDK.Validate.valid?/1)
    end
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
