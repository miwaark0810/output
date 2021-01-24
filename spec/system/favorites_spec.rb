require 'rails_helper'

RSpec.describe 'いいね機能', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @post = FactoryBot.create(:post)
  end
  context 'いいねができるとき' do
    it 'ログインしたユーザーは投稿にいいねをすることができる' do
      # ログインする
      sign_in(@user)
      # トップページにはいいねするための表示が存在することを確認する
      expect(page).to have_selector('.far')
      # いいねをクリックすると、Favoriteモデルのカウントが1上がることを確認する
      expect do
        find('i').click
        wait_for_ajax do
        end.to change { Favorite.count }.by(1)
      end
      # いいねをクリックすると、Favoriteモデルのカウントが1下がることを確認する
      expect do
        find('i').click
        wait_for_ajax do
        end.to change { Favorite.count }.by(-1)
      end
    end
  end
  context 'いいねができないとき' do
    it 'ログインしていないと投稿にいいねをすることができない' do
      # トップページに遷移する
      visit root_path
      # トップページにはいいねするための表示が存在しないことを確認する
      expect(page).to have_no_selector('.far')
    end
  end
end
