### Snow is a weather iOS app

```
Author: Jin Jay
```

use TabViewController  
For the course *Embedded Developing*

Until now, finished the basic data mining and show data.  

---

now I have already fulfilment the basic functions.But there is something wrong with *"进程同步"*, 会造成刷新天气显示出现问题，具体表现为 需要两次点击刷新按钮才能更新显示天气数据。

> 解决方法：使用代理delegate或者使用信号，在子进程完成自己的任务后触发父进程响应的处理事件。

20140508
