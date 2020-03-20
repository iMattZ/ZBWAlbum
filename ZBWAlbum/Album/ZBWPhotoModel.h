//
//  ZBWPhotoModel.h
//  ZBWAlbum
//
//  Created by 张博文 on 2020/3/18.
//  Copyright © 2020 com.bw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Photos/Photos.h>
NS_ASSUME_NONNULL_BEGIN
typedef void(^ZBWPhotoModelAction)(void);
@interface ZBWPhotoModel : NSObject
/// 相片
@property (nonatomic, strong) PHAsset *asset;
/// 高清图
@property (nonatomic, strong) UIImage *highDefinitionImage;
/// 获取图片成功事件
@property (nonatomic, copy) ZBWPhotoModelAction getPictureAction;


/// 下标
@property (nonatomic, assign) NSInteger row;
/// 所属分组
@property (nonatomic, copy) NSString* beLongTitle;
@end

NS_ASSUME_NONNULL_END
