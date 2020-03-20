//
//  ZBWPhotoManager.m
//  ZBWAlbum
//
//  Created by 张博文 on 2020/3/18.
//  Copyright © 2020 com.bw. All rights reserved.
//


#import <UIKit/UIKit.h>
#import <Photos/Photos.h>
#import "ZBWButton.h"
NS_ASSUME_NONNULL_BEGIN

#define rowCount 4.f


typedef void(^ZBWAlbumCollectionViewCellAction)(PHAsset *asset);

@interface ZBWAlbumCollectionViewCell : UICollectionViewCell

/// 行数
@property (nonatomic, assign) NSInteger row;
/// 相片
@property (nonatomic, strong) PHAsset *asset;
/// 选中事件
@property (nonatomic, copy) ZBWAlbumCollectionViewCellAction selectPhotoAction;
/// 是否被选中
@property (nonatomic, assign) BOOL isSelect;

#pragma mark - 加载图片
-(void)loadImage:(NSIndexPath *)indexPath;



/// 相片
@property (nonatomic, strong) UIImageView *photoImageView;
/// 选中按钮
@property (nonatomic, strong) ZBWButton *selectButton;
/// 半透明遮罩
@property (nonatomic, strong) UIView *translucentView;
@end

NS_ASSUME_NONNULL_END
