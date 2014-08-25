FactoryGirl.define do
  
  factory :test_post, class: Post do
    title 	'text post'
    text  	'waffle waffle'
    user_id 1
  end

  factory :link_post, class: Post do
    title     'imagey'
    url       'http://i.imgur.com/JJ3TOHT.gif'
    user_id   1
  end

  factory :test_user, class: User do
    email                 'test@test.com'
    password              '12345678'
    password_confirmation '12345678'
  end

  factory :test_comment, class: Comment do
  	text 			'Agreed'
  	post_id 	1
    user_id   1
  end

  factory :up_vote, class: Vote do
    value   1
    post_id 1
    user_id 1
  end

  factory :down_vote, class: Vote do
    value   -1
    post_id 1
    user_id 1
  end

end