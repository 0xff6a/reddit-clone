require 'rails_helper'

describe 'Voting:' do

	let(:post) 				{ create(:test_post) }
	let(:other_post)	{ create(:test_post, title: 'better post') }

	before(:each) do
		_create_and_login_test_user
		post.save
		other_post.save
	end
	
	context 'when there are posts' do

		it 'a user can vote a post up', js: true do
			visit root_path
			link_id = "#{other_post.id}-vote"
			click_link link_id
			expect(page).to have_css('.vote-count', text: '1')
		end

		xit 'a user can vote a post down' do

		end

		xit 'they are ranked by their vote count' do

		end


	end

end