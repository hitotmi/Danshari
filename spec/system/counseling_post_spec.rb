# frozen_string_literal: true

require 'rails_helper'

describe '投稿のテスト' do
  let(:user) { FactoryBot.create(:user) }
  let!(:counseling_post) { FactoryBot.create(:counseling_post, user: user) }

  before do
    load Rails.root.join('db/seeds.rb')
    visit new_user_session_path
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    click_button 'ログイン'
  end

  describe "投稿画面(new_counseling_post_path)のテスト" do
    before do
      visit new_counseling_post_path
    end
    context '表示の確認' do
      it 'new_counseling_post_pathが"/counseling_posts/new"であるか' do
        expect(current_path).to eq('/counseling_posts/new')
      end
      it "タイトル入力フォームが存在しているか" do
        expect(page).to have_field 'counseling_post[title]'
      end
      it "相談内容入力フォームが存在しているか" do
        expect(page).to have_field 'counseling_post[content]'
      end
      it "投稿の画像フォームが表示されているか" do
        expect(page).to have_selector('input[type="file"][accept="image/*"]')
      end
      it "使用頻度の入力フォームが存在しているか" do
        expect(page).to have_selector('select[name="counseling_post[usage_frequency]"]')
      end
      it "お気に入り度の入力フォームが存在しているか" do
        expect(page).to have_selector('input#review_star', visible: false)
      end
      it "タグの選択フォームが表示されているか" do
        expect(page).to have_selector('input[type="checkbox"][name="counseling_post[tag_ids][]"]', count: Tag.count)
      end
      it '投稿ボタンが表示されているか' do
        expect(page).to have_button '投稿'
      end
    end
    context '投稿処理のテスト' do
      it '投稿後のリダイレクト先は正しいか' do
        attach_file 'counseling_post[image]', Rails.root.join('spec', 'fixtures', 'test_image.jpg')
        fill_in 'counseling_post[title]', with: Faker::Lorem.characters(number:10)
        fill_in 'counseling_post[content]', with: Faker::Lorem.characters(number:30)
        select '毎日', from: 'counseling_post_usage_frequency'
        find('input#review_star', visible: false).set(4)
        check "counseling_post_tag_ids_1"
        click_button '投稿'
        expect(page).to have_current_path counseling_post_path(CounselingPost.last)
      end
    end
    context "投稿が失敗した場合" do
      it "タイトル、相談内容を入力せず投稿ボタンをクリックした場合" do
        click_button '投稿'
        expect(current_path).to eq('/counseling_posts')
        expect(page).to have_content("タイトル を入力してください")
        expect(page).to have_content("相談内容 を入力してください")
      end
    end
  end

  describe "投稿一覧のテスト" do
    before do
      @counseling_post = counseling_post
      visit counseling_posts_path
    end
    context '表示の確認' do
      it 'counseling_posts_pathが"/counseling_posts"であるか' do
        expect(current_path).to eq('/counseling_posts')
      end
      it 'タイトルされたものが表示されているか' do
        expect(page).to have_content @counseling_post.title
      end
      it "相談内容が表示されているか" do
        expect(page).to have_content @counseling_post.content
      end
      it "ステータス(回答受付中・解決済)が存在しているか" do
        expect(page).to have_content @counseling_post.status_i18n
      end
      it '詳細画面へのリンクが存在すること' do
        expect(page).to have_link(href: counseling_post_path(@counseling_post))
      end
    end
  end

  describe "詳細画面のテスト" do
    before do
      @counseling_post = counseling_post
      visit counseling_post_path(@counseling_post)
    end
    context '表示の確認' do
      it 'counseling_post_path(counseling_post)が"/counseling_posts/counseling_post.id"であるか' do
        expect(current_path).to eq("/counseling_posts/" + counseling_post.id.to_s)
      end
      it '削除リンクが存在しているか' do
        expect(page).to have_link('削除')
      end
      it '編集リンクが存在しているか' do
        expect(page).to have_link('編集')
      end
      it "投稿のタイトルが表示されているか" do
        expect(page).to have_content @counseling_post.title
      end
      it "相談の内容が表示されているか" do
        expect(page).to have_content @counseling_post.content
      end
      it "タグが表示されているか" do
        expect(@counseling_post.tag_ids.count).to eq(3)
      end
      it "スター評価が表示しているか" do
        expect(page).to have_content @counseling_post.star
      end
      it "使用頻度が表示しているか" do
        expect(page).to have_content @counseling_post.usage_frequency_i18n
      end
      it "ステータス(回答受付中・解決済)が存在しているか" do
        expect(page).to have_content @counseling_post.status_i18n
      end
    end
    context '投稿の削除のテスト' do
      it '投稿の削除' do
        expect{ click_link('削除') }.to change{ CounselingPost.count }.by(-1)
      end
    end
  end

  describe "編集画面のテスト" do
    before do
      @counseling_post = counseling_post
      visit edit_counseling_post_path(@counseling_post)
    end
    context '表示の確認' do
      it "投稿の画像フォームが表示されているか" do
        expect(page).to have_selector('input[type="file"][accept="image/*"]')
      end
      it 'タイトルの入力フォームが表示されているか' do
        expect(page).to have_field 'counseling_post[title]', with: @counseling_post.title
      end
      it '投稿の内容の入力フォームが表示されているか' do
        expect(page).to have_field 'counseling_post[content]', with: @counseling_post.content
      end
      it "お気に入り度の入力フォームが存在しているか" do
        expect(page).to have_selector('input#review_star', visible: false)
      end
      it "タグの選択フォームが表示されているか" do
        expect(page).to have_selector('input[type="checkbox"][name="counseling_post[tag_ids][]"]', count: Tag.count)
      end
      it '使用頻度の入力フォームが表示されているか' do
        expect(page).to have_field 'counseling_post[usage_frequency]', with: @counseling_post.usage_frequency
      end
    end
    it '保存ボタンが表示される' do
      expect(page).to have_button('投稿')
    end
    context '更新処理に関するテスト' do
      it '投稿が更新されてリダイレクトされること' do
        attach_file 'counseling_post[image]', Rails.root.join('spec', 'fixtures', 'test_image.jpg')
        fill_in 'counseling_post[title]', with: Faker::Lorem.characters(number:10)
        fill_in 'counseling_post[content]', with: Faker::Lorem.characters(number:30)
        select '毎日', from: 'counseling_post_usage_frequency'
        find('input#review_star', visible: false).set(4)
        check "counseling_post_tag_ids_1"
        click_button '投稿'
        expect(page).to have_current_path counseling_post_path(@counseling_post)
      end
    end
  end
end