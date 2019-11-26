require 'test_helper'

class CompaniesControllerTest < ActionDispatch::IntegrationTest
  test "should get name" do
    get companies_name_url
    assert_response :success
  end

  test "should get phone" do
    get companies_phone_url
    assert_response :success
  end

end
