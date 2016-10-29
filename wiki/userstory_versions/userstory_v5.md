# MuWeb UserStory_v5

以下順序都是由左而右。

網站名稱
- 主標題：**MuCat Lab**   
- ~~副標題：多媒體計算與通訊研究室~~

>把 **多媒體計算與通訊研究室** 這行字放入實驗室簡介那區塊

## 網站內容

### 概觀
- 實驗室簡介      
- 學習資源       
- 實驗室公告      
- 實驗室成員資料   
- 榮譽榜          


### 架構
- 實驗室簡介
  - 寫死
  - 研究成果的 **連結**
    - 直接撈實驗室成員發表的論文
- 學習資源
  - 固定三篇文章，前兩篇寫死，第三篇CRUD
- 實驗室公告
  - CRUD
- 實驗室成員資料   
  - CRUD
- 榮譽榜
  - CRUD


### 第一版
- 實驗室簡介
  - 上面簡介文
  - 下面榮譽榜的連結
    - 榮譽榜
      - CRUD，WYSIWYG editor，**Honor model**
- 學習資源
  - CRUD，**Resource model**
- 實驗室公告
  - CRUD，WYSIWYG editor，**News model**
- 實驗室成員資料
  - 教授
    - CRUD，**Work model**
  - 實驗室成員
    - CRUD，**Member model**
- 研究成果
  - 用`each`撈 **Member model** 的「學籍、姓名、論文題目」

### 第二版
- 實驗室簡介
- 學習資源
  - CRUD
  - 用Vue.js 2.0開發，一個online markdown editor，儲存要在編輯頁面按右下角的儲存鍵
- 實驗室公告
  - CRUD，WYSIWYG editor
- 實驗室成員資料   
  - CRUD
  - 用Vue.js 2.0開發，一個online markdown editor，儲存要在編輯頁面按右下角的儲存鍵
- 榮譽榜
  - CRUD，WYSIWYG editor
- 研究成果

