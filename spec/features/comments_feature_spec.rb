require 'rails_helper'

describe 'Comments:' do

	let(:post) { create(:test_post) }

	before(:each) do 
		_create_and_login_test_user
		post.save
	end
			
	context 'when there are no comments' do

		it 'they can comment on a post' do
			_add_a_comment_to_none('Agree')
			expect(page).to have_content('Your comments have been noted...')
			expect(page).to have_css('a', text: '1 comment')
		end

		it 'they see an error message if the comment has no text' do
			_add_a_comment_to_none('')
			expect(page).to have_content('Your comment must have text')
			expect(page).to have_css('a', text: '0 comments')
		end
	
	end

	context 'when there are comments' do

		before(:each) { create(:test_comment, text: 'Agreed', post_id: post.id)}

		it 'they are displayed when the user visits the comments page for a post' do
			visit posts_path
			click_link '1 comment'
			expect(page).to have_content(post.text)
			expect(page).to have_content('Agreed')
		end	

		it 'a user should be able to reply to a comment on the comments page' do
			_reply_to_comment_with('Ditto')
			expect(page).to have_content('Ditto')
		end

		it 'a user cannot reply with a blank comment' do
			_reply_to_comment_with('')
			expect(page).to have_content('Your comment must have text')
		end

	end

end