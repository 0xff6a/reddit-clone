def _create_and_login_test_user
	user = create(:test_user)
	login_as user
end

def have_welcome_message
	have_content('Welcome test@test.com')
end

def have_posting_links
	have_css('a', text: 'Post New Text') && have_css('a', text: 'Post New Link')
end

def have_commenting_links
	have_css('.comments-link')
end

def have_voting_links
	have_css('.up-vote-link')
end

def must_be_signed_in_to?(have_privilege)
	visit posts_path
	expect(page).not_to have_privilege
	_create_and_login_test_user
	visit posts_path
	expect(page).to have_privilege
end