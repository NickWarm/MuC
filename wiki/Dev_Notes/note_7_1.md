# user index頁面取得所有人最後上傳的照片

## v1

model之間的關聯
```
user has_many :images
image belongs_to :user
```


前台的`users_controller`

```
def index
  @users_doctor = User.doctor.has_graduated(false)
  @users_master = User.master.has_graduated(false)
  @users_college = User.college.has_graduated(false)
end
```

user index 頁面

```
<% @users_college.each do |user_college| %>
  <% if user_college.images.last.present? %>
    <%= image_tag user_college.images.last.image.url(:medium) %>
  <% end %>
  <%= link_to user_college.taiwan_name, user_college %>
<% end %>
```

## v2

v1那code太醜，我們先來看一小段

```
<% if user_college.images.last.present? %>
  <%= image_tag user_college.images.last.image.url(:medium) %>
<% end %>
```

這兩邊都會重複用到`images.last`，而`images`這方法定義在`user.rb`裡面

`user.rb`

```
has_many :images
```

所以我們可以在`user.rb`裡定義一個方法，來代表`images.last`這一串

so fix `app/models/user.rb`

```
class User < ActiveRecord::Base
  ...

  has_many :images

  # 撈user最後一張上傳的圖片，用於user index view
  def last_image
    images.last
  end

  #臉書登入
  def self.from_omniauth(auth)
    ...
  end
end
```

然後user index頁面

```
<% @users_college.each do |college_user| %>
  <% if college_user.last_image.present? %>
    <%= image_tag college_user.last_image.image.url(:medium) %>
  <% else %>
    <%= image_tag asset_path 'images/missing.jpg' %>
  <% end %>
  <%= link_to college_user.taiwan_name, college_user %>
<% end %>
```

這邊用`each`撈時，我的變數改用`college_user`，這樣串起來`college_user.last_image`整句話會比較直覺。


# 漂亮好看的畫面

```
<h1>大學生</h1>
<div class="row clearfix">

  <% @users_college.each do |college_user| %>
    <div class="lab_member">
      <% if college_user.last_image.present? %>
        <%= image_tag college_user.last_image.image.url(:icon) %>
      <% else %>
        <%= image_tag asset_path 'images/missing.jpg' %>
      <% end %>
      <p class="name"><%= link_to college_user.taiwan_name, college_user %></p>
      <p class="year"><%= college_user.joined_CYCU_at_which_year %>學年</p>
    </div>

<% end %>

</div>
```

需要說明改了哪些程式。


# 讓image_tag可以連得到個人頁面

from

```
<%= image_tag college_user.last_image.image.url(:icon) %>
```

to

```
<%= link_to image_tag(college_user.last_image.image.url(:icon)), college_user %>
```
