# ZBWAlbum
仿微信、小红书上传图片功能

![image](https://github.com/izhangbowen/ZBWAlbum/blob/master/IMG_7406.PNG)

```
#import "ZBWPhotosManager.h"
// ZBWPhotosManager的类方法：传入最大可以选择的图片的数量
[ZBWPhotosManager showPhotosManager:self withMaxImageCount:10 withAlbumArray:^(NSMutableArray<ZBWPhotoModel *> * _Nonnull albumArray) {
        NSLog(@"%@",albumArray);
        self.array = albumArray;
        [self.albumCollectionView reloadData];
        
    }];
```
