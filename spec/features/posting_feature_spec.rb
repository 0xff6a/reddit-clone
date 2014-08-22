require 'rails_helper'

describe 'Posting:' do 	

	context 'when there are no posts' do

		it 'should display a message' do
			visit posts_path
			expect(page).to have_content('No posts yet')
		end

		it 'should have a link to add posts' do
			visit posts_path
			expect(page).to have_css('a', text: 'New Post')
		end

		it 'should allow a user to add a text post' do
			visit posts_path
			click_link 'New Post'
			fill_in 'Title', with: 'text post'
			fill_in 'Text', with: 'waffle waffle'
			click_on 'Post'
			expect(page).to have_content('Thank you for posting...')
		end
	
	end

	context 'when there are posts' do

		before(:each) { Post.create(title: 'text post', text: 'waffle waffle')}

		it 'should display them on the homepage' do
			visit posts_path
			within('#post-body') do
				expect(page).to have_content('text post')
				expect(page).to have_content('waffle waffle')
			end 
		end

	end

end