# 實驗室成員的學歷資訊



先看一下記錄在[MuCat_v1.md](./MuCat_v1.md)的`user` schema的架構
- User schema
  - 中文名字:string -> `taiwan_name:string`  -> **done**
  - 英文名字:string -> `english_name:string` -> **done**
  - 自我介紹:text -> `profile:text`          -> **done**
  - 論文題目:text -> `paper:text`            -> **done**
  - 學位:string -> `academic_degree:string`
  - 入學學年:integer -> `joined_CYCU_at_which_year:integer`
  - 現在幾年級:integer -> `has_spent_how_much_time_at_CYCU:integer`
  - 是否離開學校:boolean -> `has_graduated:boolean` -> **已設置欄位**，但是UI還沒寫


## 重整schema

最初透過`db/migrate/20161122091021_add_has_graduated_to_users.rb`建立了`has_graduated:boolean`

```
class AddHasGraduatedToUsers < ActiveRecord::Migration
  def change
    add_column :users, :has_graduated, :boolean, default: false
  end
end
```

不過與`has_graduated:boolean`相關連的卻都還沒有建
- `academic_degree:string`
- `spent_time_at_university:integer`
- `spent_time_at_university:integer`

再三考慮後，決定重整schema

首先，刪掉`User` database裡測試用的資料

 and then delete `db/migrate/20161122091021_add_has_graduated_to_users.rb`

`rails g migration AddSchoolInformationToUser`

edit `db/migrate/20170107112636_add_school_information_to_user.rb`

```
class AddSchoolInformationToUser < ActiveRecord::Migration
  def change
    add_column :users, :has_graduated,                   :boolean, default: false
    add_column :users, :academic_degree,                 :string
    add_column :users, :joined_CYCU_at_which_year,       :integer
    add_column :users, :has_spent_how_much_time_at_CYCU, :integer
  end
end
```

and then `rake db:migrate:reset`

## 建立`has_graduated:boolean`的Toggle button

