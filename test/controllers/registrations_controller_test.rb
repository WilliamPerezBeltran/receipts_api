# frozen_string_literal: true

require 'test_helper'

class RegistrationsControllerTest < ActionDispatch::IntegrationTest
  test 'should get create' do
    get registrations_create_url
    assert_response :success
  end

  test 'should get delete' do
    get registrations_delete_url
    assert_response :success
  end

  test 'should get update' do
    get registrations_update_url
    assert_response :success
  end
end
