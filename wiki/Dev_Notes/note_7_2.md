# n+1 queries

參考以前寫過的筆記：[JCcart - wiki - Step.12 類別的下拉選單 - n+1 query](https://github.com/NickWarm/jccart/wiki/Step.12--類別的下拉選單#n1-query)

前台users_controller

fix `app/controllers/users_controller.rb`

```
class UsersController < ApplicationController
  before_action :find_user, only: [:show]

  def index
    @users_doctor = User.includes(:images).doctor.has_graduated(false)
    @users_master = User.includes(:images).master.has_graduated(false)
    @users_college = User.includes(:images).college.has_graduated(false)
  end

  ...

  def graduates
    @users_doctor = User.includes(:images).doctor.has_graduated(true)
    @users_master = User.includes(:images).master.has_graduated(true)
    @users_college = User.includes(:images).college.has_graduated(true)
  end

  ...
end
```




# 修掉user登入後，其他人的user show頁面，也可以看到edit button

`users/show.html.erb`

form

```
<% if user_signed_in? %>
  <div id="admin_links">
    <%= link_to "edit profile", edit_dashboard_user_path, class: "view_more" %>
  </div>
<% end %>
```

to

```
<% if current_user == @user %>
  <div id="admin_links">
    <%= link_to "edit profile", edit_dashboard_user_path, class: "view_more" %>
  </div>
<% end %>
```
