require 'test_helper'

class PagesTest < ActionDispatch::IntegrationTest
  test "should get Home" do
    get pages_home_url
    assert_response :success
  end
    
    test "should get root" do
        get root_url
        assert_response :success
    end
end
