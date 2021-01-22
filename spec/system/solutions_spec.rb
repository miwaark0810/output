require 'rails_helper'

RSpec.describe '解決済み表示機能', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @question = FactoryBot.create(:question)
  end
  context '解決済み表示ができるとき' do
    it 'ログインしたユーザーは自らの質問を解決済みにすることができる' do
      # 質問したユーザーでログインする
      sign_in(@question.user)
      # 質問一覧ページに移動する
      visit questions_path
      # 質問の詳細ページに移動する
      visit question_path(@question.id)
      # 質問に「解決済みにする」ボタンがあることを確認する
      expect(page).to have_link '解決済みにする', href: question_solutions_path(@question)
      # 解決済みにするをクリックすると、Solutionモデルのカウントが1上がることを確認する
      expect do
        find_link('解決済みにする', href: question_solutions_path(@question)).click
      end.to change { Solution.count }.by(1)
      # 詳細ページにリダイレクトされることを確認する
      expect(current_path).to eq question_path(@question.id)
      # 質問に「回答募集中にする」ボタンがあることを確認する
      expect(page).to have_link '回答募集中にする', href: question_solutions_path(@question)
      # 回答募集中にするをクリックすると、Solutionモデルのカウントが1上がることを確認する
      expect do
        find_link('回答募集中にする', href: question_solutions_path(@question)).click
      end.to change { Solution.count }.by(-1)
      # 詳細ページにリダイレクトされることを確認する
      expect(current_path).to eq question_path(@question.id)
    end
  end
end
