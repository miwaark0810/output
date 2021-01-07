require 'rails_helper'

RSpec.describe '新規投稿', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @post_subject = Faker::Lorem.word
    @post_title = Faker::Lorem.word
    @post_text = Faker::Lorem.sentence
  end
  context '新規投稿ができるとき' do
    it 'ログインしたユーザーは新規投稿できる' do
      # ログインする
      sign_in(@user)
      # 新規投稿ページへのリンクがあることを確認する
      expect(page).to have_content('アウトプット')
      # 投稿ページに移動する
      visit new_post_path
      # フォームに情報を入力する
      image_path = Rails.root.join('public/images/test_image.png')
      attach_file('post[image]', image_path, make_visible: true)
      fill_in '教科', with: @post_subject
      fill_in 'タイトル', with: @post_title
      fill_in 'テキスト', with: @post_text
      # 送信するとpostモデルのカウントが1上がることを確認する
      expect  do
        find('input[name="commit"]').click
      end.to change { Post.count }.by(1)
      # トップページに遷移する
      visit root_path
      # トップページには先ほど投稿した内容の投稿が存在することを確認する（画像）
      expect(page).to have_selector('img')
      # トップページには先ほど投稿した内容の投稿が存在することを確認する（テキスト）
      expect(page).to have_content(@post_title)
      expect(page).to have_content(@post_text)
    end
  end
  context '新規投稿ができないとき' do
    it 'ログインしていないと新規投稿ページに遷移できない' do
      # トップページに遷移する
      visit root_path
      # 新規投稿ページへ遷移しようとするとログインページへ遷移する
      visit new_post_path
      expect(current_path).to eq new_user_session_path
    end
  end
end

RSpec.describe '投稿編集', type: :system do
  before do
    @post1 = FactoryBot.create(:post)
    @post2 = FactoryBot.create(:post)
  end
  context '投稿編集ができるとき' do
    it 'ログインしたユーザーは自分が投稿した投稿の編集ができる' do
      # 投稿1を投稿したユーザーでログインする
      sign_in(@post1.user)
      # 投稿1の詳細ページに移動する
      visit post_path(@post1.id)
      # 投稿1に「編集」ボタンがあることを確認する
      expect(page).to have_link '編集', href: edit_post_path(@post1)
      # 編集ページへ遷移する
      visit edit_post_path(@post1)
      # すでに投稿済みの内容がフォームに入っていることを確認する
      expect(
        find('#post_subject').value
      ).to eq @post1.subject
      expect(
        find('#post_title').value
      ).to eq @post1.title
      expect(
        find('#post_text').value
      ).to eq @post1.text
      # 投稿内容を編集する
      fill_in '教科', with: "#{@post1.subject}+編集した教科"
      fill_in 'タイトル', with: "#{@post1.title}+編集したタイトル"
      fill_in 'テキスト', with: "#{@post1.text}+編集したテキスト"
      # 編集してもpostモデルのカウントは変わらないことを確認する
      expect  do
        find('input[name="commit"]').click
      end.to change { Post.count }.by(0)
      # 詳細画面に遷移したことを確認する
      expect(current_path).to eq post_path(@post1.id)
      # トップページに遷移する
      visit root_path
      # トップページには先ほど変更した内容の投稿が存在することを確認する
      expect(page).to have_content("#{@post1.title}+編集したタイトル")
      expect(page).to have_content("#{@post1.text}+編集したテキスト")
    end
  end
  context '投稿編集ができないとき' do
    it 'ログインしたユーザーは自分以外が投稿した投稿の編集画面には遷移できない' do
      # 投稿1を投稿したユーザーでログインする
      sign_in(@post1.user)
      # 投稿2の詳細ページに移動する
      visit post_path(@post2.id)
      # 投稿2に「編集」ボタンがないことを確認する
      expect(page).to have_no_link '編集', href: edit_post_path(@post2)
    end
    it 'ログインしていないと投稿の編集画面には遷移できない' do
      # トップページにいる
      visit root_path
      # 投稿1に「編集」ボタンがないことを確認する
      visit post_path(@post1.id)
      expect(page).to have_no_link '編集', href: edit_post_path(@post1)
      # 投稿2に「編集」ボタンがないことを確認する
      visit post_path(@post2.id)
      expect(page).to have_no_link '編集', href: edit_post_path(@post2)
    end
  end
end

RSpec.describe '投稿削除', type: :system do
  before do
    @post1 = FactoryBot.create(:post)
    @post2 = FactoryBot.create(:post)
  end
  context '投稿削除ができるとき' do
    it 'ログインしたユーザーは自らの投稿を削除ができる' do
      # 投稿1を投稿したユーザーでログインする
      sign_in(@post1.user)
      # 投稿1の詳細ページに移動する
      visit post_path(@post1.id)
      # 投稿1に「削除」ボタンがあることを確認する
      expect(page).to have_link '削除', href: post_path(@post1)
      # 投稿を削除するとレコードの数が1減ることを確認する
      expect do
        find_link('削除', href: post_path(@post1)).click
      end.to change { Post.count }.by(-1)
      # トップページに遷移することを確認する
      expect(current_path).to eq root_path
      # トップページには投稿1の内容が存在しないことを確認する
      expect(page).to have_no_content(@post1.title.to_s)
      expect(page).to have_no_content(@post1.text.to_s)
    end
  end
  context '投稿削除ができないとき' do
    it 'ログインしたユーザーは自分以外が投稿した投稿の削除ができない' do
      # 投稿1を投稿したユーザーでログインする
      sign_in(@post1.user)
      # 投稿2の詳細ページに移動する
      visit post_path(@post2.id)
      # 投稿2に「削除」ボタンがないことを確認する
      expect(page).to have_no_link '削除', href: post_path(@post2)
    end
    it 'ログインしていないと投稿の削除ボタンがない' do
      # トップページにいる
      visit root_path
      # 投稿1に「編集」ボタンがないことを確認する
      visit post_path(@post1.id)
      expect(page).to have_no_link '削除', href: post_path(@post1)
      # 投稿2に「編集」ボタンがないことを確認する
      visit post_path(@post2.id)
      expect(page).to have_no_link '削除', href: post_path(@post2)
    end
  end
end

RSpec.describe '投稿詳細', type: :system do
  before do
    @post = FactoryBot.create(:post)
  end
  it 'ログインしたユーザーは投稿詳細ページに遷移してコメント投稿欄が表示される' do
    # ログインする
    sign_in(@post.user)
    # 詳細ページに遷移する
    visit post_path(@post)
    # 詳細ページに投稿の内容が含まれている
    expect(page).to have_content(@post.title.to_s)
    expect(page).to have_content(@post.text.to_s)
    # コメント用のフォームが存在する
    expect(page).to have_selector 'form'
  end
  it 'ログインしていない状態で投稿詳細ページに遷移できるもののコメント投稿欄が表示されない' do
    # 詳細ページに遷移する
    visit post_path(@post)
    # 詳細ページに投稿の内容が含まれている
    expect(page).to have_content(@post.title.to_s)
    expect(page).to have_content(@post.text.to_s)
    # フォームが存在しないことを確認する
    expect(page).to have_no_selector 'form'
  end
end
