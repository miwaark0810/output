require 'rails_helper'

RSpec.describe '新規投稿', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @post_subject = Faker::Lorem.word
    @post_title = Faker::Lorem.word
    @post_text = Faker::Lorem.sentence
  end
  context '新規投稿ができるとき'do
    it 'ログインしたユーザーは新規投稿できる' do
      # ログインする
      visit new_user_session_path
      fill_in 'メールアドレス', with: @user.email
      fill_in 'パスワード（6文字以上）', with: @user.password
      find('input[name="commit"]').click
      expect(current_path).to eq root_path
      # 新規投稿ページへのリンクがあることを確認する
      expect(page).to have_content('アウトプット')
      # 投稿ページに移動する
      visit new_post_path
      # フォームに情報を入力する
      image_path = Rails.root.join('public/images/test_image.png')
      attach_file('post[image]', image_path, make_visible: true)
      fill_in '教科', with: @post_subject
      fill_in 'タイトル', with: @post_title
      fill_in 'テキスト', with: @post_text
      # 送信するとpostモデルのカウントが1上がることを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { Post.count }.by(1)
      # トップページに遷移する
      visit root_path
      # トップページには先ほど投稿した内容のツイートが存在することを確認する（画像）
      expect(page).to have_selector("img")
      # トップページには先ほど投稿した内容のツイートが存在することを確認する（テキスト）
      expect(page).to have_content(@post_title)
      expect(page).to have_content(@post_text)
    end
  end
  context '新規投稿ができないとき'do
    it 'ログインしていないと新規投稿ページに遷移できない' do
      # トップページに遷移する
      visit root_path
      # 新規投稿ページへ遷移しようとするとログインページへ遷移する
      visit new_post_path
      expect(current_path).to eq new_user_session_path
    end
  end
end