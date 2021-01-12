require 'rails_helper'

RSpec.describe Question, type: :model do
  describe '#create' do
    before do
      @question = FactoryBot.build(:question)
    end

    it 'すべての項目が存在すれば保存できること' do
      expect(@question).to be_valid
    end

    it 'subjectが空では登録できないこと' do
      @question.subject = nil
      @question.valid?
      expect(@question.errors.full_messages).to include("Subject can't be blank")
    end

    it 'titleが空では登録できないこと' do
      @question.title = nil
      @question.valid?
      expect(@question.errors.full_messages).to include("Title can't be blank")
    end

    it 'titleが16文字以下であれば登録できること' do
      @question.title = 'abcdefghijklmnop'
      expect(@question).to be_valid
    end
    
    it 'titleが17文字以上であれば登録できないこと' do
      @question.title = 'abcdefghijklmnopq'
      @question.valid?
      expect(@question.errors.full_messages).to include('Title is too long (maximum is 16 characters)')
    end

    it 'textが空では登録できないこと' do
      @question.text = nil
      @question.valid?
      expect(@question.errors.full_messages).to include("Text can't be blank")
    end

    it 'textが200文字以下であれば登録できること' do
      @question.text = 'abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqr'
      expect(@question).to be_valid
    end
    
    it 'textが201文字以上であれば登録できないこと' do
      @question.text = 'abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrs'
      @question.valid?
      expect(@question.errors.full_messages).to include('Text is too long (maximum is 200 characters)')
    end
    it 'userが紐付いていないと保存できないこと' do
      @question.user = nil
      @question.valid?
      expect(@question.errors.full_messages).to include('User must exist')
    end
  end
end
