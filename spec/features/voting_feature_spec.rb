require 'rails_helper'

describe 'Voting:' do

	let(:post) 				{ create(:test_post) }
	let(:other_post)	{ create(:test_post, title: 'better post') }

	before(:each) do
		_create_and_login_test_user
		post.save
		other_post.save
	end
	
	context 'when there are posts', js: true do

		it 'a user can vote a post up' do
			vote_for(post, 'up')
			expect(page).to have_css('.vote-count', text: '1')
		end

		it 'a user can vote a post down' do
			create(:up_vote, post_id: post.id)
			vote_for(post, 'down')
			expect(page).to have_css('.vote-count', text: '0')
		end

		it 'they are ranked by their vote count' do
			create(:up_vote, post_id: other_post.id)
			visit posts_path
			expect(other_post.title).to appear_before post.title
		end

	end

end