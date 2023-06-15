# frozen_string_literal: true

require 'rails_helper'


describe "ユーザーの新規登録テスト" do
  before do
    visit new_user_registration_path
  end

  context '表示内容の確認' do
    it 'URLが正しいか' do
      expect(current_path).to eq '/users/sign_up'
    end
    it '新規登録と表示されているか' do
      expect(page).to have_content 'アカウント作成'
    end
    it 'nameフォームが表示されているか' do
      expect(page).to have_field 'user[name]'
    end
    it 'emailフォームが表示されているか' do
      expect(page).to have_field 'user[email]'
    end
    it 'passwordフォームが表示されているか' do
      expect(page).to have_field 'user[password]'
    end
    it 'password_confirmationフォームが表示されているか' do
      expect(page).to have_field 'user[password_confirmation]'
    end
    it '新規登録ボタンが表示されているか' do
      expect(page).to have_button 'はじめよう'
    end
  end

  context '新規登録のテスト' do
    before do
      fill_in 'user[name]', with: Faker::Lorem.characters(number: 10)
      fill_in 'user[email]', with: Faker::Internet.email
      fill_in 'user[password]', with: 'password'
      fill_in 'user[password_confirmation]', with: 'password'
    end

    it '新規登録する' do
      expect { click_button 'はじめよう' }.to change(User.all, :count).by(1)
    end
    it '新規登録後のリダイレクト先が、ユーザのマイページ画面になっているか' do
      click_button 'はじめよう'
      expect(current_path).to eq '/users/' + User.last.id.to_s
    end

    it "新規登録に失敗する" do
      fill_in 'user[name]', with: ' '
      fill_in 'user[email]', with: ' '
      fill_in 'user[password]', with: ' '
      fill_in 'user[password_confirmation]', with: ' '
      click_button "はじめよう"
      expect(current_path).to eq('/users')
    end
  end
end

describe "ログインテスト" do
  let(:user) { create(:user) }

  before do
    visit new_user_session_path
  end

  context '表示内容の確認' do
    it 'URLが正しいか' do
      expect(current_path).to eq '/users/sign_in'
    end
    it '「ログイン」と表示されているか' do
      expect(page).to have_content 'ログイン'
    end
    it 'emailフォームが表示されているか' do
      expect(page).to have_field 'user[email]'
    end
    it 'passwordフォームが表示されているか' do
      expect(page).to have_field 'user[password]'
    end
    it 'ログインボタンが表示されているか' do
      expect(page).to have_button 'ログイン'
    end
  end

  context 'ログインする' do
    before do
      fill_in 'user[email]', with: user.email
      fill_in 'user[password]', with: user.password
      click_button 'ログイン'
    end

    it 'ログイン後のリダイレクト先が、ユーザのマイページ画面になっているか' do
      expect(current_path).to eq '/users/' + user.id.to_s
    end
  end

  context 'ログイン失敗する' do
    before do
      fill_in 'user[email]', with: ''
      fill_in 'user[password]', with: ''
      click_button 'ログイン'
    end

    it 'ログインに失敗し、ログイン画面にリダイレクトされているか' do
      expect(current_path).to eq '/users/sign_in'
    end
  end
end

describe '自分のユーザ詳細画面のテスト' do
  let(:user) { create(:user) }
  let!(:counseling_post) { create(:counseling_post, user: user) }

  before do
    visit new_user_session_path
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    click_button 'ログイン'
    visit user_path(user)
  end

  context '表示の確認' do
    it 'URLが正しい' do
      expect(current_path).to eq '/users/' + user.id.to_s
    end
    it "アイコン画像が表示されているか" do
      expect(page).to have_selector('.user-image')
    end
    it "ユーザー名が表示されているか" do
      expect(page).to have_content user.name
    end
    it "編集ボタンが存在しているか" do
      expect(page).to have_link "編集"
    end
    it "参考になった相談一覧のリンクが存在しているか" do
      expect(page).to have_link "参考になった投稿"
    end
    it "投稿した相談一覧のリンクが存在しているか" do
      expect(page).to have_link "相談した投稿"
    end
  end

  context "詳細画面の遷移の確認" do
    it "編集ボタンをクリックする" do
      click_on "編集"
      expect(current_path).to eq("/users/" + user.id.to_s + "/edit")
    end
  end
end

describe "ユーザー編集画面" do
  let(:user) { create(:user) }

  before do
    visit new_user_session_path
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    click_button 'ログイン'
    visit edit_user_path(user)
  end

  context "ユーザー編集画面に情報入力フォームが存在しているか" do
    it "ユーザー名の入力フォームが存在しているか" do
      expect(find_field('user[name]').value).to eq(user.name)
    end
    it "自己紹介の入力フォームが存在しているか" do
      expect(page).to have_field('user[introduction]')
    end
    it "アイコン画像が表示されているか" do
      expect(page).to have_selector('.user-image')
    end
    it "更新ボタンが表示されているか" do
      expect(page).to have_button('更新する')
    end
    it "退会ボタンが存在しているか" do
      expect(page).to have_link "退会する"
    end
  end

  context '更新されユーザー詳細画面に遷移するか' do
    it "情報を入力して更新ボタンをクリックする" do
      attach_file 'user[profile_image]', Rails.root.join('spec', 'fixtures', 'test_image.jpg')
      fill_in 'user[name]', with: Faker::Lorem.characters(number: 9)
      fill_in 'user[introduction]', with: Faker::Lorem.characters(number: 19)
      click_button '更新する'
      expect(current_path).to eq '/users/' + user.id.to_s
    end
  end

  context "更新が失敗した時の処理" do
    it "名前の入力フォームが空の場合" do
      fill_in 'user[name]', with: ' '
      fill_in 'user[introduction]', with: Faker::Lorem.characters(number:20)
      click_button '更新'
      expect(current_path).to eq('/users/' + user.id.to_s)
      have_content "名前 を入力してください"
    end
  end
end