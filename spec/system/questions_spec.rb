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

RSpec.describe '質問編集', type: :system do
  before do
    @question1 = FactoryBot.create(:question)
    @question2 = FactoryBot.create(:question)
  end
  context '質問編集ができるとき' do
    it 'ログインしたユーザーは自分が質問した質問の編集ができる' do
      # 質問1を質問したユーザーでログインする
      visit new_user_session_path
      fill_in 'メールアドレス', with: @question1.user.email
      fill_in 'パスワード（6文字以上）', with: @question1.user.password
      find('input[name="commit"]').click
      expect(current_path).to eq root_path
      # 質問一覧ページに移動する
      visit questions_path
      # 質問1の詳細ページに移動する
      visit question_path(@question1.id)
      # 質問1に「編集」ボタンがあることを確認する
      expect(page).to have_link '編集', href: edit_question_path(@question1)
      # 編集ページへ遷移する
      visit edit_question_path(@question1)
      # すでに質問済みの内容がフォームに入っていることを確認する
      expect(
        find('#question_subject').value
      ).to eq @question1.subject
      expect(
        find('#question_title').value
      ).to eq @question1.title
      expect(
        find('#question_text').value
      ).to eq @question1.text
      # 質問内容を編集する
      fill_in '教科', with: "#{@question1.subject}+編集した教科"
      fill_in 'タイトル', with: "#{@question1.title}+編集したタイトル"
      fill_in 'テキスト', with: "#{@question1.text}+編集したテキスト"
      # 編集してもquestionモデルのカウントは変わらないことを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { Question.count }.by(0)
      # 詳細画面に遷移したことを確認する
      expect(current_path).to eq question_path(@question1.id)
      # 質問一覧ページに移動する
      visit questions_path
      # 質問一覧ページには先ほど変更した内容の質問が存在することを確認する
      expect(page).to have_content("#{@question1.title}+編集したタイトル")
      expect(page).to have_content("#{@question1.text}+編集したテキスト")
    end
  end
  context '質問編集ができないとき' do
    it 'ログインしたユーザーは自分以外が質問した質問の編集画面には遷移できない' do
      # 質問1を質問したユーザーでログインする
      visit new_user_session_path
      fill_in 'メールアドレス', with: @question1.user.email
      fill_in 'パスワード（6文字以上）', with: @question1.user.password
      find('input[name="commit"]').click
      expect(current_path).to eq root_path
      # 質問一覧ページに移動する
      visit questions_path
      # 質問2の詳細ページに移動する
      visit question_path(@question2.id)
      # 質問2に「編集」ボタンがないことを確認する
      expect(page).to have_no_link '編集', href: edit_question_path(@question2)
    end
    it 'ログインしていないと質問の編集画面には遷移できない' do
      # トップページにいる
      visit root_path
      # 質問一覧ページに移動する
      visit questions_path
      # 質問1に「編集」ボタンがないことを確認する
      visit question_path(@question1.id)
      expect(page).to have_no_link '編集', href: edit_question_path(@question1)
      # 質問2に「編集」ボタンがないことを確認する
      visit question_path(@question2.id)
      expect(page).to have_no_link '編集', href: edit_question_path(@question2)
    end
  end
end