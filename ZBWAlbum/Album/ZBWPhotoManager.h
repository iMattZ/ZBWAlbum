//
//  ZBWPhotoManager.h
//  ZBWAlbum
//
//  Created by 张博文 on 2020/3/18.
//  Copyright © 2020 com.bw. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ZBWPhotoModel;
typedef void(^ZBWPhotoMangerChoiceCountChange)(NSInteger choiceCount);
NS_ASSUME_NONNULL_BEGIN

@interface ZBWPhotoManager : NSObject
/// 可选的的最大数量
@property (nonatomic, assign) NSInteger maxCount;
/// 已选数量
@property (nonatomic, assign) NSInteger choiceCount;
/// 已选图片
@property (nonatomic, strong) NSMutableArray<ZBWPhotoModel *> *photoModelList;
/// 选择图片变化
@property (nonatomic, copy) ZBWPhotoMangerChoiceCountChange choiceCountChange;

/**
 单例
 
 @return 返回对象
 */
+(ZBWPhotoManager*)standardPhotoManger;
@end

NS_ASSUME_NONNULL_END
