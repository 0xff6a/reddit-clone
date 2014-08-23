require 'rails_helper'

RSpec.describe Post, :type => :model do

	context 'validations' do

		it 'must have a title' do
			post = Post.create(text: 'waffle waffle')
			expect(post).not_to be_valid
			expect(post.errors.messages[:title]).to include('Your post must have a title')
		end

	end

end
