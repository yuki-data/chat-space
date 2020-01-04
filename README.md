# グループチャットアプリchatspace
chatspaceとは
- chatspaceはグループチャットアプリです。
- 画像とテキストの投稿ができます。
- グループに登録したメンバーのみがチャットを閲覧できます。

![ChatSpace](https://gyazo.com/725d93c9a09f600d3b73124824b88470.png)

## 使い方
初めにユーザー登録をしてください。
![ChatSpace - Gyazo](https://gyazo.com/f539e78bed2a165f5136f8b5d09d7e26.png)

次に、チャットグループを作成してください。
![キャプチャ動画](https://gyazo.com/13d7536c2c4f033ee000178eb0546de9.gif)

既存のメンバーの名前がわかれば、そのメンバーを検索できます。
グループにメンバーを追加すると、そのメンバーと自分だけがチャットを閲覧できます。
![キャプチャ動画](https://gyazo.com/1d8516a99f4472ba895be17b7959482a.gif)

画像またはテキストを投稿できます。
![キャプチャ動画](https://gyazo.com/a5642f9659736c81588b072d9b9372a9.gif)

グループメンバーのチャットは自動的に同期されます。
![キャプチャ動画](https://gyazo.com/68d10bbaece880b07dd3e5e8fe990ecb.gif)

## 使用した技術、言語、ツールなど
- 言語
    - サーバーサイド: Ruby
    - フロント: SASS, HTML (HAML), JavaScript (jQuery)
- アプリケーションフレームワーク: Ruby on rails
- インフラ: AWS(EC2, S3)
- ソースコード管理: Github
- 自動デプロイツール: capistrano
- webサーバー: nginx
- アプリケーションサーバー: unicorn
- データベース: MySQL

## 実装内容
- HAMLとSASSでのフロント実装
- jQueryによるメッセージの非同期通信
- jQueryによるインクリメンタルサーチ機能
- devise (認証用gem)によるユーザー登録・ログイン機能
- carrierwaveによる画像のアップロード
- fogによるAWS S3への画像のアップロード
- capistranoによる自動デプロイ

## chatspaceのデータベース設計
### messagesテーブル
|Column|Type|Options|
|------|----|-------|
|body|text||
|images|text||
|user_id|integer|null: false, foreign_key: true|
|group_id|integer|null: false, foreign_key: true|

#### Association
- belongs_to :group
- belongs_to :user

### usersテーブル
|Column|Type|Options|
|------|----|-------|
|email|string|null: false|
|password|string|null: false|
|name|string|null: false|

#### Association
- has_many :messages
- has_many :groups_users
- has_many :groups, through: :groups_users

### groupsテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|

#### Association
- has_many :messages
- has_many :groups_users
- has_many :users, through: :groups_users

### groups_usersテーブル
|Column|Type|Options|
|------|----|-------|
|user_id|integer|null: false, foreign_key: true|
|group_id|integer|null: false, foreign_key: true|

#### Association
- belongs_to :group
- belongs_to :user
