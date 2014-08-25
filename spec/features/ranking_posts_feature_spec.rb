require 'rails_helper'

describe 'Post rankings:' do

	let(:new_post) 	{ create(:test_post, title: 'New Post') 														}
	let(:old_post)	{ create(:test_post, title: 'Old Post', created_at: _one_hour_ago) 	}
	
	before(:each) do
		new_post.save
		old_post.save
	end

	context 'using the fresh algorithm' do

		before(:each) { create(:up_vote, post_id: old_post.id) }

		it 'should rank posts by timestamp only' do
			visit fresh_posts_path
			expect(new_post.title).to appear_before old_post.title
		end

		it 'should display the ranking of each post' do
			visit fresh_posts_path
			within("#post-#{new_post.id}") { expect(page).to have_css('var.rank', text: '1')}
			within("#post-#{old_post.id}") { expect(page).to have_css('var.rank', text: '2')}
		end

	end

end