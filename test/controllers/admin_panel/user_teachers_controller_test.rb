require 'test_helper'

class AdminPanel::UserTeachersControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

end
