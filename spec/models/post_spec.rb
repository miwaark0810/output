require 'rails_helper'

RSpec.describe Post, type: :model do
  describe '#create' do
    before do
      @post = FactoryBot.build(:post)
    end

    it 'すべての項目が存在すれば保存できること' do
      expect(@post).to be_valid
    end

    it 'imageが空では登録できないこと' do
      @post.image = nil
      @post.valid?
      expect(@post.errors.full_messages).to include("Image can't be blank")
    end

    it 'subjectが空では登録できないこと' do
      @post.subject = nil
      @post.valid?
      expect(@post.errors.full_messages).to include("Subject can't be blank")
    end

    it 'titleが空では登録できないこと' do
      @post.title = nil
      @post.valid?
      expect(@post.errors.full_messages).to include("Title can't be blank")
    end

    it 'titleが16文字以下であれば登録できること' do
      @post.title = 'abcdefghijklmnop'
      expect(@post).to be_valid
    end

    it 'titleが17文字以上であれば登録できないこと' do
      @post.title = 'abcdefghijklmnopq'
      @post.valid?
      expect(@post.errors.full_messages).to include('Title is too long (maximum is 16 characters)')
    end

    it 'textが空では登録できないこと' do
      @post.text = nil
      @post.valid?
      expect(@post.errors.full_messages).to include("Text can't be blank")
    end

    it 'textが60文字以下であれば登録できること' do
      @post.text = 'abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefgh'
      expect(@post).to be_valid
    end

    it 'textが61文字以上であれば登録できないこと' do
      @post.text = 'abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghi'
      @post.valid?
      expect(@post.errors.full_messages).to include('Text is too long (maximum is 60 characters)')
    end

    it 'userが紐付いていないと保存できないこと' do
      @post.user = nil
      @post.valid?
      expect(@post.errors.full_messages).to include('User must exist')
    end
  end
end
