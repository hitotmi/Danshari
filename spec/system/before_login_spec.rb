# frozen_string_literal: true

require 'rails_helper'

describe 'ユーザログイン前のテスト' do
  describe 'トップ画面のテスト' do
    before do
      visit root_path
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/'
      end
      it '「ゲストログイン」リンクが表示されているか' do
        expect(page).to have_link "ゲストログイン（閲覧用）", href: users_guest_sign_in_path
      end
      it '「ログイン」リンクが表示されているか' do
        expect(page).to have_link "ログイン", href: new_user_session_path
      end
      it '「ユーザー登録」リンクが表示されているか' do
        expect(page).to have_link "新規登録", href: new_user_registration_path
      end
    end
  end

  describe 'ヘッダーのテスト: ログインしていない場合' do
    before do
      visit root_path
    end

    context '表示内容の確認' do
      it '新規登録リンクが表示される: 左上から1番目のリンクが「新規登録」である' do
        home_link = find_all('a')[1].native.inner_text
        expect(home_link).to match(/新規登録/i)
      end
      it 'ログインリンクが表示される: 左上から2番目のリンクが「ログイン」である' do
        login_link = find_all('a')[2].native.inner_text
        expect(login_link).to match(/ログイン/i)
      end
    end

    context 'リンクの内容を確認' do
      subject { current_path }

      it '新規登録を押すと、新規登録画面に遷移する' do
        within('header') do
         click_link '新規登録'
         end
        is_expected.to eq '/users/sign_up'
      end
      it 'loginを押すと、ログイン画面に遷移する' do
        within('header') do
         click_link 'ログイン'
         end
        is_expected.to eq '/users/sign_in'
      end
    end
  end

end