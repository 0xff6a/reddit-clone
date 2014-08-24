require 'rails_helper'

RSpec.describe Post, :type => :model do

	let(:user) 				{ create(:test_user) 																						}
	let(:sample_post) { Post.create(title: 'Test', text: 'waffle', user_id: user.id) 	}

	context 'validations' do

		it 'must have a title' do
			post = Post.create(text: 'waffle waffle', user_id: user.id)
			expect(post).not_to be_valid
			expect(post.errors.messages[:title]).to include('Your post must have a title')
		end

		it 'must have text or a url' do
			post = Post.create(title: 'Test', user_id: user.id)
			expect(post).not_to be_valid
			expect(post.errors.messages[:text]).to include('Your post must include text or a link')
		end

		it 'if given a url must be in valid format' do
			post = Post.create(title: 'Test', url: 'not a url', user_id: user.id)
			expect(post).not_to be_valid
			expect(post.errors.messages[:url]).to include('Not a valid url format')
		end

		it 'must belong to a user' do
			post = Post.create(title: 'Test', text: 'waffle waffle')
			expect(post).not_to be_valid
			expect(post.errors.messages[:user_id]).to include('You must be signed in to post')
		end

		it 'should be valid with a title, user and text' do
			post = Post.create(title: 'Test', text: 'waffle waffle', user_id: user.id)
			expect(post).to be_valid
		end

		it 'should be valid with a title, user and valid url' do
			post = Post.create(title: 'Test', url:'http://google.com', user_id: user.id)
			expect(post).to be_valid
		end

	end

	context '#vote-total' do

		it 'should return 1 if the post has 1 upvote' do
			sample_post.votes.create(value: 1, user_id: user.id)
			expect(sample_post.vote_total).to eq(1)
		end

		it 'should return 0 if the post has 1 downvote' do
			sample_post.votes.create(value: -1, user_id: user.id)
			expect(sample_post.vote_total).to eq(0)
		end

		it 'should return 0 if the post has 1 upvote and 1 downvote' do
			sample_post.votes.create(value: 1, user_id: user.id)
			sample_post.votes.create(value: -1, user_id: user.id + 1)
			expect(sample_post.vote_total).to eq(0)
		end

		it 'should return 1 if the post has 2 upvotes and 1 downvote' do
			2.times { |n| sample_post.votes.create(value: 1, user_id: n) }
			sample_post.votes.create(value: -1, user_id: user.id)
			expect(sample_post.vote_total).to eq(1)
		end

	end

	context '#rank' do

		it 'should return 1 if there are no other posts' do
			expect(sample_post.rank).to eq(1)
		end

		it 'should return 2 if post has lower vote-total than the other post' do
			better_post = Post.create(title: 'Best', text: '....', user_id: user.id)
			better_post.votes.create(value: 1, user_id: user.id)
			expect(sample_post.rank).to eq(2)
		end

		it 'should return 1 if post has higher vote-total than the other post' do
			worse_post = Post.create(title: 'Worse', text: '....', user_id: user.id)
			sample_post.votes.create(value: 1, user_id: user.id)
			expect(sample_post.rank).to eq(1)
		end

	end

	context '#descendants_count' do

		it 'should return 0 when there are no comments on a post' do
			expect(sample_post.descendants_count).to eq(0)
		end

		it 'should return 1 when there is one comment on a post' do
			comment = Comment.create(text: 'comment', user_id: user.id, post_id: sample_post.id)
			expect(sample_post.descendants_count).to eq(1)
		end

		it 'should return 2 when there is 1 reply to 1 comment' do
			comment = Comment.create(text: 'comment', user_id: user.id, post_id: sample_post.id)
			reply = Comment.create(text: 'reply', user_id: user.id, parent_id: comment.id)
			expect(sample_post.descendants_count).to eq(2)
		end

	end

end
