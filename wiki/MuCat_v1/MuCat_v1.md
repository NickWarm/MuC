# MuCat Lab v1

基於[UserStory_v6](./userstory_v6.md)整理實作細節

# 情境

實驗室成員新登入 -> 依據信箱自動創建帳號  -> 點到實驗室成員頁面  -> 修改自己的個人資料



# 架構

## 概觀
- 實驗室簡介      
- 學習資源       
- 實驗室公告      
- 實驗室成員資料   
- 榮譽榜

### 首頁
- 實驗室簡介
  - 上面是介紹文
  - 下面是教授的 **個人頁面連結**
- 榮譽榜
  - CRUD，WYSIWYG editor，**Honor model**
- 學習資源
  - CRUD，**Learning model**

### NavBar
- 實驗室公告
  - CRUD，WYSIWYG editor，**News model**
- 實驗室成員資料
  - 教授
    - CRUD，**Work model**
  - 實驗室成員
    - CRUD，**User model**
- 研究成果
  - 用`each`撈 **User model** 的「學籍、姓名、論文題目」

>不知道`News model`在rails會不會有語法問題...

>不要用`rails g model title:string content:text`這種寫法，這樣要修改schema不方便
>
>使用[railsfun 2.5 day 購物車](https://github.com/NickWarm/jccart/blob/master/wiki/Note_3_model.md)的寫法，在`app/model`下建`member.rb`然後在iTerm下指令`add_column`來設定表單

### 後台

情境：是否是 **在校生**
- 影響「實驗室成員」member_index的頁面
- 若是畢業了，實驗室管理員可以把身份修改為 **畢業生**
- 已畢業的學生，就會自動從member_index頁面消失，跳到「畢業生頁面」

總管理員可以 **編輯** 實驗室成員的 **身份**
- 實驗室成員排序：由新到舊

```
/dashboard/                 #使用者後台網址
/dashboard/qazrfvyhnqwecvb  #管理者後台網址
```

> ref：[會員與登入系統要點：devise / robots.txt - Rails - Rails Fun!! Ruby & Rails 中文論壇](http://railsfun.tw/t/devise-robots-txt/376)

# 細節
- 實驗室簡介
  - 上面簡介文
  - 下面榮譽榜的連結
    - 榮譽榜
      - **CRUD**，WYSIWYG editor
        - **Honor model**
        - 標題:string、內容:content
        - `title:string content:text`
- 學習資源
  - 五篇獨立文章
    - 學習方法論     
    - 教書時的pdf檔  
    - 影像處理   
    - 訊號與系統         
    - 機率與統計
      - 文章都是 **Markdown editable**
      - 一個 **partial form，input的資料型別用text**        
  - **CRUD**
    - **LearningNote model**
    - 作者:string、標題:string、內容:text
    - `author:string title:string content:text other_can_edit:boolean`
- 實驗室公告
  - **CRUD**，WYSIWYG editor
    - **News model**
    - 標題:string、內容:text
    - `title:string content:text`
- 實驗室成員資料   
  - 教授  
    - 左邊介紹，右邊三篇文章連結
      - 發表的論文、技術報告、個人著作
      - 這三篇文章都是 **Markdown editable**
      - 一個 **partial form，input的資料型別用text**
      - **CRUD**
        - **Work model**
        - 標題:string、內容:text
        - `title:string content:text`
  - 實驗室成員
    - 論文題目用nested_form去更新
    - 個人介紹採用Markdown editable
    - 一個 **partial form，input的資料型別用text**
    - **CRUD**：個人照片、姓名、學籍、論文題目、自我介紹、學位(**博士生？研究生？大學生？**)、身份 (**在校生？畢業生？**)
      - **User model**
      - 入學學籍:integer、姓名:string、論文題目:string、自我介紹:text、學位、身份狀態:string
      - `name:string year:integer paper:string profile:text academic_degree:string has_graduated:boolean`
    - 實驗室成員頁面排序
      - 在學生：新到舊
      - 畢業生：舊到新
- 研究成果
  - 實驗室成員的歷年研究題目、論文
    - 一篇文章，按發表年份由上往下排。
    - 用`each`撈 **實驗室成員** 的「學籍、姓名、論文題目」
    - 會用到SQL語法
    - n+1 Query的問題？

> 使用will_paginate gem時，一個頁面有五篇文章

> 學位的英文參考自[wiki](https://en.wikipedia.org/wiki/Academic_degree)

# Features

### Form
- 實驗室成員，**User model**
  - 個人照片、姓名、學籍、論文題目、簡要介紹、身份
    - 個人照片
      - paperclip gem
    - 姓名、入學學年
      - 一般的表單
    - 就讀學位：博士生？研究生？大學生？
      - 下拉式選單
    - 身份：在學生？畢業生？
      - 下拉式選單
    - 論文題目
      - 論文可能不只一篇，**一對多**
      - **Paper Model**
      - dynamic nested form
    - 簡要介紹
      - `profile:text`
      - markdown
- 實驗室公告，**News model**
  - 標題、內容
  - `title:string content:text`
- 榮譽榜，**Honor model**
  - WYSIWYG editor
- 學習資源，**Learning model**
  - markdown
  - 作者、標題、內容、他人是否可編輯
  - `author:string title:string content:text other_can_edit:boolean`

>思考：
>
>下拉式選單
>- 是否是 **在學生**？
>  - `is_student:boolean`
>- 身份
>  - 博士生？研究生？大學生？畢業生？

### 實驗室成員的index page
- 依照身份不同，在不同的階層
  - 用scope實作

### Nested Form
- 實驗室成員，**User model**
  - paper
    - `name:string`

### 文章編輯權限
- 跟老師要歷屆實驗室成員的信箱，我一個一個手動幫他們註冊。密碼統一用`lab515`來建的個人資料
- 然後再寄給眾畢業生，讓他們自己去改個人資料與自介
- 總管理員
  - 我與老師
  - 擁有 **刪除** 的權限
- 學習資源的文章
  - 給學習資源的文章，在 **Learning Model** 開一個新的欄位`other_can_edit:boolean`
    - 在表單裡弄成下拉式選單，發表文章時
      - `false`，只有發文者可以編輯
      - `true`，其他實驗室成員可以編輯
    - 留言系統
      - Disqus
  - 實驗室成員都有 **新增文章** 的權限，但只有總管理員可以 **刪除文章**
    - 避免實驗室成員誤刪重要文章

>思考：
>
>學習資源的文章
>- ~~我發表的文章，只有我有 **編輯** 的權限~~
>- 在 **Learning Model** 開一個新的欄位`other_can_edit:boolean`


### 登入系統
- devise的寫法
- 用臉書、google帳號登入

### SEO優化
- friendly_id gem

# 練習順序
1. Nested Form
2. 下拉式選單
3. 登入系統
4. 實作Mackenize Child的部落格
   - Form use markdown
   - Disqus
   - SEO優化：friendly_id
5. i18n
6. 實驗室成員用scope實作

# 參考資料

#### Nested Form
- [rails nested forms - YouTube](https://www.youtube.com/results?search_query=rails+nested+forms)
- [Nested form | Rails 102](https://rocodev.gitbooks.io/rails-102/content/chapter1-mvc/v/nested-form.html)
- [Rails Nested Model forms — Ruby on Rails 指南](http://rails.ruby.tw/nested_model_forms.html)
- [Rails nested form 的問題 - 求救 - Rails Fun!! Ruby & Rails 中文論壇](http://railsfun.tw/t/rails-nested-form/685)
- [Ruby on Rails 如何實作可動態新增欄位的表單(dynamic nested form) – 先求有再求好](https://krammer0.wordpress.com/2016/05/04/ror-%E5%8B%95%E6%85%8B%E6%96%B0%E5%A2%9E%E6%AC%84%E4%BD%8D%E7%9A%84%E8%A1%A8%E5%96%AE/)
- [simple_form nested attribute 巢狀表格 Rails 要注意的點 - 丹哥的技術培養皿](http://tech.guojheng-lin.com/posts/2014/07/01/simple-form-nested-nested-table-attribute-rails-to-note-the-points/)

#### 下拉式選單 (v1不考慮)
- [dropdown in rails - YouTube](https://www.youtube.com/watch?v=B2uEbkAk6aI)
- [Integrating a Dropdown Element into a Rails Form - YouTube](https://www.youtube.com/watch?v=FWIXWutlxIg)
- [Step.12 類別的下拉選單 · NickWarm/jccart Wiki](https://github.com/NickWarm/jccart/wiki/Step.12--%E9%A1%9E%E5%88%A5%E7%9A%84%E4%B8%8B%E6%8B%89%E9%81%B8%E5%96%AE)

#### 登入系統
1. 影片
   - [rails facebook login - YouTube](https://www.youtube.com/results?search_query=rails+facebook+login)
   - [rails google login - YouTube](https://www.youtube.com/results?search_query=rails+google+login)
2. 文章
   - [Ruby on Rails - 整合 Devise 實作 Facebook 登入機制 « 魚人筆>記](http://fisherliang.logdown.com/posts/301654-ruby-on-rails-real-facebook-login-mechanism)
   - [使用Omniauth整合facebook及google註冊認證 – 酷思小魏の IT筆記](https://blog.coolsea.net/archives/153)
   - [Devise使用Google實作登入 « NicLin Dev](http://blog.niclin.tw/posts/628482--devise-used-google-implements-login)
   - [Devise 使用 Facebook 註冊與登入 « 像貓一樣懶](http://georgiowan.logdown.com/notes/733856/rails-devise-using-facebook-signup-login)
   - [透過OmniAuth使用FB帳號登入 « Kuro_Sean's Blog](http://kuro-sean-blog.logdown.com/posts/712195-via-omniauth-fb-account-login)

#### Form use markdown
- [Markdown & Syntax Highlighting - How to build a blog & portfolio with Rails 4 - YouTube](https://www.youtube.com/watch?v=fY2SuLqMD_w&index=15&list=PL23ZvcdS3XPK9Y4DRU-BiJtiY5L_QhUUq)

#### Form use WYSIWYG editor
- [Rails 中如何集成帶圖片上傳功能的simditor 編輯器· Ruby China](https://ruby-china.org/topics/28467?hmsr=toutiao.io&utm_medium=toutiao.io&utm_source=toutiao.io)
- [Rails项目集成Simditor编辑器 - 只想安静地做个美男子 - 开源中国社区](https://my.oschina.net/huangwenwei/blog/408998)
- [手把手教你在Rails中集成Simditor富文本编辑器 - 写出来的都是shit，快关闭!](http://www.printshit.me/blog/2016/05/30/how-to-use-simditor-in-rails/)

#### 留言系統：Disqus
- [Add Disqus Comments - How to build a blog & portfolio with Rails 4 - YouTube](https://www.youtube.com/watch?v=_8tRlrU3tZQ&index=17&list=PL23ZvcdS3XPK9Y4DRU-BiJtiY5L_QhUUq)

#### SEO優化
- [Add the friendly id gem - How to build a blog & portfolio with Rails 4 - YouTube](https://www.youtube.com/watch?v=62PQUaDhgqw)

#### 英文版
使用i18n

#### 實驗室成員用scope實作
- 在校生？畢業生？
- 依照身份不同，在不同的階層

筆記太多，請直接觀看[member_index.md](../features/member_index/member_index.md)
