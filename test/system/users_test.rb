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

  test 'shows the user\'s profile picture' do
    visit user_path(users(:iu))

    photo_path = users(:iu).photo

    assert_selector "img[src='#{photo_path}']"
  end

  test 'shows the user\'s username' do
    visit user_path(users(:iu))

    assert_text users(:iu).name
  end

  test 'shows the number of posts the user has written' do
    visit user_path(users(:iu))

    assert_text "Number of posts: #{users(:iu).posts_counter}"
  end

  test 'shows the user\'s bio' do
    visit user_path(users(:iu))

    assert_text users(:iu).bio
  end

  test 'shows the user\'s first 3 posts' do
    visit user_path(users(:iu))

    posts = users(:iu).recent_posts

    posts.each do |post|
      assert_text post.title
    end
  end

  test 'shows a button that lets me view all of a user\'s posts' do
    visit user_path(users(:iu))

    assert_selector 'a', text: 'See all posts'
  end

  test 'clicking on a user\'s post redirects to that post\'s show page' do
    visit user_path(users(:iu))

    post = users(:iu).recent_posts.first
    click_on post.title

    assert_current_path user_post_path(users(:iu), post)
  end

  test 'clicking to see all posts redirects me to the user\'s post\'s index page' do
    visit user_path(users(:iu))

    click_on 'See all posts'

    assert_current_path user_posts_path(users(:iu))
  end
end
