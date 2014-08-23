def _create_and_login_test_user
	user = create(:test_user)
	login_as user
end

def have_voting_links
	have_css('a', text: 'Post New Text') && have_css('a', text: 'Post New Link')
end
