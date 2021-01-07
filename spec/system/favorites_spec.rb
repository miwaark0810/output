require 'rails_helper'

RSpec.describe "いいね機能", type: :system do
  before do
    @user = FactoryBot.create(:user)
    @post = FactoryBot.create(:post)
  end
  context 'いいねができるとき'do
    it 'ログインしたユーザーは投稿にいいねをすることができる' do
      # ログインする
      visit new_user_session_path
      fill_in 'メールアドレス', with: @user.email
      fill_in 'パスワード（6文字以上）', with: @user.password
      find('input[name="commit"]').click
      expect(current_path).to eq root_path
      # トップページにはいいねするための表示が存在することを確認する
      expect(page).to have_selector(".far")
      # いいねをクリックすると、Favoriteモデルのカウントが1上がることを確認する
      expect{
        find('i').click
      }.to change { Favorite.count }.by(1)
      # トップページにリダイレクトされることを確認する
      expect(current_path).to eq root_path
      # いいねをクリックすると、Favoriteモデルのカウントが1下がることを確認する
      expect{
        find('i').click
      }.to change { Favorite.count }.by(-1)
      # トップページにリダイレクトされることを確認する
      expect(current_path).to eq root_path
    end
  end
  context 'いいねができないとき'do
    it 'ログインしていないと投稿にいいねをすることができない' do
      # トップページに遷移する
      visit root_path
      # トップページにはいいねするための表示が存在しないことを確認する
      expect(page).to have_no_selector(".far")
    end
  end
end
