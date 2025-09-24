defprotocol AnomaSDK.Validate do
  @spec valid?(t()) :: t()
  def valid?(data)
end
