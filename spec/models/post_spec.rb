require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:post2) { FactoryGirl.create(:post) }

  describe "create" do
    it "post is not saved if no description provided" do
      post = FactoryGirl.build(:post, description: '')
      expect(post).to be_a(Post)
      expect(post).not_to be_valid
    end
  end

  describe "update" do
    it "post is updated when address changed" do
      post2.update(description: 'I will bring cookies')
      expect(Post.first.description).to eq('I will bring cookies')
    end
  end

  describe "delete" do
    it "Post can be deleted" do
      post = FactoryGirl.create(:post)
      expect(Post.all.count).to eq(1)
      post.destroy
      expect(Post.all.count).to eq(0)
    end
  end
end
