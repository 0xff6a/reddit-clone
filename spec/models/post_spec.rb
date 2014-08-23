require 'rails_helper'

RSpec.describe Post, :type => :model do

	context 'validations' do

		it 'must have a title' do
			post = Post.create(text: 'waffle waffle')
			expect(post).not_to be_valid
			expect(post.errors.messages[:title]).to include('Your post must have a title')
		end

		it 'must have text or a url' do
			post = Post.create(title: 'Test')
			expect(post).not_to be_valid
			expect(post.errors.messages[:text]).to include('Your post must include text or a link')
		end

	end

end
