# 入學學年與現在幾年級

現在進度：
- User schema
  - 中文名字:string -> `taiwan_name:string`  -> **done**
  - 英文名字:string -> `english_name:string` -> **done**
  - 自我介紹:text -> `profile:text`          -> **done**
  - 論文題目:text -> `paper:text`            -> **done**
  - 學位:string -> `academic_degree:string` -> **done**
  - 入學學年:integer -> `joined_CYCU_at_which_year:integer`
  - 現在幾年級:integer -> `has_spent_how_much_time_at_CYCU:integer`
  - 是否離開學校:boolean -> `has_graduated:boolean` -> **done**

## 入學學年：概念

入學學年只要在user的 edit頁面開一個input，然後顯示出來即可。

so edit `app/views/dashboard/users/edit.html.erb`

```
<%= f.label :joined_CYCU_at_which_year, "入學學年" %>
<%= f.text_field :joined_CYCU_at_which_year %>
```

and then edit `app/views/users/show.html.erb`

```
<h1>入學學年</h1>
<p> <%= @user.joined_CYCU_at_which_year %> 學年 </p>
```


然後要用`scope`在`user.rb`裡做一個排序的方法，這樣就能從 **最新到最舊** 或是 **最舊到最新**，來排序各個學位的實驗室成員。

>想法.1

如果要依靠入學學年的先後做排序，那麼註冊頁面應該要有input tag輸入民國幾年入學。

實作這個也有點複雜，要去改devise的registrations controller

然後自定義registration view，開表單，定義strong parameter。

>想法.2

這個實作比較簡單，註冊後導入user show頁面，然後進入user edit頁面，輸入入學學年。

>結論

個人較偏好 **想法.1**，但是實作上比較複雜。等到「榮譽榜、學習資源、實驗室公告」做完後再來做這塊。

## 現在幾年級：概念

**這功能沒有那麼必要與急迫**，一來外人沒興趣知道學生現在幾年級，二來，排序的問題，可以直接透過入學學年的先後做排序

在這邊簡述他的邏輯：

1. 把入學學年轉換成西元
2. 撈出今年西元幾年
3. 兩著相減得到的數字，就是該學生現在幾年級
4. 如果學生設定為畢業，就停止計算

入學學年與西元的換算
- [如何把西元年轉為當前學年度 @ 毛哥資訊日誌 :: 痞客邦 PIXNET ::](http://awei791129.pixnet.net/blog/post/40554993-%5B公式%5D-如何把西元年轉為當前學年度)

撈出現在西元幾年可參考這篇文章
- [Get the Current Year in the Ruby Programming Language - Rietta](https://rietta.com/blog/2015/03/13/ruby-current-year/)
