# TJStatusBarNotification
based on JDStatusBarNotification.

![image](https://github.com/wangpt/TJStatusBarNotification/blob/master/TJStatusBarNotification/Sources/play.gif)
##请先安装CocoaPods
安装成功以后使用命令安装JDStatusBarNotification
```
pod install --verbose --no-repo-update
```
##使用说明
###
```objc
//loading
    [TJStatusBarClient showStatusBarQueryStr:@"加载中..."];
//success tip
    [TJStatusBarClient showStatusBarSuccessStr:@"加载成功"];
//error tip
    [TJStatusBarClient showStatusBarErrorStr:@"加载失败"];
//warn tip
    [TJStatusBarClient showStatusBarWarnStr:@"参数有误"];
//progress
    [TJStatusBarClient showStatusBarProgress:self.progress];

```
