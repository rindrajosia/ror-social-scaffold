require "rails_helper"

RSpec.describe Like, type: :model do
  context "like associations" do
    describe Like do
      it { should belong_to(:user) }
      it { should belong_to(:post) }
    end
  end
end
