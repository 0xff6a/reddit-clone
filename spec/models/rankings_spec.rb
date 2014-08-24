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

	end

end