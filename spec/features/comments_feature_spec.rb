require 'rails_helper'

describe 'Comments:' do

	before(:each) do 
		_create_and_login_test_user
		@post = create(:test_post)
	end
			
	context 'when there are no comments' do

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

	context 'when there are comments' do

		before(:each) { create(:test_comment, text: 'Agreed', post_id: @post.id)}

		it 'they are displayed when the user visits the comments page for a post' do
			visit posts_path
			click_link '1 comment'
			expect(page).to have_content(@post.text)
			expect(page).to have_content('Agreed')
		end	

	end

end