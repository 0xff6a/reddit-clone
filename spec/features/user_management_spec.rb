require 'rails_helper'

describe 'User management:' do
	
	context 'when signed out' do

		it 'a user can sign up' do
			_sign_up_test_user
			expect(page).to have_content('Welcome! You have signed up successfully')
			expect(page).to have_welcome_message
		end

		it 'a user can sign in' do
			create(:test_user)
			_sign_in_test_user
			expect(page).to have_content('Signed in successfully')
			expect(page).to have_welcome_message
		end

	end

	context 'when signed in' do

		before(:each) { _create_and_login_test_user }

		it 'a user can sign out' do
			_sign_out
			expect(page).to have_content('Signed out successfully')
			expect(page).not_to have_welcome_message
		end

	end

	context 'content access rights' do

		before(:each) { create(:test_post) }

		it 'a user must be signed in to post' do
			must_be_signed_in_to?(have_posting_links, posts_path)
		end

		it 'a user must be signed in to comment' do
			must_be_signed_in_to?(have_commenting_form, post_comments_path(Post.first))
		end

		it 'a user must be signed in to vote' do
			must_be_signed_in_to?(have_voting_links, posts_path)
		end

	end

end