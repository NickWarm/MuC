我有一個需求

>傳統A發了一篇文章，只有A有權限編輯
>
>我現在想要A發一篇文章，BCD都可以編輯A的文章

**不用** 寫多對多的 **中介表**

直接在post model裡開一個 **is_editable** 的布林欄位就好了

要開權限給任何人編輯
- 學習資源
- 實驗室公告


開權限給特定人編輯
- 榮譽榜
- 教授的著作


# model比較對照表
- 學習資源：`learning_notes`
  - `title:string content:text is_editable:boolean link:string user_id:string`
  - 「獨自編輯」與「對所有實驗室成員開放」
- 榮譽榜：`honors`
  - `title:string content:text user_id:integer`
  - 會關聯：(特定)實驗室成員 -> 多對多用中介表
- 實驗室公告：`posts`
  - `title:string content:text user_id:integer`
  - 「獨自編輯」與「對所有實驗室成員開放」
- 實驗室成員：`users`
  - 會關聯：學習資源、榮譽榜、實驗室公告、學生的論文
- 學生的論文：`papers`
- 教授的著作：`professor_works`
  - 會關聯：(特定)實驗室成員 -> 多對多用中介表


用sdlong的寫法就不需要開author欄位了
- [4. 建立使用者功能 « Rails 101 S](http://rails101s.logdown.com/posts/247881-20-4-adding-user-functions)，搜尋「author」
- [rails101s GitHub - rails101s/db/schema.rb](https://github.com/sdlong/rails101s/blob/master/db/schema.rb)




# schema設計

所有可能用到`WHERE`的都要加到add_index裡去
- [jccart - Step.3 註冊系統與產品圖片](https://github.com/NickWarm/jccart/wiki/Step.3-%E8%A8%BB%E5%86%8A%E7%B3%BB%E7%B5%B1%E8%88%87%E7%94%A2%E5%93%81%E5%9C%96%E7%89%87)
- [rails API - add_index](http://api.rubyonrails.org/classes/ActiveRecord/ConnectionAdapters/SchemaStatements.html#method-i-add_index)
- 以後可能會寫 **搜尋文章** 的功能，所以還是有必要用add_index

add_column
- [rails101s GitHub - rails101s/db/migrate/20141221191313_add_user_id_to_post.rb](https://github.com/sdlong/rails101s/blob/master/db/migrate/20141221191313_add_user_id_to_post.rb)
- [rails API - add_column](http://api.rubyonrails.org/classes/ActiveRecord/ConnectionAdapters/SchemaStatements.html#method-i-add_column)
- [Ruby on Rails 實戰聖經 | ActiveRecord - 基本操作與關聯設計](https://ihower.tw/rails/activerecord.html)


`rails g migration create_user`

```
class CreateUsers < ActiveRecord::Migration
  def up
    create_table :users do |t|

    end

    add_column :users, :post_id, :integer
  end

  def down
    drop_table :authorities
  end
end
```


`rails g migration create_post`

```
class CreatePosts < ActiveRecord::Migration
  def up
    create_table :posts do |t|
      t.boolean :is_editable, default: false
      t.integer :user_id
      t.integer :post_id
  end

  def down
    drop_table :authorities
  end
end
```


# model配置

```
class User < ActiveRecord::Base
  has_many :posts
  has_many :honors
end


class Post < ActiveRecord::Base
  belongs_to :author, class_name: "User", foreign_key: :user_id

  def editable_by?(user)
    user && user == author
  end
end
```

# 該篇post的view裡的edit button

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
```
