# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CounselingPost, "モデルに関するテスト", type: :model do
  describe '実際に保存してみる' do
    it "有効な投稿内容の場合は保存されるか" do
      user = FactoryBot.create(:user) # Userオブジェクトを作成
      expect(FactoryBot.build(:counseling_post, user: user)).to be_valid
    end
  end

  describe 'バリデーションのテスト' do
    subject { counseling_post.valid? }

    let(:counseling_post) { build(:counseling_post) }

    context 'titleカラム' do
      it '50文字以下であること' do
        counseling_post.title = Faker::Lorem.characters(number: 50)
        is_expected.to eq true
      end
      it '51文字の場合保存されない' do
        counseling_post.title = Faker::Lorem.characters(number: 51)
        is_expected.to eq false
      end
    end

    context 'contentカラム' do
      it '500文字以下であること' do
        counseling_post.content = Faker::Lorem.characters(number: 500)
        is_expected.to eq true
      end
      it '501文字の場合保存されない' do
        counseling_post.content = Faker::Lorem.characters(number: 501)
        is_expected.to eq false
      end
    end

    context "空白のバリデーションチェック" do
      it "titleが空白の場合にバリデーションチェックされ空白のエラーメッセージが返ってきているか" do
        user = FactoryBot.create(:user)
        counseling_post = CounselingPost.new(title: '', content: 'hoge', user: user)
        expect(counseling_post).to be_invalid
        expect(counseling_post.errors[:title]).to include("を入力してください")
      end

      it "contentが空白の場合にバリデーションチェックされ空白のエラーメッセージが返ってきているか" do
        user = FactoryBot.create(:user)
        counseling_post = CounselingPost.new(title: 'hoge', content: '', user: user)
        expect(counseling_post).to be_invalid
        expect(counseling_post.errors[:content]).to include("を入力してください")
      end

      it "statusが空白の場合にバリデーションチェックされ空白のエラーメッセージが返ってきているか" do
        user = FactoryBot.create(:user)
        counseling_post = CounselingPost.new(title: 'hoge', content: 'hoge', status: '', user: user)
        expect(counseling_post).to be_invalid
        expect(counseling_post.errors[:status]).to include("を入力してください")
      end
    end
  end

  describe 'アソシエーションのテスト' do
    context 'Userモデルとの関係' do
      it 'N:1となっている' do
        expect(CounselingPost.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end
  end
end
