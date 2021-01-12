require 'rails_helper'
describe PostsController, type: :request do

  before do
    @post = FactoryBot.create(:post)
  end

  describe "GET #index" do
    it "indexアクションにリクエストすると正常にレスポンスが返ってくる" do 
      get root_path
      expect(response.status).to eq 200
    end
    it "indexアクションにリクエストするとレスポンスに投稿済みのテキストが存在する" do 
      get root_path
      expect(response.body).to include @post.text
    end
    it "indexアクションにリクエストするとレスポンスに投稿検索フォームが存在する" do 
      get root_path
      expect(response.body).to include "投稿を検索する"
    end
  end

  describe "GET #show" do
    it "showアクションにリクエストすると正常にレスポンスが返ってくる" do 
      get post_path(@post)
      expect(response.status).to eq 200
    end
    it "showアクションにリクエストするとレスポンスに投稿済みのテキストが存在する" do 
      get post_path(@post)
      expect(response.body).to include @post.text
    end
  end 
end