require 'application_system_test_case'

class UsersTest < ApplicationSystemTestCase
  test 'shows the users' do
    visit users_path

    assert_text 'Ben'
    assert_text 'IU'
    assert_text 'Punch'
  end

  test 'shows the profile picture for each user' do
    visit users_path

    assert_selector 'img', count: 3
  end

  test 'shows the number of posts each user has written' do
    visit users_path

    ben = users(:ben)
    iu = users(:iu)
    punch = users(:punch)

    assert_text "Number of posts: #{ben.posts_counter}"
    assert_text "Number of posts: #{iu.posts_counter}"
    assert_text "Number of posts: #{punch.posts_counter}"
  end

  test 'clicking on a user redirects to that user\'s show page' do
    visit users_path

    click_on 'Ben'

    assert_current_path user_path(users(:ben))
  end
end
