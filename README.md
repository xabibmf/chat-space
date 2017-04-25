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
+ has_many :groups, through: members
+ has_many :messages
+ has_many :members

## groups table
|Column|Type|Options|
|:--|:-:|:--|
|name|string|null: false, unique: true|

### Association
+ has_many :users, through: members
+ has_many :messages
+ has_many :members

## members table
|Column|Type|Options|
|:--|:-:|:--|
|group_name|string|null: false|
|user_name|string|null: false|

### Association
+ belongs_to :user
+ belongs_to :group

## messages table
|Column|Type|Options|
|:--|:-:|:--|
|body|text||
|image|string||
|group_name|string|null: false|
|user_name|string|null: false|

### Association
+ belongs_to :user
+ belongs_to :group
