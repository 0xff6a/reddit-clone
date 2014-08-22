require 'rails_helper'

describe 'Posting:' do 	

	context 'when there are no posts' do

		it 'should display a message' do
			visit '/'
			expect(page).to have_content('No posts yet')
		end

		it 'should have a link to add posts' do
			visit '/'
			expect(page).to have_css('a', text: 'New Post')
		end

		xit 'should allow a user to add posts' do

		end
	
	end

	context 'when there are posts' do

		xit 'should display them on the homepage' do

		end

	end

end