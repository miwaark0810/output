
# Output

 「Output」は学生向けアウトプット学習用の投稿アプリケーションです。

# URL

## 接続先
http://54.95.239.166/

## ID/Pass
ID:admin  
Pass:2222

## テスト用アカウント
ユーザー1  
・メールアドレス：user_one@sample  
・パスワード：user0705  
ユーザー2  
・メールアドレス：user_two@sample  
・パスワード：user0826  

# 概要

## ・自分が学習した内容を画像つきで投稿することができます。
![Outputトップページ](https://user-images.githubusercontent.com/73152294/104276485-47485280-54e8-11eb-9ae5-afacad18fb21.jpg)

## ・学習していてわからない内容を質問することができます。
<img width="1679" alt="Output質問ページ" src="https://user-images.githubusercontent.com/73152294/104278118-6ac0cc80-54eb-11eb-9b30-a07a306b8631.png">

# 想い

学校教育ではなかなか実現が難しい効率的な学習方法を身に着けてほしい。効率的な学習方法とは人に教えることなどを中心としたアウトプット学習です。自分自身は学生時代から無意識にアウトプットを行ってきました。具体的には、部屋で一人で学習した内容を独り言のように話していました。また、友達とはお互いに作った語呂合わせを遊び半分で伝えあっていました。そういった経験から今の学生たちにもアウトプット中心の学習で効率よく勉強をしてほしいと考え、アウトプット学習に絞ったアプリケーションを開発しました。

# 利用方法

## 新規登録  
①トップページの「新規登録」をクリック  
②すべての項目を入力  
③「新規登録」をクリック

## ログイン
①トップページの「ログイン」をクリック  
②登録したメールアドレス及びパスワードを入力  
③「ログイン」をクリック

## ログアウト
①画面上部の「ログアウト」をクリック

## 新規投稿（ログインが必要）
①トップページの「アウトプット」をクリック  
②すべての項目を入力   
③「保存する」をクリック

## 投稿の編集及び削除（ログインが必要）
①トップページに表示されている投稿のタイトル（太字の箇所）をクリック  
②投稿画像上部の「編集する」または「削除する」をクリック

## コメント（ログインが必要）
①トップページに表示されている投稿のタイトル（太字の箇所）をクリック  
②ページ下部にコメントを入力  
③「送信する」をクリック

## 質問（ログインが必要）
①トップページの「質問一覧へ」をクリック  
②ページ右下の「質問する」をクリック  
③すべての項目を入力   
④「保存する」をクリック

## 回答（ログインが必要）
①トップページの「質問一覧へ」をクリック  
②ページに表示されている質問のタイトル（太字の箇所）をクリック  
③ページ下部に回答を入力  
④「送信する」をクリック

## いいね（ログインが必要）
①投稿の下にあるハートマークをクリック  
②もう一度クリックすると削除

## 検索
①トップページの検索欄にキーワードを入力  
②「検索」をクリック

## マイページへの移動
①「ようこそ、〇〇さん」をクリック

## ユーザーページへの移動
①投稿や質問の下にある「by 〇〇」をクリック

# 使用技術
・ Ruby 2.6.5  
・ Ruby on Rails 6.0.3.4  
・ Nginx  
・ Unicorn  
・ AWS  
&emsp;-&nbsp;EC2  
&emsp;-&nbsp;S3  
・ Capistrano3  
・ RSpec

# テーブル設計

## users テーブル

| Column   | Type    | Options     |
| -------- | ------  | ----------- |
| email    | string  | null: false |
| password | string  | null: false |
| nickname | string  | null: false |
| grade_id | integer | null: false |

### Association

- has_many :posts
- has_many :comments
- has_many :favorites
- has_many :questions
- has_many :answers

## posts テーブル

| Column  | Type       | Options                        |
| ------- | ---------- | ------------------------------ |
| subject | string     | null: false                    |
| title   | string     | null: false                    |
| text    | text       | null: false                    |
| user    | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- has_many :comments
- has_many :favorites

## comments テーブル

| Column | Type       | Options                        |
| ------ | ---------- | ------------------------------ |
| text   | text       | null: false                    |
| user   | references | null: false, foreign_key: true |
| post   | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :post

## favorites テーブル

| Column | Type       | Options                        |
| ------ | ---------- | ------------------------------ |
| user   | references | null: false, foreign_key: true |
| post   | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :post

## questions テーブル

| Column  | Type       | Options                        |
| ------- | ---------- | ------------------------------ |
| subject | string     | null: false                    |
| title   | string     | null: false                    |
| text    | text       | null: false                    |
| user    | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- has_many :answers

## answers テーブル

| Column | Type       | Options                        |
| ------ | ---------- | ------------------------------ |
| text   | text       | null: false                    |
| user   | references | null: false, foreign_key: true |
| post   | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :question

# 今後の実装予定
- 検索機能の充実  
&nbsp;いいねが多い投稿の検索&nbsp;など  
- 質問ページの機能追加  
&nbsp;解決済みかどうかの表示&nbsp;など  
