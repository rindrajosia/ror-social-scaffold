require 'rails_helper'

RSpec.describe Post, type: :model do
  context 'User validations' do
    it 'username must be present' do
      user = User.new
      user.name = 'herve'
      user.valid?
      expect(user.name).to be_truthy
    end
  end
  context "User's associations" do
    describe User do
      it { should have_many(:posts) }
      it { should have_many(:comments).dependent(:destroy) }
      it { should have_many(:likes).dependent(:destroy) }
      it { should have_many(:friendships) }
      it { should have_many(:friends).through(:friendships) }
      it { should have_many(:inverse_friendships).class_name(:Friendship) }
      it { should have_many(:inverse_friends).through(:inverse_friendships).source(:user) }
    end
  end
end
