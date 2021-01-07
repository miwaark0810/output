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

    it 'textが空では登録できないこと' do
      @post.text = nil
      @post.valid?
      expect(@post.errors.full_messages).to include("Text can't be blank")
    end

    it 'userが紐付いていないと保存できないこと' do
      @post.user = nil
      @post.valid?
      expect(@post.errors.full_messages).to include('User must exist')
    end
  end
end
