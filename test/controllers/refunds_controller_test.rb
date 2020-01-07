require 'test_helper'

class RefundsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get refunds_create_url
    assert_response :success
  end

end
