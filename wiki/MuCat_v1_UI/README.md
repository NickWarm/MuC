# MuCat_v1 UI

讀到[Google 花了五年 Noto 字型終於對應所有Unicode編碼並支援800種語言 | 癮科技](https://www.cool3c.com/article/112452)這篇，所以實驗室網站的中文字就使用Google Noto fonts，裡面有使用「思源黑體」

最後採用這篇教學，來取得[Noto Sans TC](https://fonts.google.com/earlyaccess#Noto+Sans+TC)
- [Google Fonts 推出「思源黑體」中文網頁字型，改善網頁文字顯示效果](https://free.com.tw/google-fonts-noto-sans-cjk-webfont/)

我後來是直接在`application.scss`來引用思源黑體
```
@import url(http://fonts.googleapis.com/earlyaccess/notosanstc.css);
```

榮譽榜的英文有兩個選擇
- [Honors Student](https://en.wikipedia.org/wiki/Honors_student)
- [Honor Roll](http://dictionary.cambridge.org/zht/%E8%A9%9E%E5%85%B8/%E8%8B%B1%E8%AA%9E/honor-roll)

> 老師偏好使用 **Honor Roll**


博士 doctor

碩士 master

大學生 College

圖片大小不一樣，這點不用擔心，paperclip可以設定上傳的圖片大小，請參考[jccart/wiki/Note_3_model.md](https://github.com/NickWarm/jccart/blob/master/wiki/Note_3_model.md)

# ToDo
- 點選不同頁面時，瀏覽器分頁上顯示不同title，像是[Mackenzie Child ](https://mackenziechild.me/)
  - 以前有看過怎麼做，回去看影片就會了
- 固定View More的位置，讓他不會浮動
  - 完全不懂，晚一點再實作

# 完成
- 在首頁加入'View More'的CSS設計
- 實驗室成員編輯頁面
- 實驗室成員個人頁面的顯示
