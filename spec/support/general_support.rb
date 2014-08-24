def have_welcome_message
	have_content('Welcome test@test.com')
end

def have_posting_links
	have_css('a', text: 'Post New Text') && have_css('a', text: 'Post New Link')
end

def have_commenting_form
	have_css('#new_comment')
end

def have_voting_links
	have_css('.up-vote-link')
end

def must_be_signed_in_to?(have_privilege, path)
	visit path
	expect(page).not_to have_privilege
	_create_and_login_test_user
	visit path
	expect(page).to have_privilege
end

def vote_for(post, up_or_down)
	visit root_path
	link_id = "#{post.id}-#{up_or_down}-vote"
	click_link link_id
end