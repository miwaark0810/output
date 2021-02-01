require 'rails_helper'

RSpec.describe '回答', type: :system do
  before do
    @question = FactoryBot.create(:question)
    @answer = Faker::Lorem.sentence
  end
  it 'ログインしたユーザーは質問詳細ページで回答投稿できる' do
    # ログインする
    sign_in(@question.user)
    # 質問一覧ページに移動する
    visit questions_path
    # 質問詳細ページに遷移する
    visit question_path(@question)
    # フォームに情報を入力する
    fill_in 'answer_text', with: @answer
    # 回答を送信すると、answerモデルのカウントが1上がることを確認する
    expect  do
      find('input[name="commit"]').click
    end.to change { Answer.count }.by(1)
    # 詳細ページにリダイレクトされることを確認する
    expect(current_path).to eq question_path(@question)
    # 詳細ページ上に先ほどの回答内容が含まれていることを確認する
    expect(page).to have_content @answer
  end
  it 'ログインしていないと質問詳細ページで回答することができない' do
    # 質問一覧ページに移動する
    visit questions_path
    # 質問詳細ページに遷移する
    visit question_path(@question)
    # 回答するための表示が存在しないことを確認する
    expect(page).to have_no_selector 'form'
  end
end
