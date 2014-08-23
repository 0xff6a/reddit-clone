require 'rails_helper'

RSpec.describe Comment, :type => :model do
  
	context 'validations' do

		let(:post) { create(:test_post) }
		let(:user) { create(:test_user) }

		it 'must have text' do
			comment = Comment.create(post_id: post.id, user_id: user.id)
			expect(comment).not_to be_valid
			expect(comment.errors.messages[:text]).to include('Your comment must have text')
		end

		it 'must belong to a post' do
			comment = Comment.create(text: 'blah', user_id: user.id)
			expect(comment).not_to be_valid
			expect(comment.errors.messages[:post_id]).to include('You must comment a post')
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
	
	end

end
