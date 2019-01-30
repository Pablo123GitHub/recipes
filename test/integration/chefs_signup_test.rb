require 'test_helper'

class ChefsSignupTest < ActionDispatch::IntegrationTest
  test "get the signup form" do   
    get signup_path
    assert_response :success
  end 
end