基本上我打算使用semantic UI的toggle來做
- [Toggle - Checkbox | Semantic UI](http://semantic-ui.com/modules/checkbox.html#toggle)

基本上它的本質就是`input tag`的`checkbox`

整個實作非常簡單，一開始我看[Toggle - Checkbox | Semantic UI](http://semantic-ui.com/modules/checkbox.html#toggle)的code

```
<div class="ui toggle checkbox">
  <input type="checkbox" name="public">
  <label>Subscribe to weekly newsletter</label>
</div>
```

並且參考rails裡`checkbox`的寫法
- [rails API - check_box](http://api.rubyonrails.org/classes/ActionView/Helpers/FormHelper.html#method-i-check_box)
- [表單輔助方法 - Ruby on Rails 實戰聖經 | Action View - Helpers 方法](https://ihower.tw/rails/actionview-helpers.html#sec5)，搜尋「f.check_box :column_name」


and then edit `app/views/dashboard/users/edit.html.erb`

```
<%= form_for current_user, url: dashboard_user_path, method: :patch do |f| %>
  <%= f.label :taiwan_name, "Name" %>
  <%= f.text_field :taiwan_name %>

  <br>

  <%= f.label :english_name, "English Name" %>
  <%= f.text_field :english_name %>


  <br>

  <div class="ui toggle checkbox">
    <%= f.check_box(:has_graduated) %>
  </div>

  ...
<% end %>
```

但是後來重整頁面發現Toggle的效果沒出來，於是回去看semantic_ui的範例時注意到`<label>Subscribe to weekly newsletter</label>`這行

於是參考rails guide的寫法
- [1.3.1 多選方框 - 1.3 產生表單元素的輔助方法 - Action View 表單輔助方法 — Ruby on Rails 指南](http://rails.ruby.tw/form_helpers.html#產生表單元素的輔助方法)，搜尋「check_box」

and then fix `app/views/dashboard/users/edit.html.erb`

```
<div class="ui toggle checkbox">
  <%= f.check_box(:has_graduated) %>
  <%= label_tag(:has_graduated, "已經畢業") %>
</div>
```

成功在edit view 顯示Toggle的效果，但是查user的database發現`:has_graduated`欄位沒有修改成功，才想起來沒去users_controller的strong parameter加入`:has_graduated`

so fix `app/controllers/dashboard/users_controller.rb`

```
def user_params
  params.require(:user).permit(:taiwan_name, :english_name, :paper, :profile, :has_graduated)
end
```

然後再測試一次，work

現在進度：
- User schema
  - 中文名字:string -> `taiwan_name:string`  -> **done**
  - 英文名字:string -> `english_name:string` -> **done**
  - 自我介紹:text -> `profile:text`          -> **done**
  - 論文題目:text -> `paper:text`            -> **done**
  - 學位:string -> `academic_degree:string`
  - 入學學年:integer -> `joined_CYCU_at_which_year:integer`
  - 現在幾年級:integer -> `has_spent_how_much_time_at_CYCU:integer`
  - 是否離開學校:boolean -> `has_graduated:boolean` -> **done**

## 實作實驗室成員的index page

### 學歷的下拉式選單

完成了判斷是否畢業的`:has_graduated`後開始實作實驗室成員的index page。最初的筆記紀錄於[member_index.md](../features/member_index/member_index.md)

開始之前，要先在user的edit view做一個下拉選單，讓實驗室成員選擇自己是 **大學生** or **研究生** or **博士生**
- 大學生：`"college"`
- 研究生：`"master"`
- 博士生：`"Ph.D"`

為了避免strong parameter又沒過

so edit `app/controllers/dashboard/users_controller.rb`

```
def user_params
  params.require(:user).permit(:taiwan_name, :english_name, :paper, :profile,
                               :has_graduated, :academic_degree,
                               :joined_CYCU_at_which_year, :has_spent_how_much_time_at_CYCU)
end
```

並參考以前寫過的筆記：[dropdown_list.md](../features/dropdown_list/dropdown_list.md)

and then edit `app/views/dashboard/users/edit.html.erb`

```
<div class="">
  <%= f.label :academic_degree, "現在學歷" %>
  <%= f.select :academic_degree, [["大學生", "college"], ["研究生", "master"], ["博士生", "Ph.D"]], class: "ui dropdown" %>    
</div>
```

但是卻有問題，`select` tag的class卻沒有出來

![](../img/select_tag_class_fail.png)

後來我朋友幫我抓蟲與找到這篇
- [comment1：Ruby on Rails form_for select field with class - Stack Overflow](http://stackoverflow.com/a/4081944)

so fix `app/views/dashboard/users/edit.html.erb`

```
<%= f.select :academic_degree, [["大學生", "college"], ["研究生", "master"], ["博士生", "Ph.D"]], {}, class: "ui dropdown" %>    
```

然後發現還要再去`<scipt>`那邊設定使用`.dropdown`方法

so fix `app/views/dashboard/users/edit.html.erb`

```
<%= content_for :header do %>
  <script>
  $(function(){
    $(".ui.dropdown").dropdown()

    $('#image').change(function(){
      // paperclip AJAX upload
      ...
      ...
    })
  })

  </script>
<% end %>
```

很好，成功

現在進度：
- User schema
  - 中文名字:string -> `taiwan_name:string`  -> **done**
  - 英文名字:string -> `english_name:string` -> **done**
  - 自我介紹:text -> `profile:text`          -> **done**
  - 論文題目:text -> `paper:text`            -> **done**
  - 學位:string -> `academic_degree:string` -> **完成edit頁面下拉式選單**，準備來做index頁面的scope
  - 入學學年:integer -> `joined_CYCU_at_which_year:integer`
  - 現在幾年級:integer -> `has_spent_how_much_time_at_CYCU:integer`
  - 是否離開學校:boolean -> `has_graduated:boolean` -> **done**

### index頁面的scope

實作實驗室成員的index page。最初的筆記：[member_index.md](../features/member_index/member_index.md)

參考
- 最初的筆記：[member_index.md](../features/member_index/member_index.md)
- [scope | Rails 102](https://rocodev.gitbooks.io/rails-102/content/chapter1-mvc/m/scope.html)

簡單回憶一下scope的用途，他可以讓我們的SQL語法做串接的功能，讓你把會用到的SQL包成一個method可以呼叫


so edit `uapp/models/user.rb`
