require 'test_helper'

class ConsignationsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get consignations_create_url
    assert_response :success
  end

end
