# MuCat Lab v1

基於[UserStory_v7](../userstory_versions/userstory_v7.md)整理實作細節

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
  - CRUD，~~WYSIWYG editor~~，~~**Honor model**~~，(礙於 **資安問題** 還無法解，MuCat_v1暫不考慮)
  - 把 **Post model** 改成「榮譽榜」來用
- 學習資源
  - CRUD，~~**Learning model**~~，改名為 **Note model**

### NavBar
- ~~實驗室公告~~ -> 中原的學生要看修課公告，通常會選擇看學校的ilearning系統，不會刻意跑去實驗室網站看
  - ~~**News model**~~，改名為 **Post model**
  - CRUD，~~WYSIWYG editor~~，(礙於 **資安問題** 還無法解，MuCat_v1暫不考慮)
- 榮譽榜
- 實驗室成員資料
  - 教授的著作
    - CRUD，**ProfessorWork model**
  - 實驗室成員
    - CRUD，**User model**
- ~~研究成果~~
  - ~~用`each`撈 **User model** 的「學籍、姓名、論文題目」~~



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
    - **Note model**
    - 作者:string、標題:string、內容:text  
    - `author:string title:string content:text other_can_edit:boolean`
- 實驗室公告
  - **CRUD**，WYSIWYG editor
    - **Post model**
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
    - ~~論文題目用nested_form去更新~~
    - 個人介紹採用Markdown editable
    - 一個 **partial form，input的資料型別用text**
    - **CRUD**：個人照片、姓名、學籍、論文題目、自我介紹、學位(**博士生？研究生？大學生？**)、是否畢業 (**在校生？畢業生？**)
      - **User model**
        - 中文名字:string -> `taiwan_name:string`  -> **done**
        - 英文名字:string -> `english_name:string` -> **done**
        - 自我介紹:text -> `profile:text`          -> **done**
        - 論文題目:text -> `paper:text`            -> **done**
        - 學位:string -> `academic_degree:string` -> **done**
        - 入學學年:integer -> `joined_CYCU_at_which_year:integer` -> **done**
        - 現在幾年級:integer -> `has_spent_how_much_time_at_CYCU:integer`
        - 是否離開學校:boolean -> `has_graduated:boolean`  -> **done**
    - 實驗室成員頁面排序
      - 在學生：新到舊
      - 畢業生：舊到新
- ~~研究成果~~
  - ~~實驗室成員的歷年研究題目、論文~~
    - ~~一篇文章，按發表年份由上往下排。~~
    - ~~用`each`撈 **實驗室成員** 的「學籍、姓名、論文題目」~~
    - ~~會用到SQL語法~~
    - ~~n+1 Query的問題？~~

由於實驗室成員的個人論文，改成`paper:text`使用Markdown來編輯，所以決定不要實作研究成果。

研究成果以「教授個人的著作」與「榮譽榜」來吸眼球

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
      - ~~論文可能不只一篇，**一對多**~~
      - ~~**Paper Model**~~
      - ~~dynamic nested form~~
      - 直接在user model下開一個欄位`paper:context`
      - 然後讓他用Markdown編輯
      - 瞬間什麼nested_form都不用考慮了XDDDDDDDDDD
    - 簡要介紹
      - `profile:text`
      - markdown
- 實驗室公告，**Post model**
  - 標題、內容
  - `title:string content:text`
- 榮譽榜，**Honor model**
  - WYSIWYG editor
- 學習資源，**Note model**
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
  - 給學習資源的文章，在 **Note Model** 開一個新的欄位`other_can_edit:boolean`
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
>- 在 **Note Model** 開一個新的欄位`other_can_edit:boolean`


### 登入系統  
- devise的寫法  -> **done**
- 用臉書~~、google~~帳號登入 -> **done**  

### SEO優化
- friendly_id gem



# 參考資料

#### Form use markdown
- [Markdown & Syntax Highlighting - How to build a blog & portfolio with Rails 4 - YouTube](https://www.youtube.com/watch?v=fY2SuLqMD_w&index=15&list=PL23ZvcdS3XPK9Y4DRU-BiJtiY5L_QhUUq)

#### Form use WYSIWYG editor (MuCat_v1暫不考慮)
- [Rails 中如何集成帶圖片上傳功能的simditor 編輯器· Ruby China](https://ruby-china.org/topics/28467?hmsr=toutiao.io&utm_medium=toutiao.io&utm_source=toutiao.io)
- [Rails项目集成Simditor编辑器 - 只想安静地做个美男子 - 开源中国社区](https://my.oschina.net/huangwenwei/blog/408998)
- [手把手教你在Rails中集成Simditor富文本编辑器 - 写出来的都是shit，快关闭!](http://www.printshit.me/blog/2016/05/30/how-to-use-simditor-in-rails/)

#### 留言系統：Disqus
- [Add Disqus Comments - How to build a blog & portfolio with Rails 4 - YouTube](https://www.youtube.com/watch?v=_8tRlrU3tZQ&index=17&list=PL23ZvcdS3XPK9Y4DRU-BiJtiY5L_QhUUq)

#### SEO優化
- [Add the friendly id gem - How to build a blog & portfolio with Rails 4 - YouTube](https://www.youtube.com/watch?v=62PQUaDhgqw)

#### 英文版
使用i18n

#### 實驗室成員
- 在校生？畢業生？
- 依照身份不同，在不同的階層

筆記太多，請直接觀看[member_index.md](../features/member_index/member_index.md)
