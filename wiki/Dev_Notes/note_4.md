# 學習資源

學習資源的表單設計，除了原本[MuCat_v1.md](../MuCat_v1/MuCat_v1.md)的
- ~~`author:string title:string content:text other_can_edit:boolean`~~
- 改成：`author:string title:string content:text is_editable:boolean`

後來參考
- [mackenziechild GitHub - blog_course_demo/db/migrate/20150509171512_create_projects.rb](https://github.com/mackenziechild/blog_course_demo/blob/master/db/migrate/20150509171512_create_projects.rb)
- [mackenziechild GitHub - blog_course_demo/app/views/projects/show.html.erb](https://github.com/mackenziechild/blog_course_demo/blob/master/app/views/projects/show.html.erb)

應該加個`link:string`才對，這樣才能連到外部文章，這樣也比較符合我的需求


### create_learning_note migration





## 實作



# paperclip

用來上傳實驗室成員的個人照片

# 設定controller

# Facebook login system
