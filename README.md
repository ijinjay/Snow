### Snow is a weather iOS app

```
Author: Jin Jay
Current Version: V2.0
```

use TabViewController  
For the course *Embedded Developing*

Until now, finished the basic functions.

Use the third libraray
> FrameAccessor :For draw Bar
> MkFoundationKit :For draw Bar
> MBProgressHUD :For show simple tips 
> Source filefolder is used for drawwing bar


---

now I have already fulfilment the basic functions.But there is something wrong with *"进程同步"*, 会造成刷新天气显示出现问题，具体表现为 需要两次点击刷新按钮才能更新显示天气数据。

> 解决方法：使用代理delegate或者使用信号，在子进程完成自己的任务后触发父进程响应的处理事件。

20140508

---

20140516 完成了城市搜索，改进了选择标记。
***TODO:*** 优化城市切换,优化天气界面的按钮点击事件。

---

20140525 完成了城市视图“完成”按钮的视图切换和数据更新操作。  
***TODO:*** 数据库查询中文乱码问题

---

20140526 修正了sqlite查询功能，中文乱码问题已解决

201405262020 完成了数据库查询视图折线图的绘制，程序版本号V2.0，可提交

---

20140527 完成了软件部分文档，完善了代码风格一致性  
***TODO:*** Hub的使用，使得软件具有良好的提示效果。

---

20140531 城市天气新API: m.weather.com/atad/城市编号.html  
城市实时天气API: www.weather.com/data/cityinfo/城市编号.html

***TODO*** 修改城市天气更新方式。