>1. 用Vue.js 2.0開發，一個online markdown editor，編輯頁面按右下角有儲存鍵
>
>2. 把前端改為RWD
>   - 可以參考[Making it Responsive - How to Code a Movie Trailer Site - Part 2 (Week 4.5 of 12) - YouTube](https://www.youtube.com/watch?v=MEpYu18EHV8&list=PL23ZvcdS3XPIr_bRRYaA779k3APzgjuQl&index=3)    

### 第三版
- 實驗室簡介
- 學習資源
  - CRUD
  - online markdown editor，即時編輯、即時儲存、即時顯示
- 實驗室公告
  - CRUD，WYSIWYG editor
- 實驗室成員資料   
  - CRUD
  - online markdown editor，即時編輯、即時儲存、即時顯示
- 榮譽榜
  - CRUD，WYSIWYG editor
- 研究成果

>用Vue.js 2.0開發，一個online markdown editor，即時編輯、即時儲存、即時顯示

# 前台

## NavBar
極左
- MuCat Lab，功能：回到首頁

極右
- 學習資源
- 實驗室公告
- 實驗室成員

>**榮譽榜**、**研究成果** 不放在NavBar裡，這些主要是為了 **給陌生人吸眼球用的**

## 首頁
目標：分三大區塊
- 一個畫面，三個區塊已經是最多了，再多就會凌亂。
- 每個區塊內的文章，都 **只顯示標題**，細節內容點進去看即可。



學生的需求
- 做專題找教授、研究生找教授
  - 理解該實驗室在做什麼領域的研究
  - 是否能透過該實驗室 增進自己未來碩班 **推甄的資本額**
  - 吸睛點：過去比賽得名的紀錄、發表paper優良論文的紀錄
  - 呈現：**學習資源、實驗室成員做過的研究、能取得過往學長姐的論文**
- 課程公告

### 首頁呈現出來的畫面
由左而右
- 實驗室簡介
  - 研究成果的 **連結**
- 學習資源
- 榮譽榜

>**榮譽榜**、**研究成果** 不放在NavBar裡，這些主要是為了 **給陌生人吸眼球用的**
>
>**研究成果** 會與實驗室成員的個人資料有重疊，更不需要放在NavBar裡面
>
>榮譽榜只有得獎紀錄，研究成果是實驗室成員的論文與專題題目，**榮譽榜包含在研究成果裡面**，所以研究成果是有必要存在的

#### 學習資源
- 架構
  - [Inner Game Plus 學習方法論](http://nickwarm.logdown.com/posts/966527)
  - 以前教書的講義pdf檔
  - 數篇獨立學習資源的文章
- 首頁固定三篇文章，前兩篇 **學習方法論、以前教書的pdf檔** 寫死，不開放編修、刪除。
- 學習資源的進入頁面，右下角有一個 **新增文章** 的按鈕。
- 學習資源頁面下，也有 **編輯文章** 的按鈕。
  - 實驗室成員學習新領域時，可以增加新文章並對它編修，把自己的學習資源分享給同儕。
  - UI：第1版
    - 「機率與統計、訊號與系統、影響處理」我會先提供我推薦的內容。學習資源區共五篇文章或更多
    - **開個CRUD**，~~傳統rails的寫法，寫個`ul > li`用`each`去撈~~
      - 缺點：要一筆一筆資料輸入進去，很麻煩，如果資源過時 **想要解釋哪邊不好，為何不再推薦** 這樣的呈現方式完全不符合需求
    - 這三篇專業科目的學習資源，都是Markdown editable
    - 一個 **partial form，input的資料型別用text**
  - UI：第2版
    - 進入頁面：三個區塊
    - 由左而右：機率與統計、訊號與系統、影像處理。學習資源區共三篇文章
  - UI：第3版
    - 右邊需要一個 **隱藏式SideBar**，SideBar內容：
      - 機率與統計
      - 訊號與系統
      - 影像處理
  - 更新教材，**需要開個CRUD**
    - ~~第一版：開一個CRUD，傳統rails的寫法，寫個`ul > li`用`each`去撈~~
    - 第一版：考量到編輯的便利性與靈活性，直接使用Markdwon
    - 第二版：用Vue.js 2.0開發，一個online markdown editor，儲存要在編輯頁面按右下角的儲存鍵
    - 第三版：markdown editor 即時編輯、即時儲存、即時顯示

>如何做SideBar，可以參考
>1. [How To Create a Side Navigation Menu](http://www.w3schools.com/howto/howto_js_sidenav.asp)
>2. [Create a Sidebar Menu - YouTube](https://www.youtube.com/watch?v=zPh0RbYiYGg)

#### 榮譽榜
- 必須是一篇又一篇文章，像是佈告欄那樣
- **需要開個CRUD，需要WYSIWYG editor**
- 實驗室成員就擁有 **新增、編輯** 權限

#### 研究成果
- 實驗室成員的歷年研究題目、論文
- UI：第1版
  - 一篇文章，按發表年份由上往下排。
  - 會需要SQL
- UI：第2版
  - 進入頁面：三個區塊
    - 由左而右：博士生、研究生、專題生
    - 點進去後，可以看到不同學位的學生，歷年的論文與專題題目
- UI：第3版
  - 每個主題右邊都會有一個 **隱藏式SideBar**，SideBar裡面有「三個不同學位學生的超連結」
    - 博班生
    - 研究生
    - 專題生
- ~~需要開個CRUD~~，用一個table呈現
  - 研究生與博士生可以 **直接撈實驗室成員發表的論文與專題題目**

>用Vue.js寫markdown editor可參考[Markdown Editor - vue.js](https://vuejs.org/examples/)
>
>WYSIWYG editor可參考[Rails 中如何集成帶圖片上傳功能的simditor 編輯器· Ruby China](https://ruby-china.org/topics/28467?hmsr=toutiao.io&utm_medium=toutiao.io&utm_source=toutiao.io)



### 細節

#### 實驗室簡介
- 放在首頁
- 寫死，沒有CRUD
- **多媒體計算與通訊研究室** 這串字要提到
- 地點要提到
- 50字以內
- 最下面是 **「研究成果」的連結**

#### 學習資源
- **需要開個CRUD**
- 首頁固定三篇文章，前兩篇寫死，不開放編修、刪除。第三篇開放編修權限。
  1. [Inner Game Plus 學習方法論](http://nickwarm.logdown.com/posts/966527)
    - 文章需要update，加入「生產力」、「隨時記錄好點子」、「用hackMD協作筆記」
  2. 以前教書的講義pdf檔
  3. 各種學習資源  
    - 類型：文章教學、youtube影片、MOOC  (我這邊會先搜集一部分資源)
    - 領域：
      - 機率
      - 訊號與系統
      - 影像處理、電腦視覺
    - 開放研究生、專題生 **新增、編輯資料** 的權限
    - 總管理員才有 **刪除資料** 的權限

#### 實驗室公告
- 課程消息
- 召募專題生公告
  - 撰寫模式：細節，有圖片輔助說明更佳。 **需要開個CRUD，需要WYSIWYG editor**

> 教授跟實驗室成員是不同的兩張database table
>
>實驗室成員可以透過 **臉書帳號**、**google帳號** 來登入

#### 實驗室成員UI設計
- UI：第1版
  - 五篇文章：教授、博士生、研究生、專題生
  - 教授與實驗室成員的schema要分開
- UI：第2版
  - 分成 **畢業生** 與 **在校學生**
  - 用卡牌的圖片顯示
- UI：第3版
  - 進入頁面有兩篇文章：教授、實驗室成員
  - 教授「發表的論文、技術報告、個人著作」，於教授的個人頁面用 **隱藏式SideBar** 呈現
  - 實驗室成員，用 **隱藏式SideBar** 呈現「博士生、研究生、專題生」

>卡牌顯示可以參考
>- [Sematic ui的設計](http://semantic-ui.com/views/card.html)
>- [Sematic ui的設計](https://github.com/Semantic-Org/Semantic-UI/blob/master/src/definitions/views/card.less)
>- [railsfun 2.5day購物車的商品圖片顯示](https://github.com/NickWarm/jccart/blob/master/wiki/Note_7_AJAX.md)


>看台大資工的網站，看到幾個不錯的
>[Intelligent Agents Lab](https://iagentntu.github.io/)
>[Vivian Website](https://www.csie.ntu.edu.tw/~yvchen/index-ch)
>[MiuLab](https://www.csie.ntu.edu.tw/~yvchen/miulab/index.html)

#### 實驗室成員資料
- 教授
  - 簡單的自我介紹
    - 上課與在辦公室的時間表
  - 信箱
  - 實驗室分機
  - 研究主題
  - 發表的論文/技術報告/個人著作
    - 第一版：在教授介紹的頁面，直接給三篇文章的連結，分別是「發表的論文、技術報告、個人著作」
      - 類似首頁的那種UI：左邊介紹，右邊h2著作然後下面依序三篇獨立文章：發表的論文、技術報告、個人著作
      - 三篇獨立文章
        - 需要開一個 **CRUD**
        - **使用Markdown**，這樣比較方便編輯
    - 第二版：右邊需要一個 **隱藏式SideBar**
- 博士生
- 研究生
- 專題生
  - 細節
    1. 學籍
    2. 姓名
    3. 專長
    4. 研究領域
    5. 發表的論文
    6. 個人部落格
- 撰寫模式：精簡、講重點。
  - **需要開個CRUD**
  - ~~傳統rails的寫法，用一個table呈現~~
  - 第一版
      1. 照片
      2. 姓名
      3. 學籍 (入學學年)
      4. 發表的論文/專題題目
         - 論文篇數不只一篇，需要使用 **巢狀表單**
      5. 個人介紹，**這個部分用Markdown呈現**
         - 專長
         - 研究領域
         - 個人部落格
  - 第二版
      1. 照片
      2. 姓名
      3. 學籍 (入學學年)
      4. 發表的論文/專題題目
        - **透過Vue.js 2.0來AJAX**，使得更新的論文 **即時顯示在畫面上**
      5. 個人介紹 ( **用Vue.js 2.0，一個online markdown editor** )
         - 專長
         - 研究領域
         - 個人部落格
  - 第三版：即時更新、即時儲存、即時顯示的markdwon online editor

>

>Nested Forms可以參考以下
>- [rails nested forms - YouTube](https://www.youtube.com/results?search_query=rails+nested+forms)
>- [Nested form | Rails 102](https://rocodev.gitbooks.io/rails-102/content/chapter1-mvc/v/nested-form.html)
>- [Rails Nested Model forms — Ruby on Rails 指南](http://rails.ruby.tw/nested_model_forms.html)
>- [Rails nested form 的問題 - 求救 - Rails Fun!! Ruby & Rails 中文論壇](http://railsfun.tw/t/rails-nested-form/685)
>- [Ruby on Rails 如何實作可動態新增欄位的表單(dynamic nested form) – 先求有再求好](https://krammer0.wordpress.com/2016/05/04/ror-%E5%8B%95%E6%85%8B%E6%96%B0%E5%A2%9E%E6%AC%84%E4%BD%8D%E7%9A%84%E8%A1%A8%E5%96%AE/)
>- [simple_form nested attribute 巢狀表格 Rails 要注意的點 - 丹哥的技術培養皿](http://tech.guojheng-lin.com/posts/2014/07/01/simple-form-nested-nested-table-attribute-rails-to-note-the-points/)


## footbar
© 2016 MuCat Lab
Website is made by <a href="GitHub"> **NickWarm** </a> , UI design is adapted by <a> **Mackenzie Child** </a>


# 後台

1. **刪除資料的權限** 只開放給總管理員，避免實驗室成員誤刪資料
2. 後台只開放給總管理員

>像railsfun day2.5那樣的後台寫法，讓別人猜不出你的後台網址

後台登入頁面
- 信箱
- 密碼
- 臉書、google帳號登入

## 使用權限
總管理員：我與老師
- 新增、編輯、**刪除**

實驗室成員
- 新增、編輯


## 總管理員
- 學習資源
- 實驗室公告
- 實驗室成員資料
- 榮譽榜
