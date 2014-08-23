require 'rails_helper'

describe 'User management:' do
	
	context 'when signed out' do

		it 'a user can sign up' do
			_sign_up_test_user
			expect(page).to have_content('Welcome! You have signed up successfully')
			expect(page).to have_content('test@test.com')
		end

		it 'a user can sign in' do
			create(:test_user)
			_sign_in_test_user
			expect(page).to have_content('Signed in successfully')
			expect(page).to have_content('test@test.com')
		end

	end

	context 'when signed in' do

		before(:each) { _create_and_login_test_user }

		xit 'a user can sign out' do
			_sign_out
			expect(page).to have_content('Signed out successfully')
			expect(page).not_to have_content('test@test.com')
		end

	end

	context 'content access rights' do

		xit 'a user must be signed in to post' do
			visit posts_path
			expect(page).not_to have_css 'a', text: 'New Post'
			_create_and_login_test_user
			visit posts_path
			expect(page).to have_css 'a', text: 'New Post'
		end

	end

end