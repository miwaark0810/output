require 'rails_helper'
describe QuestionsController, type: :request do
  before do
    @question = FactoryBot.create(:question)
  end

  describe 'GET #index' do
    it 'indexアクションにリクエストすると正常にレスポンスが返ってくる' do
      get questions_path
      expect(response.status).to eq 200
    end
    it 'indexアクションにリクエストするとレスポンスに投稿済みのテキストが存在する' do
      get questions_path
      expect(response.body).to include @question.text
    end
  end

  describe 'GET #show' do
    it 'showアクションにリクエストすると正常にレスポンスが返ってくる' do
      get question_path(@question)
      expect(response.status).to eq 200
    end
    it 'showアクションにリクエストするとレスポンスに投稿済みのテキストが存在する' do
      get question_path(@question)
      expect(response.body).to include @question.text
    end
  end
end
