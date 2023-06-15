require 'rails_helper'

RSpec.describe PostComment, "モデルに関するテスト", type: :model do
  describe '実際に保存してみる' do
    it "コメントが保存されるか" do
      expect(FactoryBot.build(:post_comment)).to be_valid
    end
  end

  context '空白のバリデーションチェック' do
    it 'commentが空白の場合にバリデーションチェックされ、空白のエラーメッセージが返ってきている' do
      post_comment = PostComment.new(comment: '')
      expect(post_comment).to be_invalid
      expect(post_comment.errors[:comment]).to include("を入力してください")
    end
  end
end
