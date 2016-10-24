# 職涯策略

以 **實驗室網站：Mu Lab** 當作品去投履歷

# Step.1：臨摹範例
先寫一次[How to create a blog & portfolio application - YouTube](https://www.youtube.com/playlist?list=PL23ZvcdS3XPK9Y4DRU-BiJtiY5L_QhUUq)的rails部落格
- 以他的UI設計為主，然後稍作修改

## 實驗室網站icons
辜狗關鍵字[free icon cat](http://www.flaticon.com/free-icons/cat_1667)

目前挑了四個，請見 **icons** 資料夾

# Step.0.5 MuCat Lab UI 實作

## 架構
- 實驗室簡介
- 學習資源
  - 第一版 (五篇獨立文章，文章依序)
    - 學習方法論
    - 教書時的pdf檔
    - 影像處理
    - 訊號與系統
    - 機率與統計
  - CRUD，考量到編輯的便利性與靈活性，直接使用Markdwon
- 實驗室公告
  - CRUD，WYSIWYG editor
- 實驗室成員資料   
  - CRUD，傳統rails的寫法，用一個table呈現
    1. 學籍
    2. 姓名
    3. 專長
    4. 研究領域
    5. 發表的論文
    6. 個人部落格
- 榮譽榜
  - CRUD，WYSIWYG editor
- 研究成果
  - 第一版
    - 進入頁面：三個區塊
      - 由左而右：博士生、研究生、專題生
      - 點進去後，可以看到不同學位的學生，歷年的論文與專題題目

一個model
- 擁有一張資料表定義
- 依照 **類型** 從資料庫中撈出不同相關的資料
  - 用 **SQL** 語法撈出不同類型資料
  - 例如：研究成果用 **不同學位** 去撈，撈出實驗室成員資料中的「學籍、姓名、發表的論文」

學習資源一組model、controller



# Step.2：實作Mu Lab第一版

## deadline
16/10/25

## 架構
- 實驗室簡介
- 學習資源
  - CRUD，傳統rails的寫法，寫個`ul > li`用`form_for`去撈
- 實驗室公告
  - CRUD，WYSIWYG editor
- 實驗室成員資料   
  - CRUD，傳統rails的寫法，用一個table呈現
- 榮譽榜
  - CRUD，WYSIWYG editor
- 研究成果

## 技術重點
1. 以Mackenzie Child的UI設計為主，然後稍作修改
2. WYSIWYG editor
3. 用臉書、google帳號來登入的功能

# Step.3：實作Mu Lab第二版

## 架構
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

>1. 用Vue.js 2.0開發，一個online markdown editor，儲存要在編輯頁面按右下角的儲存鍵

>2. 把前端改為RWD

## deadline
16/10/31

# Step.4：開始投履歷

## 履歷
投履歷時，用LandingPage取代傳統履歷

## 面試
面試時，用Onboarding增加offer get的機會


# Step.5：實作創業MOOC prototype


# Step.6：實作Mu Lab第三版
