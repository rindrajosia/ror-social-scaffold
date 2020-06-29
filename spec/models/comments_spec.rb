require 'rails_helper'

RSpec.describe Post, type: :model do
  context 'Comments validations' do
    it 'content must not be empty' do
      comments = Comment.new(content: nil)
      comments.valid?
      expect(comments.content).to be_falsy
    end
    it 'content must have 200 characters' do
      comments = Comment.new(content: 100.to_i)
      expect(comments.content.length).to be <= 200.to_i
    end
  end
  context "Comments associations" do
    describe Comment do
        it { should belong_to(:user) }
        it { should belong_to(:post) }
      end
  end
  
end
