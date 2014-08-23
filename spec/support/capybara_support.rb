def _create_text_post(title, text)
	visit posts_path
	click_link 'Post New Text'
	fill_in 'new_post_title', with: title
	fill_in 'new_post_text', with: text
	click_on 'Post'
end

def _create_url_post(title, url)
	visit posts_path
	click_link 'Post New Link'
	fill_in 'new_post_title', with: title
	fill_in 'new_post_url', with: url
	click_on 'Post'
end

def _sign_up_test_user
	visit posts_path
	click_link 'Sign Up'
	fill_in 'user_email', with: 'test@test.com'
	fill_in 'user_password', with: '12345678'
	fill_in 'user_password_confirmation', with: '12345678'
	click_on 'Sign up'
end

def _sign_in_test_user
	visit posts_path
	click_link 'Sign In'
	fill_in 'user_email', with: 'test@test.com'
	fill_in 'user_password', with: '12345678'
	click_on 'Sign in'
end

def _sign_out
	visit posts_path
	click_link 'Sign Out'
end