# MuWeb UserStory_v2

以下順序都是由左而右。

網站名稱
- 主標題：**Mu Lab**   
- 副標題：多媒體計算與通訊研究室  

# 前台

## NavBar
極左
- 回到首頁

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
由左而右：學習資源、榮譽榜、研究成果

- 學習資源
  - 首頁固定三篇文章，前兩篇寫死，不開放編修、刪除。第三篇開放編修權限。
    - [Inner Game Plus 學習方法論](http://nickwarm.logdown.com/posts/966527)
    - 以前教書的講義pdf檔
    - 各種學習資源  
      - 右邊需要一個 **SideBar**
      - **需要開個CRUD**
      - 第一版：開一個CRUD，傳統rails的寫法，寫個`ul > li`用`each`去撈
      - 第二版：用Vue.js 2.0開發，一個online markdown editor，儲存要在編輯頁面按右下角的儲存鍵
      - 第三版：markdown editor 即時編輯、即時儲存、即時顯示
- 榮譽榜
  - **需要開個CRUD，需要WYSIWYG editor**
  - 實驗室成員就擁有 **新增、編輯** 權限
- 研究成果
  - 實驗室成員的歷年研究題目、論文
    - 博班生
    - 研究生
    - 專題生
  - 右邊需要一個 **SideBar**
  - ~~需要開個CRUD~~，用一個table呈現，**直接撈實驗室成員發表的論文**

>用Vue.js寫markdown editor可參考[Markdown Editor - vue.js](https://vuejs.org/examples/)

>WYSIWYG editor可參考[Rails 中如何集成帶圖片上傳功能的simditor 編輯器· Ruby China](https://ruby-china.org/topics/28467?hmsr=toutiao.io&utm_medium=toutiao.io&utm_source=toutiao.io)

## 網站內容

### 概觀
- 實驗室簡介      
- 學習資源       
- 實驗室公告      
- 實驗室成員資料   
- 榮譽榜          
- 研究成果

### 架構
- 實驗室簡介
  - 寫死
- 學習資源
  - 固定三篇文章，前兩篇寫死，第三篇CRUD
- 實驗室公告
  - CRUD
- 實驗室成員資料   
  - CRUD
- 榮譽榜
  - CRUD
- 研究成果
 - 直接撈實驗室成員發表的論文

### 第一版
- 實驗室簡介
- 學習資源
  - CRUD，傳統rails的寫法，寫個`ul > li`用`each`去撈
- 實驗室公告
  - CRUD，WYSIWYG editor
- 實驗室成員資料   
  - CRUD，傳統rails的寫法，用一個table呈現
- 榮譽榜
  - CRUD，WYSIWYG editor
- 研究成果

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


### 細節
- 實驗室簡介
- 學習資源
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
- 實驗室公告
  - 課程消息
  - 召募專題生公告
    - 撰寫模式：細節，有圖片輔助說明更佳。 **需要開個CRUD，需要WYSIWYG editor**

> 教授跟實驗室成員是不同的兩張database table

- 實驗室成員資料
  - 教授
    - 簡單的自我介紹
    - 信箱
    - 實驗室分機
    - 研究主題
    - 發表的論文/技術報告/個人著作
      - 右邊需要一個 **SideBar**
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
    - 第一版：傳統rails的寫法，用一個table呈現
      1. 學籍
      2. 姓名
      3. 專長
      4. 研究領域
      5. 發表的論文
      6. 個人部落格
    - 第二版：用Vue.js 2.0，一個online markdown editor
      1. 學籍
      2. 姓名
      3. 個人介紹
        - 專長
        - 研究領域
        - 發表的論文
        - 個人部落格
    - 第三版：即時更新、即時儲存、即時顯示的markdwon online editor


## footbar
  - 製作於西元幾年
  - 網站製作者：我的聯絡資訊


# 後台

1. **刪除資料的權限** 只開放給總管理員，避免實驗室成員誤刪資料
2. 後台只開放給總管理員

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
