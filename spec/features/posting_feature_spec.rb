require 'rails_helper'

describe 'Posting:' do 	

	context 'when there are no posts' do

		it 'should display a message' do
			visit posts_path
			expect(page).to have_content('No posts yet')
		end

		it 'should have a link to add posts' do
			visit posts_path
			expect(page).to have_css('a', text: 'Post New Text')
			expect(page).to have_css('a', text: 'Post New Link')
		end

		it 'should allow a user to add a text post' do
			visit posts_path
			click_link 'Post New Text'
			fill_in 'new_post_title', with: 'text post'
			fill_in 'new_post_text', with: 'waffle waffle'
			click_on 'Post'
			expect(page).to have_content('Thank you for posting...')
		end

		it 'should allow a user to add a url post' do
			visit posts_path
			click_link 'Post New Link'
			fill_in 'new_post_title', with: 'url post'
			fill_in 'new_post_url', with: 'http://www.google.com'
			click_on 'Post'
			expect(page).to have_content('Thank you for posting...')
		end
	
	end

	context 'when there are posts' do

		before(:each) { create(:test_post) }

		it 'should display them on the homepage' do
			visit posts_path
			expect(page).not_to have_content('No posts yet')
			within('.post-header') { expect(page).to have_content('text post') }
			within('.post-body') { expect(page).to have_content('waffle waffle') }
		end

	end

	context 'ensuring valid posts' do

		it 'displays an error if post is not valid' do
			visit posts_path
			click_link 'Post New Text'
			fill_in 'new_post_title', with: ''
			fill_in 'new_post_text', with: 'waffle waffle'
			click_on 'Post'
			expect(page).to have_content('Your post must have a title')
			expect(page).not_to have_content('waffle waffle')
		end

	end	

end