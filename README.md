# ZBWAlbum
仿微信、小红书上传图片功能

![image](https://github.com/izhangbowen/ZBWAlbum/blob/master/IMG_7406.PNG)



## 一、Installation安装
#### CocoaPods
#### Carthage
#### 手动安装
```
将Album文件夹拖拽到项目中，导入头文件：#import "ZBWPhotosManager.h"
```

## 二、Example例子
```
#import "ZBWPhotosManager.h"
// ZBWPhotosManager的类方法：传入最大可以选择的图片的数量
[ZBWPhotosManager showPhotosManager:self withMaxImageCount:10 withAlbumArray:^(NSMutableArray<ZBWPhotoModel *> * _Nonnull albumArray) {
        NSLog(@"%@",albumArray);
    }];
```

## 三、Release Notes 更新
1.0.1 修复bug-滚动崩溃的问题 & ZBWAlbumViewController.m强引用的问题
1.0.0 仿照微信图片上传的基础功能
