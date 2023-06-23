# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, "モデルに関するテスト", type: :model do
  describe '実際に保存してみる' do
    it "会員の新規登録が保存されるか" do
      user = FactoryBot.create(:user)
      expect(user).to be_valid
    end
  end

  describe 'バリデーションのテスト' do
    subject { user.valid? }

    let!(:other_user) { create(:user) }
    let(:user) { build(:user) }

    context 'nameカラム' do
      it '空欄でないこと' do
        user.name = ''
        is_expected.to eq false
      end
      it '15文字以下であること' do
        user.name = Faker::Lorem.characters(number: 15)
        is_expected.to eq true
      end
      it '16文字の場合保存されない' do
        user.name = Faker::Lorem.characters(number: 16)
        is_expected.to eq false
      end
    end

    context 'introductionカラム' do
      it '50文字以下であること' do
        user.introduction = Faker::Lorem.characters(number: 50)
        is_expected.to eq true
      end
      it '51文字の場合保存されない' do
        user.introduction = Faker::Lorem.characters(number: 51)
        is_expected.to eq false
      end
    end

    context "空白のバリデーションチェック" do
      it "名前が空白の場合にバリデーションチェックされ空白のエラーメッセージが返ってきているか" do
        user = User.new(name: "", email: "test@example.com", password: "password")
        expect(user).to be_invalid
        expect(user.errors[:name]).to include("を入力してください")
      end
      it "メールが空白の場合にバリデーションチェックされ空白のエラーメッセージが返ってきているか" do
        user = User.new(name: "Test User", email: "", password: "password")
        expect(user).to be_invalid
        expect(user.errors[:email]).to include("を入力してください")
      end
      it "パスワードが空白の場合にバリデーションチェックされ空白のエラーメッセージが返ってきているか" do
        user = User.new(name: "Test User", email: "test@example.com", password: "")
        expect(user).to be_invalid
        expect(user.errors[:password]).to include("を入力してください")
      end
    end
  end

  describe 'アソシエーションのテスト' do
    context 'CounselingPostモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:counseling_posts).macro).to eq :has_many
      end
    end
  end
end