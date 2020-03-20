//
//  ZBWAlbumViewController.h
//  ZBWAlbum
//
//  Created by 张博文 on 2020/3/18.
//  Copyright © 2020 com.bw. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ZBWAlbumViewControllerConfirmAction)(void);
NS_ASSUME_NONNULL_BEGIN

@interface ZBWAlbumViewController : UIViewController

/// 确定事件
@property (nonatomic, copy) ZBWAlbumViewControllerConfirmAction confirmAction;
@end

NS_ASSUME_NONNULL_END
