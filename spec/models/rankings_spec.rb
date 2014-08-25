require 'rails_helper'

describe 'Ranking Posts' do

	let(:user) 				{ create(:test_user) 																						}
	let(:sample_post) { Post.create(title: 'Test', text: 'waffle', user_id: user.id) 	}

	context '#rank' do

		context 'default algorithm' do

			it 'should return 1 if there are no other posts' do
				expect(sample_post.rank(:default)).to eq(1)
			end

			it 'should return 2 if post has lower vote-total than the other post' do
				better_post = Post.create(title: 'Best', text: '....', user_id: user.id)
				better_post.votes.create(value: 1, user_id: user.id)
				expect(sample_post.rank(:default)).to eq(2)
			end

			it 'should return 1 if post has higher vote-total than the other post' do
				worse_post = Post.create(title: 'Worse', text: '....', user_id: user.id)
				sample_post.votes.create(value: 1, user_id: user.id)
				expect(sample_post.rank(:default)).to eq(1)
			end

			it 'should return 1 if the post has a lower vote total, but is much newer' do
				old_post = Post.create(created_at: 2.days.ago, title: 'Old', text: '....', user_id: user.id)
				10.times { |n| old_post.votes.create(value: 1, user_id: n) }
				sample_post.votes.create(value: 1, user_id: 1)
				expect(sample_post.rank(:default)).to eq(1)
			end

		end

		context 'fresh algorithm' do

			it 'should return 1 if the post was created before other posts' do
				old_post = Post.create(created_at: _one_hour_ago, title: 'Old', text: '....', user_id: user.id)
				expect(sample_post.rank(:fresh)).to eq(1)
			end

			it 'should return 2 if the post was created after other posts' do
				future_post = Post.create(created_at: _one_hour_ahead, title: 'Future', text: '....', user_id: user.id)
				expect(sample_post.rank(:fresh)).to eq(2)
			end

			it 'should return 1 if the post was created before other posts regardless of votes' do
				old_post = Post.create(created_at: _one_hour_ago, title: 'Old', text: '....', user_id: user.id)
				10.times { |n| old_post.votes.create(value: 1, user_id: n) }
				expect(sample_post.rank(:fresh)).to eq(1)
			end

		end

		context 'controversial algorithm' do

			it 'should return 1 if the post has a greater absolute number of votes than the other post' do
				controversial_post = Post.create(title: '?', text: '....', user_id: user.id, created_at: _one_hour_ago)
				_up_vote_n_times_for(controversial_post,5)
				_down_vote_n_times_for(controversial_post, 5, 4)
				expect(controversial_post.rank(:controversial)).to eq(1)
				expect(sample_post.rank(:controversial)).to eq(2)
			end

			it 'should return 1 if the post a greater absolute number of votes and less upvotes than the other post' do
				controversial_post = Post.create(title: '?', text: '....', user_id: user.id, created_at: _one_hour_ago)
				_up_vote_n_times_for(controversial_post,1)
				_down_vote_n_times_for(controversial_post, 5, 4)
				expect(controversial_post.rank(:controversial)).to eq(1)
				expect(sample_post.rank(:controversial)).to eq(2)
			end

			it 'should return 1 the post has same absolute votes, but more comments than another' do
				controversial_post = Post.create(title: '?', text: '....', user_id: user.id)
				_up_vote_n_times_for(sample_post,1)
				controversial_post.comments.create(text: 'blah', post_id: controversial_post.id, user_id: user.id)
				controversial_post.comments.create(text: 'blah blah', post_id: controversial_post.id, user_id: user.id)
				expect(controversial_post.rank(:controversial)).to eq(1)
			end

		end

		context 'rising algorithm' do

			
			
		end

	end

end