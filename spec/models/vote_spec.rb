require 'rails_helper'

RSpec.describe Vote, :type => :model do

	let(:user) { create(:test_user) }
	let(:post) { create(:test_post) }
  
	context 'validations' do

		it 'should have a numeric value' do
			vote = Vote.create(value:'bad', user_id: user.id, post_id: post.id)
			expect(vote).not_to be_valid
			expect(vote.errors.messages[:value]).to include('Value must be a number')
		end

		it 'should have a value +/-1' do
			vote = Vote.create(value: 3, user_id: user.id, post_id: post.id)
			expect(vote).not_to be_valid
			expect(vote.errors.messages[:value]).to include('Value must be either +1 or -1')
		end

		it 'should belong to a user' do
			vote = Vote.create(value: 1, post_id: post.id)
			expect(vote).not_to be_valid
			expect(vote.errors.messages[:user_id]).to include('You must be signed in to vote')
		end

		it 'should belong to a post' do
			vote = Vote.create(value: 1, user_id: user.id)
			expect(vote).not_to be_valid
			expect(vote.errors.messages[:post_id]).to include('A vote must be assigned to a post')
		end

		it 'should be valid with a value of +/-1, a post and a user' do
			vote = Vote.create(value: 1, user_id: user.id, post_id: post.id)
			expect(vote).to be_valid
		end

	end

end
