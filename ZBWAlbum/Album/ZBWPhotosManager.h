//
//  ZBWPhotoManager.m
//  ZBWAlbum
//
//  Created by 张博文 on 2020/3/18.
//  Copyright © 2020 com.bw. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "ZBWPhotoModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface ZBWPhotosManager : NSObject


/// 显示相册
/// @param viewController 跳转的控制器
/// @param maxCount 最大选择数量
/// @param albumArray 返回的图片数组
+ (void)showPhotosManager:(UIViewController*)viewController withMaxImageCount:(NSInteger)maxCount withAlbumArray:(void(^)(NSMutableArray <ZBWPhotoModel*>* albumArray))albumArray;
@end

NS_ASSUME_NONNULL_END
