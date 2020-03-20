//
//  ZBWPhotoManager.m
//  ZBWAlbum
//
//  Created by 张博文 on 2020/3/18.
//  Copyright © 2020 com.bw. All rights reserved.
//


#import "ZBWAlbumCollectionViewCell.h"
#import "ZBWPhotoManager.h"
#import "UIColor+Custom.h"

#define kScreenWidth  [[UIScreen mainScreen] bounds].size.width
#define kScreenHeight [[UIScreen mainScreen] bounds].size.height

@interface ZBWAlbumCollectionViewCell()
///// 相片
//@property (nonatomic, strong) UIImageView *photoImageView;
///// 选中按钮
//@property (nonatomic, strong) UIButton *selectButton;
///// 半透明遮罩
//@property (nonatomic, strong) UIView *translucentView;

@end

@implementation ZBWAlbumCollectionViewCell
-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self photoImageView];
        [self translucentView];
        [self selectButton];
    }
    
    return self;
}

#pragma mark - Set方法
-(void)setIsSelect:(BOOL)isSelect {
    _isSelect = isSelect;
    
    self.translucentView.hidden = !isSelect;
//    [self.selectButton setBackgroundImage:isSelect ? [UIImage imageNamed: @"selectImage_select"] : nil forState:UIControlStateNormal];
    [self.selectButton setBackgroundColor:isSelect?[UIColor colorWithHexString:@"#00C359"]:[UIColor clearColor]];
    self.selectButton.layer.borderColor = isSelect?[UIColor colorWithHexString:@"#00C359"].CGColor:[UIColor whiteColor].CGColor;
    
//    NSLog(@"count = %lu",(unsigned long)[ZBWPhotoManager standardPhotoManger].photoModelList.count);
    if ([ZBWPhotoManager standardPhotoManger].maxCount == [ZBWPhotoManager standardPhotoManger].photoModelList.count) {
        self.translucentView.hidden = NO;
        if (isSelect) {
            _translucentView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
        } else {
            _translucentView.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.4];
        }
    } else {
        _translucentView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
    }
     
}

#pragma mark - 加载图片
-(void)loadImage:(NSIndexPath *)indexPath {
    CGFloat imageWidth = (kScreenWidth - 20.f) / 5.5;
    self.photoImageView.image = nil;
    PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
    // 同步获得图片, 只会返回1张图片
    options.synchronous = NO;
    
    [[PHCachingImageManager defaultManager] requestImageForAsset:self.asset targetSize:CGSizeMake(imageWidth * [UIScreen mainScreen].scale, imageWidth * [UIScreen mainScreen].scale) contentMode:PHImageContentModeDefault options:options resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        if (self.row == indexPath.row) {
            self.photoImageView.image = result;
        }
    }];
}


#pragma mark - 点击事件
-(void)selectPhoto:(UIButton *)button {
    if (self.selectPhotoAction) {
        self.selectPhotoAction(self.asset);
    }
}

#pragma mark - Get方法
-(UIImageView *)photoImageView {
    if (!_photoImageView) {
        _photoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, (kScreenWidth - 20.f) / rowCount, (kScreenWidth - 20.f) / rowCount)];
        _photoImageView.contentMode = UIViewContentModeScaleAspectFill;
        _photoImageView.layer.masksToBounds = YES;
        
        [self.contentView addSubview:_photoImageView];
    }
    
    return _photoImageView;
}

-(ZBWButton *)selectButton {
    if (!_selectButton) {
        _selectButton = [ZBWButton buttonWithType:UIButtonTypeCustom];
        _selectButton.layer.borderColor = [UIColor whiteColor].CGColor;
        _selectButton.layer.borderWidth = 1.f;
        _selectButton.layer.cornerRadius = 12.5f;
        _selectButton.layer.masksToBounds = YES;
        [_selectButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_selectButton addTarget:self action:@selector(selectPhoto:) forControlEvents:UIControlEventTouchUpInside];
        //上下左右的各个方向的Insets量
        [_selectButton setHitTestEdgeInsets:UIEdgeInsetsMake(-10, -10, -10, -10)];
        
        [self.contentView addSubview:_selectButton];
        _selectButton.frame = CGRectMake((kScreenWidth - 20.f) / rowCount - 29, 3, 25, 25);
    }
    
    return _selectButton;
}

-(UIView *)translucentView {
    if (!_translucentView) {
        _translucentView = [[UIView alloc] init];
        _translucentView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
        
        [self.contentView addSubview:_translucentView];
        _translucentView.frame = CGRectMake(0, 0, (kScreenWidth - 20.f) / rowCount, (kScreenWidth - 20.f) / rowCount);
        _translucentView.hidden = YES;
    }
    
    return _translucentView;
}
@end
