require 'rails_helper'

RSpec.describe '解決済み表示機能', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @question1 = FactoryBot.create(:question)
    @question2 = FactoryBot.create(:question)
  end
  context '解決済み表示ができるとき' do
    it 'ログインしたユーザーは自らの質問を解決済みにすることができる' do
      # 質問したユーザーでログインする
      sign_in(@question1.user)
      # 質問一覧ページに移動する
      visit questions_path
      # 質問の詳細ページに移動する
      visit question_path(@question1.id)
      # 質問に「解決済みにする」ボタンがあることを確認する
      expect(page).to have_link '解決済みにする', href: question_solutions_path(@question1)
      # 解決済みにするをクリックすると、Solutionモデルのカウントが1上がることを確認する
      expect do
        find_link('解決済みにする', href: question_solutions_path(@question1)).click
      end.to change { Solution.count }.by(1)
      # 詳細ページにリダイレクトされることを確認する
      expect(current_path).to eq question_path(@question1.id)
      # 質問に「回答募集中にする」ボタンがあることを確認する
      expect(page).to have_link '回答募集中にする', href: question_solutions_path(@question1)
      # 回答募集中にするをクリックすると、Solutionモデルのカウントが1上がることを確認する
      expect do
        find_link('回答募集中にする', href: question_solutions_path(@question1)).click
      end.to change { Solution.count }.by(-1)
      # 詳細ページにリダイレクトされることを確認する
      expect(current_path).to eq question_path(@question1.id)
    end
  end
  context '解決済み表示ができないとき' do
    it 'ログインしたユーザーは自分以外が質問した質問を解決済みにできない' do
      # 質問1を質問したユーザーでログインする
      sign_in(@question1.user)
      # 質問一覧ページに移動する
      visit questions_path
      # 質問2の詳細ページに移動する
      visit question_path(@question2.id)
      # 質問2に「解決済みにする」ボタンがないことを確認する
      expect(page).to have_no_link '解決済みにする', href: question_solutions_path(@question2)
    end
    it 'ログインしていないと質問を解決済みにできない' do
      # トップページにいる
      visit root_path
      # 質問一覧ページに移動する
      visit questions_path
      # 質問1に「解決済みにする」ボタンがないことを確認する
      visit question_path(@question1.id)
      expect(page).to have_no_link '解決済みにする', href: question_solutions_path(@question1)
      # 質問2に「解決済みにする」ボタンがないことを確認する
      visit question_path(@question2.id)
      expect(page).to have_no_link '解決済みにする', href: question_solutions_path(@question2)
    end
  end
end
