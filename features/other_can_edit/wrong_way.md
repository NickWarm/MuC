我有一個需求

>傳統A發了一篇文章，只有A有權限編輯
>
>我現在想要A發一篇文章，BCD都可以編輯A的文章


# 正確方法

不用寫多對多的中介表

直接在post裡開一個is_editable的布林欄位就好了

# 以下為錯誤方法，但是學習與討論的值得保存下來

## create_authority migration

參考自[rails API - Active Record Migrations](http://api.rubyonrails.org/classes/ActiveRecord/Migration.html)

### 第二版


```
class CreateAuthorities < ActiveRecord::Migration
  def up
    create_table :authorities do |t|
      t.integer :user_id
      t.integer :post_id
  end

  def down
    drop_table :authorities
  end
end
```

### 第一版

```
class CreateAuthorities < ActiveRecord::Migration
  def up
    create_table :authorities do |t|
      t.boolean :is_editable, default: false
      t.integer :user_id
      t.integer :post_id
  end

  def down
    drop_table :authorities
  end
end
```

## model配置

post與user的關係，參考自[rails Guide - 2.4 has_many :through 關聯](http://rails.ruby.tw/association_basics.html#has-many-through-關聯)

[rails API - belongs_to ](http://api.rubyonrails.org/classes/ActiveRecord/Associations/ClassMethods.html#method-i-belongs_to)

```
class User < ActiveRecord::Base
  has_many :authorities
  has_many :posts, through: :authorities
  has_many :learning_notes, through: :authorities
  has_many :honors, through: :authorities
end

class Authority < ActiveRecord::Base
  belongs_to :user
  belongs_to :post
end

class Post < ActiveRecord::Base
  belongs_to :author, class_name: "User", foreign_key: :user_id
  has_many :authorities
  has_many :users, through: :authorities

  def editable_by?(user)
    user && user == author
  end


end
```

## 該篇post的view裡的edit button

參考
- sdlong的這篇：[4. 建立使用者功能 « Rails 101 S](http://rails101s.logdown.com/posts/247881-20-4-adding-user-functions)
- mackenziechild 12 week blog 範例：[blog/app/views/posts/show.html.erb
](https://github.com/mackenziechild/blog/blob/master/app/views/posts/show.html.erb)

```
<!-- 作者自己可以編輯 -->
<% if post.editable_by(current_user) %>
  <%= link_to "edit" %>
  <%= link_to "delete" %>
<% end %>


<!-- 開放給他人編輯 -->
<% if user_signed_in? && post.is_editable %>
  <%= link_to "edit" %>
<% end %>


if @post.is_editable_by?(current_user)
```

## Lui 建議

研究many to many

中介表的欄位是 `user_id post_id is_editable is_readable`


這樣要再弄個關聯表

在弄個關聯表

一般是has_many post

但中間就在多個 中介表

這中介表的欄位是 user_id post_id is_editable is_readable

但是你的中介表

可以叫做authoiry

authority

中介表可以亂取

反正我幫你想好了

你的中介表就叫做authority這個了

然後多兩個column

一個是is_readable 一個是is_editable

這樣

然後給預設都是false

然後admin可以決定哪個使用者可以對哪篇文章做閱讀或修改

就這樣囉～

或是一個editable也可以啦

看你要做多複雜而已

但概念就是這樣囉

## ref

- [#82- Many to Many Association User and Stock in ruby on rails - YouTube](https://www.youtube.com/watch?v=e0JUKvYk1Lo)
- [rails Guide - 2.4 has_many :through 關聯](http://rails.ruby.tw/association_basics.html#has-many-through-關聯)
- [rails Guide - 2.8 has_many :through 與 has_and_belongs_to_many 的應用場景](http://rails.ruby.tw/association_basics.html#has-many-through-與-has-and-belongs-to-many-的應用場景)

搜尋「多對多關聯」
- [Active Record Association « Rails 101 S](http://rails101s.logdown.com/posts/211428-active-record-association)
  - [rails101s/app/models/group.rb](https://github.com/sdlong/rails101s/blob/master/app/models/group.rb)
  - [rails101s/app/models/group_user.rb](https://github.com/sdlong/rails101s/blob/master/app/models/group_user.rb)
  - [rails101s/app/models/user.rb](https://github.com/sdlong/rails101s/blob/master/app/models/user.rb)
  - [rails101s/db/schema.rb](https://github.com/sdlong/rails101s/blob/master/db/schema.rb)
- [Ruby on Rails 實戰聖經 | ActiveRecord - 基本操作與關聯設計](https://ihower.tw/rails/activerecord.html)
- [RailsFun.tw 新手教學 day2 HD 多對多問題 - 求救 - Rails Fun!! Ruby & Rails 中文論壇](http://railsfun.tw/t/railsfun-tw-day2-hd/754)
