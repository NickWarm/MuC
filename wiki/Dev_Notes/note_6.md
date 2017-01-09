# 學習資源

>年代有點久遠的舊筆記

要在 **學習資源** 這頁面發文

學習資源的表單設計，除了原本[MuCat_v1.md](../MuCat_v1/MuCat_v1.md)的
- ~~`author:string title:string content:text other_can_edit:boolean`~~
- 改成：`author:string title:string content:text is_editable:boolean`

後來參考
- [mackenziechild GitHub - blog_course_demo/db/migrate/20150509171512_create_projects.rb](https://github.com/mackenziechild/blog_course_demo/blob/master/db/migrate/20150509171512_create_projects.rb)
- [mackenziechild GitHub - blog_course_demo/app/views/projects/show.html.erb](https://github.com/mackenziechild/blog_course_demo/blob/master/app/views/projects/show.html.erb)

應該加個`link:string`才對，這樣才能連到外部文章，這樣也比較符合我的需求


>新筆記

學習資源用`note`表示
- 後台：`new`、`edit`
- 前台：`index`、`show`
- markdown語法
- 欄位：`author:string title:string content:text is_editable:boolean link_text:string link_site:string`
- `is_editable:boolean`是開放權限，看你是否要讓其他所有實驗室成員都能夠編輯，用semantic_ui的Toggle實作
- 最後的`link_text:string link_site:string`是打算發布學習方法論那類文章，你只打算開個引言，然後導引到其他頁面時才用的。
- `link_text:string`：超連結的文字
- `link_site:string`：外部連結的網址


create `note schema`

`rails g model note`

edit `db/migrate/20170108125932_create_notes.rb`

完整的code
```
class CreateNoteTable < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.string   :author
      t.string   :title
      t.text     :content
      t.boolean  :is_editable,   default: false
      t.string   :link_text
      t.string   :link_site
      t.timestamps
    end
  end
end
```

and then `rake db:migrate`

突然想起，忘記加上`user_id`

so `rails g migration AddUserIdToNote`

and edit `db/migrate/20170108132424_add_user_id_to_note.rb`

```
class AddUserIdToNote < ActiveRecord::Migration
  def change
    add_column :notes, :user_id, :integer
  end
end
```


# partial form

由於`dashboard/notes/new.html.erb`與`dashboard/notes/edit.html.erb`表單的內容有重複，所以決定用partial form

但是由於，表單在後台，所以我的`form_for`的路由不能用傳統的寫法，必須要像下面這篇一樣用 **指定路徑** 與 **指定HTTP Verb** 的寫法
- [JCcart wiki - Step.9 開始修scaffold - edit](https://github.com/NickWarm/jccart/wiki/Step.9-開始修scaffold#edit)

所以參考ihower的這篇
- [局部樣板Partials - Ruby on Rails 實戰聖經 | Action View - 樣板設計](https://ihower.tw/rails/actionview.html#sec6)

## 完整code

先上code再來解釋

create `app/views/dashboard/notes/_form.html.erb`

```
<h2><%= f.label :title, "Title" %></h2>
<%= f.text_field :title, :required => true  %>

<div class="ui toggle checkbox">
  <%= f.check_box(:is_editable) %>
  <%= label_tag(:is_editable, "開放給他人編輯") %>
</div>

<br>

<h2><%= f.label :content, "Content" %></h2>
<%= f.text_area :content, :required => true  %>

<h2>是否需要外部連結</h2>
<%= f.label :link_text, "超連結文字" %>
<%= f.text_field :link_text  %>
<%= f.label :link_site, "網址" %>
<%= f.text_field :link_site  %>
```

fix `app/views/dashboard/notes/new.html.erb`

```
<h1>note new action</h1>

<h1 id="page_title">New Note</h1>

<div class="skinny_wrapper wrapper_padding">
  <%= form_for @note, url: dashboard_notes_path, method: :post do |f| %>

    <%= render :partial => 'form', locals: {:f => f} %>

    <%= f.submit %>
  <% end %>

</div>
```

fix `app/views/dashboard/notes/edit.html.erb`

```
<h1>note edit action</h1>

<h1 id="page_title">Edit Note</h1>

<div class="skinny_wrapper wrapper_padding">
  <%= form_for @note, url: dashboard_note_path, method: :patch do |f| %>

    <%= render 'form', {:f => f} %>

    <%= f.submit %>
  <% end %>

</div>
```

比較上面的`new`與`edit`的view，會發現`render partial`的寫法不同，下面會進行解釋

## 解釋code


以`app/views/dashboard/notes/new.html.erb` 為例，原本的code應該如下

```
<h1>note new action</h1>

<h1 id="page_title">New Note</h1>

<div class="skinny_wrapper wrapper_padding">
  <%= form_for @note, url: dashboard_notes_path, method: :post do |f| %>

    <h2><%= f.label :title, "Title" %></h2>
    <%= f.text_field :title, :required => true  %>

    <div class="ui toggle checkbox">
      <%= f.check_box(:is_editable) %>
      <%= label_tag(:is_editable, "開放給他人編輯") %>
    </div>

    <br>

    <h2><%= f.label :content, "Content" %></h2>
    <%= f.text_area :content, :required => true  %>

    <h2>是否需要外部連結</h2>
    <%= f.label :link_text, "超連結文字" %>
    <%= f.text_field :link_text  %>
    <%= f.label :link_site, "網址" %>
    <%= f.text_field :link_site  %>

    <%= f.submit %>
  <% end %>

</div>
```

由於表單的內容會重複，所以用partial處理

create `app/views/dashboard/notes/_form.html.erb`

```
<h2><%= f.label :title, "Title" %></h2>
<%= f.text_field :title, :required => true  %>

<div class="ui toggle checkbox">
  <%= f.check_box(:is_editable) %>
  <%= label_tag(:is_editable, "開放給他人編輯") %>
</div>

<br>

<h2><%= f.label :content, "Content" %></h2>
<%= f.text_area :content, :required => true  %>

<h2>是否需要外部連結</h2>
<%= f.label :link_text, "超連結文字" %>
<%= f.text_field :link_text  %>
<%= f.label :link_site, "網址" %>
<%= f.text_field :link_site  %>
```

然後參考這篇，開始踩雷XD
- [局部樣板Partials - Ruby on Rails 實戰聖經 | Action View - 樣板設計](https://ihower.tw/rails/actionview.html#sec6)

一開始，我是先修`new`頁面，寫成

```
<h1>note new action</h1>

<h1 id="page_title">New Note</h1>

<div class="skinny_wrapper wrapper_padding">
  <%= form_for @note, url: dashboard_notes_path, method: :post do |f| %>

    <%= render 'form', locals: {:f => f} %>

    <%= f.submit %>
  <% end %>

</div>
```

然後就噴了

測了幾次後發現，若是要寫`:partial`就一定要寫`:locals`，一旦落單就會噴，所以以下寫法都會噴
- `<%= render 'form', locals: {:f => f} %>`
- `<%= render :partial => 'form', {:f => f} %>`

如果要省略`:partial`與`:locals`就要一起省略，所以`<%= render :partial => 'form', locals: {:f => f} %>`可以寫成

```
<%= render 'form', {:f => f} %>
```

所以我在`new`與`edit`寫了兩個不同但是相同結果的寫法，完成。
