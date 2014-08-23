require 'rails_helper'

RSpec.describe Comment, :type => :model do
  
	context 'validations' do

		let(:post) { create(:test_post) }

		it 'must have text' do
			comment = Comment.create(text: '', post_id: post.id)
			expect(comment).not_to be_valid
			expect(comment.errors.messages[:text]).to include('Your comment must have text')
		end

		it 'should belong to a post' do
			comment = Comment.create(text: 'blah')
			expect(comment).not_to be_valid
			expect(comment.errors.messages[:post_id]).to include('You must be signed in to comment')
		end
	
	end

end
