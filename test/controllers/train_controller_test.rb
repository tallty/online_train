require 'test_helper'

class TrainControllerTest < ActionController::TestCase
  test "should get notice_index" do
    get :notice_index
    assert_response :success
  end

  test "should get notice_info" do
    get :notice_info
    assert_response :success
  end

  test "should get apply_index" do
    get :apply_index
    assert_response :success
  end

  test "should get apply_info" do
    get :apply_info
    assert_response :success
  end

end
