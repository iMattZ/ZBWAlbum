//
//  ZBWAlbumModel.h
//  ZBWAlbum
//
//  Created by 张博文 on 2020/3/19.
//  Copyright © 2020 com.bw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Photos/Photos.h>


NS_ASSUME_NONNULL_BEGIN

@interface ZBWAlbumModel : NSObject

/// 相册
@property (nonatomic, strong) PHAssetCollection *collection;
/// 第一个相片
@property (nonatomic, strong) PHAsset *firstAsset;
/// 第一个相片
@property (nonatomic, strong) PHFetchResult<PHAsset *> *assets;
/// 相册名
@property (nonatomic, copy) NSString *collectionTitle;
/// 总数
@property (nonatomic, copy) NSString *collectionNumber;
/// 选中的图片
@property (nonatomic, strong) NSMutableArray<NSNumber *> *selectRows;


/// Sort photos ascending by modificationDate，Default is YES
/// 对照片排序，按修改时间升序，默认是YES。如果设置为NO,最新的照片会显示在最前面，内部的拍照按钮会排在第一个
@property (nonatomic, assign) BOOL sortAscendingByModificationDate;

@end

NS_ASSUME_NONNULL_END
