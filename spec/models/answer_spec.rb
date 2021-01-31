require 'rails_helper'

RSpec.describe Answer, type: :model do
  describe '#create' do
    before do
      @answer = FactoryBot.build(:answer)
    end

    it 'テキストが存在すれば保存できること' do
      expect(@answer).to be_valid
    end

    it 'テキストが空では登録できないこと' do
      @answer.text = nil
      @answer.valid?
      expect(@answer.errors.full_messages).to include("Text can't be blank")
    end

    it 'userが紐付いていないと保存できないこと' do
      @answer.user = nil
      @answer.valid?
      expect(@answer.errors.full_messages).to include('User must exist')
    end

    it 'questionが紐付いていないと保存できないこと' do
      @answer.question = nil
      @answer.valid?
      expect(@answer.errors.full_messages).to include('Question must exist')
    end
  end
end
