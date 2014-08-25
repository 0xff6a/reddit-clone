def _create_text_post(title, text)
	visit posts_path
	click_link 'Post New Text'
	fill_in 'new_post_title', with: title
	fill_in 'new_post_text', with: text
	within('#new_post'){ click_button 'Post' }
end

def _create_url_post(title, url)
	visit posts_path
	click_link 'Post New Link'
	fill_in 'new_post_title', with: title
	fill_in 'new_post_url', with: url
	within('#new_post'){ click_button 'Post' }
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

def _add_a_comment_to_none(text)
	visit posts_path
	click_link '0 comments'
	fill_in 'new_comment_text', with: text
	click_on 'Save'
end

def _reply_to_comment_with(text)
	visit posts_path
	click_link '1 comment'
	click_link 'Reply'
	fill_in 'new_reply_text', with: text
	click_on 'Save'
end

def _search_for(text)
	visit posts_path
	fill_in 'Search', with: text
	click_on 'Find'
end