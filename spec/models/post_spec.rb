require 'rails_helper'

RSpec.describe Post, type: :model do
  context 'Post content' do
    it 'content must be present' do
      post = Post.new(content: nil)
      post.valid?
      expect(post.errors.full_messages).to include(/Content can't be blank/)
    end
    it 'content must have 1000 characters' do
      post = Post.new(content: 1000.to_i)
      expect(post.content.length).to be <= 1000.to_i
    end
  end
end
