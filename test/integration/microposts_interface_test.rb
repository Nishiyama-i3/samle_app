require 'test_helper'

class MicropostsInterfaceTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
  end

  test 'micropost interface' do
    log_in_as(@user)
    get root_path
    assert_select 'div.pagination'
    assert_select 'input[type=file]'
    post microposts_path, params: {micropost: {content: ''}}
    assert_select 'div#error_explanation'
    assert_select 'a[href=?]', '/?page=2'
    content = 'this is content'
    image = fixture_file_upload('test/fixtures/kitten.jpg', 'image/jpeg')
    post microposts_path, params: {micropost: {content: content, image: image}}
    assert_redirected_to root_url
    assert @user.microposts.first.image.attached?
    follow_redirect!
    assert_match content, response.body
    first_post = @user.microposts.paginate(page: 1).first
    assert_difference 'Micropost.count', -1 do
      delete micropost_path(first_post)
    end
    get user_path(users(:archer))
    assert_select 'a', 'delete', count: 0
  end

  test 'micropost sidebar count' do
    log_in_as(@user)
    get root_path
    assert_match '34 microposts', response.body
    other_user = users(:malory)
    log_in_as(other_user)
    get root_path
    assert_match '0 microposts', response.body
    other_user.microposts.create!(content: 'A micropost')
    get root_path
    assert_match '1 micropost', response.body
  end
end
