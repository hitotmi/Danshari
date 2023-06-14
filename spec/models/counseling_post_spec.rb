# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CounselingPost, "モデルに関するテスト", type: :model do
  describe '実際に保存してみる' do
    it "有効な投稿内容の場合は保存されるか" do
      user = FactoryBot.create(:user) # Userオブジェクトを作成
      expect(FactoryBot.build(:counseling_post, user: user)).to be_valid
    end
  end

  context "空白のバリデーションチェック" do
    it "titleが空白の場合にバリデーションチェックされ空白のエラーメッセージが返ってきているか" do
      user = FactoryBot.create(:user) # Userオブジェクトを作成

      counseling_post = CounselingPost.new(title: '', content: 'hoge', user: user)
      expect(counseling_post).to be_invalid
      expect(counseling_post.errors[:title]).to include("を入力してください")
    end

    it "contentが空白の場合にバリデーションチェックされ空白のエラーメッセージが返ってきているか" do
      user = FactoryBot.create(:user) # Userオブジェクトを作成

      counseling_post = CounselingPost.new(title: 'hoge', content: '', user: user)
      expect(counseling_post).to be_invalid
      expect(counseling_post.errors[:content]).to include("を入力してください")
    end

    it "statusが空白の場合にバリデーションチェックされ空白のエラーメッセージが返ってきているか" do
      user = FactoryBot.create(:user) # Userオブジェクトを作成

      counseling_post = CounselingPost.new(title: 'hoge', content: 'hoge', status: '', user: user)
      expect(counseling_post).to be_invalid
      expect(counseling_post.errors[:status]).to include("を入力してください")
    end
  end
end
