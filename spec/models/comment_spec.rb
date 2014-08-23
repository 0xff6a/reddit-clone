require 'rails_helper'

RSpec.describe Comment, :type => :model do
  
	context 'validations' do

		it 'should belong to a post' do
			comment = Comment.create(text: 'blah')
			expect(comment).not_to be_valid
			expect(comment.errors.messages[:post_id]).to include('You must be signed in to comment')
		end
	
	end

end
