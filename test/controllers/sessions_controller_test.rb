require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  test "should get new path" do
    get login_path
    assert_response :success
  end
  
end
