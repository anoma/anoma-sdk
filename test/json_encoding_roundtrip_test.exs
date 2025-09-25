defmodule AnomaSDK.Test.JSONRoundtripTest do
  use ExUnit.Case

  alias AnomaSDK.Examples.JsonEncoding

  describe "JSON roundtrip tests" do
    test "run examples turning data from maps to back" do
      JsonEncoding.basic_action()
      JsonEncoding.basic_app_data()
      JsonEncoding.basic_compliance_instance()
      JsonEncoding.basic_compliance_unit()
      JsonEncoding.basic_compliance_witness()
      JsonEncoding.basic_delta_proof()
      JsonEncoding.basic_delta_witness()
      JsonEncoding.basic_expirable_blob()
      JsonEncoding.basic_logic_verifier()
      JsonEncoding.basic_verifier_inputs()
      JsonEncoding.basic_merkle_tree()
      JsonEncoding.basic_resource()
      JsonEncoding.basic_transaction()
    end
  end
end
