require 'test_helper'

class AdminPanel::SchoolsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

end
