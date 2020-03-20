//
//  ZBWPhotoManager.m
//  ZBWAlbum
//
//  Created by 张博文 on 2020/3/18.
//  Copyright © 2020 com.bw. All rights reserved.
//


#import <UIKit/UIKit.h>

@class ZBWAlbumModel;

@interface ZBWAlbumView : UIView

/**
 显示相册列表
 
 @param assetCollectionList 相册对象列表
 @param navigationBarMaxY navigationBarMaxY的最大值
 @param complete 返回结果
 */
+(void)showAlbumView:(NSMutableArray<ZBWAlbumModel *> *)assetCollectionList navigationBarMaxY:(CGFloat)navigationBarMaxY complete:(void(^)(ZBWAlbumModel *albumModel))complete;

@end
