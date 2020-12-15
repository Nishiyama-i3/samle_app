require 'test_helper'

class UsersShowTest < ActionDispatch::IntegrationTest
  def setup
    @not_active = users(:ken)
  end

  test 'should redirect show when not activated' do
    get user_path(@not_active)
    assert_redirected_to root_url
  end

  
end