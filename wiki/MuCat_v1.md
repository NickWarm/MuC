# MuCat Lab v1

基於[UserStory_v5](./userstory_v5.md)整理實作細節

## 架構

### 概觀
- 實驗室簡介      
- 學習資源       
- 實驗室公告      
- 實驗室成員資料   
- 榮譽榜

#### 首頁
- 實驗室簡介
  - 上面是介紹文
  - 下面是教授的 **個人頁面連結**
- 榮譽榜
  - CRUD，WYSIWYG editor，**Honor model**
- 學習資源
  - CRUD，**Resource model**

> 榮譽榜：
> 學習資源：

#### NavBar
- 實驗室公告
  - CRUD，WYSIWYG editor，**News model**
- 實驗室成員資料
  - 教授
    - CRUD，**Work model**
  - 實驗室成員
    - CRUD，**Member model**
- 研究成果
  - 用`each`撈 **Member model** 的「學籍、姓名、論文題目」

>不知道News model在rails會不會有語法問題...

>不要用`rails g model title:string content:text`這種寫法，這樣要修改schema不方便
>
>使用[railsfun 2.5 day 購物車](https://github.com/NickWarm/jccart/blob/master/wiki/Note_3_model.md)的寫法，在`app/model`下建`member.rb`然後在iTerm下指令`add_column`來設定表單

## 細節
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
    - **Resource model**
    - 作者:string、標題:string、內容:text
    - `author:string title:string content:text`
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
    - **CRUD**：個人照片、姓名、學籍、論文題目、自我介紹、是否畢業
      - **Member model**
      - 學籍:integer、姓名:string、論文題目:string、自我介紹:text、畢業:boolean
      - `year:integer name:string paper:string introduction:text graduation:boolean`
- 研究成果
  - 實驗室成員的歷年研究題目、論文
    - 一篇文章，按發表年份由上往下排。
    - 用`each`撈 **實驗室成員** 的「學籍、姓名、論文題目」
    - 會用到SQL語法
    - n+1Query的問題？

> 使用will_paginate gem時，一個頁面有五篇文章

## UI實作
