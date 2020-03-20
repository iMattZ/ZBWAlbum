//
//  ZBWPhotoManager.m
//  ZBWAlbum
//
//  Created by 张博文 on 2020/3/18.
//  Copyright © 2020 com.bw. All rights reserved.
//


#import <UIKit/UIKit.h>

@class ZBWAlbumModel;

typedef void(^ZBWAlbumTableViewSelectAction)(ZBWAlbumModel *albumModel);

@interface ZBWAlbumTableView : UITableView

/// 相册数组
@property (nonatomic, strong) NSMutableArray<ZBWAlbumModel *> *assetCollectionList;
/// 选择的相册
@property (nonatomic, copy) ZBWAlbumTableViewSelectAction selectAction;

@end
