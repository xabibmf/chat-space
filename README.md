# DB設計

## users table
+ usersテーブルはdeviseを利用する。

|Column|Type|Options|
|:--|:-:|:--|
|id|integer|index: true, null: false, unique: true|
|name|string|index: true, null: false, unique: true|
|email|string|null: false|
|password|string|null: false|

### Association
+ has_many :groups, through: user_group
+ has_many :messages
+ has_many :user_group

## groups table
|Column|Type|Options|
|:--|:-:|:--|
|id|integer|null: false, unique: true|
|name|string|null: false, unique: true|

### Association
+ has_many :users, through: user_group
+ has_many :messages
+ has_many :user_group

## user_group table
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
