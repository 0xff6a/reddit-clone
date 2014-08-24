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
			visit root_path
			link_id = "#{other_post.id}-up-vote"
			click_link link_id
			expect(page).to have_css('.vote-count', text: '1')
		end

		it 'a user can vote a post down' do
			create(:up_vote, post_id: other_post.id)
			visit root_path
			link_id = "#{other_post.id}-down-vote"
			click_link link_id
			expect(page).to have_css('.vote-count', text: '0')
		end

		xit 'they are ranked by their vote count' do

		end


	end

end