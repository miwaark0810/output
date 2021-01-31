require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe '#create' do
    before do
      @comment = FactoryBot.build(:comment)
    end

    it 'テキストが存在すれば保存できること' do
      expect(@comment).to be_valid
    end

    it 'テキストが空では登録できないこと' do
      @comment.text = nil
      @comment.valid?
      expect(@comment.errors.full_messages).to include("Text can't be blank")
    end

    it 'userが紐付いていないと保存できないこと' do
      @comment.user = nil
      @comment.valid?
      expect(@comment.errors.full_messages).to include('User must exist')
    end

    it 'postが紐付いていないと保存できないこと' do
      @comment.post = nil
      @comment.valid?
      expect(@comment.errors.full_messages).to include('Post must exist')
    end
  end
end
