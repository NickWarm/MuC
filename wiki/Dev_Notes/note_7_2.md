# n+1 queries

前台users_controller

```

```

後台posts_controller

```

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
