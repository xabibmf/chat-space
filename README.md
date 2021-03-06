# DB設計

## users table
+ usersテーブルはdeviseを利用する。

|Column|Type|Options|
|:--|:-:|:--|
|name|string|index: true, null: false|

### Association
+ has_many :groups, through: group_users
+ has_many :messages
+ has_many :group_users

## groups table
|Column|Type|Options|
|:--|:-:|:--|
|name|string|null: false, unique: true|

### Association
+ has_many :users, through: group_users
+ has_many :messages
+ has_many :group_users

## group_users table
|Column|Type|Options|
|:--|:-:|:--|
|group_id|integer|null: false, foreign_key: true|
|user_id|integer|null: false, foreign_key: true|

### Association
+ belongs_to :user
+ belongs_to :group

## messages table
|Column|Type|Options|
|:--|:-:|:--|
|body|text||
|image|string||
|group_id|integer|null: false, foreign_key: true|
|user_id|integer|null: false, foreign_key: true|

### Association
+ belongs_to :user
+ belongs_to :group
