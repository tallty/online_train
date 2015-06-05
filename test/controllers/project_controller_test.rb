require 'test_helper'

class ProjectControllerTest < ActionController::TestCase
  test "should get about" do
    get :about
    assert_response :success
  end

  test "should get background" do
    get :background
    assert_response :success
  end

end
