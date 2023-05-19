require 'application_system_test_case'

class PostsTest < ApplicationSystemTestCase
  test 'shows the user\'s profile picture' do
    visit user_posts_path(users(:iu))

    photo_path = users(:iu).photo

    assert_selector "img[src='#{photo_path}']"
  end

  test 'shows the user\'s username' do
    visit user_posts_path(users(:iu))

    assert_text users(:iu).name
  end

  test 'shows the number of posts the user has written' do
    visit user_posts_path(users(:iu))

    assert_text "Number of posts: #{users(:iu).posts_counter}"
  end

  test 'shows a post\'s title' do
    visit user_posts_path(users(:iu))

    post = users(:iu).posts.first

    assert_text post.title
  end

  test 'shows some of a post\'s body' do
    visit user_posts_path(users(:iu))

    post = users(:iu).posts.first

    assert_text post.text
  end

  test 'shows the first comments on a post' do
    visit user_posts_path(users(:ben))

    post = posts(:loving)

    post.recent_comments.each do |comment|
      assert_text comment.text
    end
  end

  test 'shows how many comments a post has' do
    visit user_posts_path(users(:ben))

    post = posts(:loving)

    assert_text "Comments: #{post.comments_counter}"
  end

  test 'shows how many likes a post has' do
    visit user_posts_path(users(:ben))

    post = posts(:loving)

    assert_text "Likes: #{post.likes_counter}"
  end

  test 'shows a section for pagination if there are more posts than fit on the view' do
    visit user_posts_path(users(:iu))

    assert_text 'Pagination'
  end

  test 'clicking on a post redirects to that post\'s show page' do
    visit user_posts_path(users(:iu))

    post = users(:iu).posts.first
    click_on post.title

    assert_current_path user_post_path(users(:iu), post)
  end

  test 'shows the post\'s title' do
    visit user_post_path(users(:ben), posts(:loving))

    assert_text posts(:loving).title
  end

  test 'shows the post\'s author' do
    visit user_post_path(users(:ben), posts(:loving))

    assert_text users(:ben).name
  end

  test 'shows how many comments the post has' do
    visit user_post_path(users(:ben), posts(:loving))

    assert_text "Comments: #{posts(:loving).comments_counter}"
  end

  test 'shows how many likes the post has' do
    visit user_post_path(users(:ben), posts(:loving))

    assert_text "Likes: #{posts(:loving).likes_counter}"
  end

  test 'shows the post\'s body' do
    visit user_post_path(users(:ben), posts(:loving))

    assert_text posts(:loving).text
  end

  test 'shows the commentor\'s username' do
    visit user_post_path(users(:ben), posts(:loving))

    comment = posts(:loving).comments.first

    assert_text comment.user.name
  end

  test 'shows the comment' do
    visit user_post_path(users(:ben), posts(:loving))

    comment = posts(:loving).comments.first

    assert_text comment.text
  end
end
