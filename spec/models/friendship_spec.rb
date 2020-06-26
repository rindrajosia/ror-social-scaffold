require 'rails_helper'

RSpec.describe Friendship, type: :model do
  context 'friend column is for User class' do
    friend = User.new
    it 'should be a user' do
      expect(friend).to be_an_instance_of(User)
    end
  end
end
