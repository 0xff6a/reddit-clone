require 'rails_helper'

describe 'Posting:' do 	

	before(:each) { _create_and_login_test_user }

	context 'when there are no posts' do

		it 'should display a message' do
			visit posts_path
			expect(page).to have_content('No posts yet')
		end

		it 'should have a link to add posts' do
			visit posts_path
			expect(page).to have_posting_links
		end

		it 'should allow a user to add a text post' do
			_create_text_post('text post', 'waffle waffle')
			expect(page).to have_content('Thank you for posting...')
		end

		it 'should allow a user to add a url post' do
			_create_url_post('url post', 'http://www.google.com')
			expect(page).to have_content('Thank you for posting...')
		end
	
	end

	context 'when there are posts' do

		before(:each) { create(:test_post) }

		it 'should display them on the homepage' do
			visit posts_path
			expect(page).not_to have_content('No posts yet')
			within('.panel-heading') { expect(page).to have_content('text post') }
			within('.post-body') { expect(page).to have_content('waffle waffle') }
		end

	end

	context 'ensuring valid posts' do

		it 'displays an error if post is not valid' do
			_create_text_post('', 'waffle waffle')
			expect(page).to have_content('Your post must have a title')
			expect(page).not_to have_content('waffle waffle')
		end

	end	

end