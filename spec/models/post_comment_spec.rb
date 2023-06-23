require 'rails_helper'

RSpec.describe PostComment, "モデルに関するテスト", type: :model do
  describe '実際に保存してみる' do
    it "コメントが保存されるか" do
      expect(FactoryBot.build(:post_comment)).to be_valid
    end
  end

  describe 'バリデーションのテスト' do
    subject { post_comment.valid? }

    let(:post_comment) { FactoryBot.build(:post_comment) }

    context '空白のバリデーションチェック' do
      it 'commentが空白の場合にバリデーションチェックされ、空白のエラーメッセージが返ってきている' do
        post_comment = PostComment.new(comment: '')
        expect(post_comment).to be_invalid
        expect(post_comment.errors[:comment]).to include("を入力してください")
      end
    end

    context 'commentカラム' do
      it '500文字以下であること' do
        post_comment.comment = Faker::Lorem.characters(number: 500)
        is_expected.to eq true
      end
      it '501文字の場合保存されない' do
        post_comment.comment = Faker::Lorem.characters(number: 501)
        is_expected.to eq false
      end
    end
  end

  describe 'アソシエーションのテスト' do
    context 'userモデルとの関係' do
      it 'N:1となっている' do
        expect(PostComment.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end
    context 'CounselingPostモデルとの関係' do
      it 'N:1となっている' do
        expect(PostComment.reflect_on_association(:counseling_post).macro).to eq :belongs_to
      end
    end
  end
end
