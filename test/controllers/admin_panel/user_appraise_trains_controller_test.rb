require 'test_helper'

class AdminPanel::UserAppraiseTrainsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

end
