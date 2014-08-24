require 'rails_helper'

RSpec.describe Comment, :type => :model do
  
  let(:post) 				{ create(:test_post) 																								}
  let(:user) 				{ create(:test_user) 																								}
  let(:new_comment) { Comment.create(text: 'blah', post_id: post.id, user_id: user.id) 	}

	context 'validations' do

		it 'must have text' do
			comment = Comment.create(post_id: post.id, user_id: user.id)
			expect(comment).not_to be_valid
			expect(comment.errors.messages[:text]).to include('Your comment must have text')
		end

		it 'must belong to a post or a parent' do
			comment = Comment.create(text: 'blah', user_id: user.id)
			expect(comment).not_to be_valid
			expect(comment.errors.messages[:post_id]).to include('Your comment must reference a post or a comment')
			expect(comment.errors.messages[:parent_id]).to include('Your comment must reference a post or a comment')
		end

		it 'must not belong to both a post and a parent' do
			comment = Comment.create(text: 'blah', user_id: user.id, post_id: post.id, parent_id: new_comment.id)
			expect(comment).not_to be_valid
			expect(comment.errors.messages[:post_id]).to include('Your comment cannot reference both a post and a comment')
			expect(comment.errors.messages[:parent_id]).to include('Your comment cannot reference both a post and a comment')
		end

		it 'must belong to a user' do
			comment = Comment.create(text: 'blah', post_id: post.id)
			expect(comment).not_to be_valid
			expect(comment.errors.messages[:user_id]).to include('You must be signed in to comment')
		end

		it 'should be valid with text, a post and a user' do
			comment = Comment.create(text: 'blah', post_id: post.id, user_id: user.id)
			expect(comment).to be_valid
		end

		it 'should be valid with text, a parent and a user' do
			parent = Comment.create(text: 'blah', post_id: post.id, user_id: user.id)
			comment = Comment.create(text: 'blah', parent_id: parent.id, user_id: user.id)
			expect(comment).to be_valid
		end
	
	end

	context 'replies' do

		it 'can be linked to another comment' do
			reply = Comment.create(text: 'reply', user_id: user.id, parent_id: new_comment.id)
			expect(new_comment.replies).to include(reply)
		end
		
	end

end
