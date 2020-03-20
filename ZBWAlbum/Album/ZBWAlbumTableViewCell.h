//
//  ZBWPhotoManager.m
//  ZBWAlbum
//
//  Created by 张博文 on 2020/3/18.
//  Copyright © 2020 com.bw. All rights reserved.
//


#import <UIKit/UIKit.h>

@class ZBWAlbumModel;

@interface ZBWAlbumTableViewCell : UITableViewCell

/// 相册
@property (nonatomic, strong) ZBWAlbumModel *albumModel;
/// 行数
@property (nonatomic, assign) NSInteger row;

/// 加载图片
-(void)loadImage:(NSIndexPath *)index;

@end
