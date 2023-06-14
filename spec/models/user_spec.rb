# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, "モデルに関するテスト", type: :model do
  describe '実際に保存してみる' do
    it "会員の新規登録が保存されるか" do
      user = FactoryBot.create(:user)
      expect(user).to be_valid
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