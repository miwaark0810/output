require 'rails_helper'

RSpec.describe "Questions", type: :system do
  before do
    @user = FactoryBot.create(:user)
    @question_subject = Faker::Lorem.word
    @question_title = Faker::Lorem.word
    @question_text = Faker::Lorem.sentence
  end
  context '新規質問ができるとき'do
    it 'ログインしたユーザーは新規質問できる' do
      # ログインする
      visit new_user_session_path
      fill_in 'メールアドレス', with: @user.email
      fill_in 'パスワード（6文字以上）', with: @user.password
      find('input[name="commit"]').click
      expect(current_path).to eq root_path
      # 質問一覧ページへのリンクがあることを確認する
      expect(page).to have_content('質問一覧へ')
      # 質問一覧ページに移動する
      visit questions_path
      # 新規質問ページに移動する
      visit new_question_path
      # フォームに情報を入力する
      fill_in '教科', with: @question_subject
      fill_in 'タイトル', with: @question_title
      fill_in 'テキスト', with: @question_text
      # 送信するとquestionモデルのカウントが1上がることを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { Question.count }.by(1)
      # 質問一覧ページに移動する
      visit questions_path
      # トップページには先ほど質問した内容の質問が存在することを確認する（テキスト）
      expect(page).to have_content(@question_title)
      expect(page).to have_content(@question_text)
    end
  end
  context '新規質問ができないとき'do
    it 'ログインしていないと新規質問ページに遷移できない' do
      # 質問一覧ページに移動する
      visit questions_path
      # 新規質問ページへ遷移しようとするとログインページへ遷移する
      visit new_question_path
      expect(current_path).to eq new_user_session_path
    end
  end
end