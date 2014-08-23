require 'rails_helper'

describe 'Comments:' do

	before(:each) { create(:test_post) }
	
	context 'when a user is logged in' do

		before(:each) { _create_and_login_test_user }

		it 'they can comment on a post' do
			visit posts_path
			click_link '0 comments'
			fill_in 'new_comment_text', with: 'Agree'
			click_on 'Save'
			expect(page).to have_content('Your comments have been noted...')
			expect(page).to have_css('a', text: '1 comment')
		end

		it 'they see an error message if the comment has no text' do
			visit posts_path
			click_link '0 comments'
			fill_in 'new_comment_text', with: ''
			click_on 'Save'
			expect(page).to have_content('Your comment must have text')
			expect(page).to have_css('a', text: '0 comments')
		end
	
	end

end