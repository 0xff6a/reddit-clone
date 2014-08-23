FactoryGirl.define do
  
  factory :test_post, class: Post do
    title 	'text post'
    text  	'waffle waffle'
    user_id 1
  end

  factory :test_user, class: User do
    email                 'test@test.com'
    password              '12345678'
    password_confirmation '12345678'
  end

end