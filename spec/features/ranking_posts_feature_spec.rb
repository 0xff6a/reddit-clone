require 'rails_helper'

describe 'Post rankings:' do

	let(:new_post) 	{ create(:test_post, title: 'New Post') 														}
	let(:old_post)	{ create(:test_post, title: 'Old Post', created_at: _one_hour_ago) 	}
	
	before(:each) do
		new_post.save
		old_post.save
	end

	context 'default' do

	end

	context 'controversial' do

	end

	context 'rising' do

	end

	context 'fresh' do

		before(:each) { create(:up_vote, post_id: old_post.id) }

		it 'should rank posts by timestamp only' do
			visit fresh_posts_path
			expect(new_post.title).to appear_before old_post.title
		end

	end

end