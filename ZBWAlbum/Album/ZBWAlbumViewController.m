//
//  ZBWAlbumViewController.m
//  ZBWAlbum
//
//  Created by 张博文 on 2020/3/18.
//  Copyright © 2020 com.bw. All rights reserved.
//

#import "ZBWAlbumViewController.h"
#import "ZBWAlbumCollectionViewCell.h"
#import "ZBWAlbumModel.h"
#import "ZBWPhotoModel.h"
#import "ZBWPhotoManager.h"
#import "ZBWAlbumView.h"
#import "UIColor+Custom.h"
#import "ZBWButton.h"

#define kScreenWidth  [[UIScreen mainScreen] bounds].size.width
#define kScreenHeight [[UIScreen mainScreen] bounds].size.height

@interface ZBWAlbumViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
/// 显示相册按钮
@property (nonatomic, strong) UIButton *showAlbumButton;
/// 取消按钮
@property (nonatomic, strong) UIButton *cancelButton;
/// 确定按钮
@property (nonatomic, strong) UIButton *confirmButton;

/// 相册列表
@property (nonatomic, strong) UICollectionView *albumCollectionView;

/// 相册数组
@property (nonatomic, strong) NSMutableArray<ZBWAlbumModel *> *assetCollectionList;

/// 当前要显示的相册
@property (nonatomic, strong) ZBWAlbumModel *albumModel;
@end

@implementation ZBWAlbumViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 配置初始化
    [self setupViewController];
    
    
    // 配置
    [self setupConfi];
}

- (void)setupConfi {
    
    
    #define navBgColor  @"#454545"
    #define navTitleBgColor  @"#4B4B4B"
    #define navTitleTextColor [UIColor whiteColor]
    
    self.showAlbumButton.backgroundColor = [UIColor colorWithHexString:navTitleBgColor];
    self.showAlbumButton.layer.cornerRadius = 35/2.0;
    
    
    /// collectionView
    self.albumCollectionView.backgroundColor = [UIColor colorWithHexString:@"#323232"];
    
    /// nav
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithHexString:navBgColor];
    //left、right-item color【左右item的颜色】
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor],
                                                                      NSFontAttributeName : [UIFont systemFontOfSize:17]}];
    

//#define
    
    
}

// 配置控制器
- (void)setupViewController {
    
    // 配置返回按钮
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:self.cancelButton];
    self.navigationItem.leftBarButtonItem = backItem;
    
    /// 配置标题按钮
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 180, 45)];
    self.navigationItem.titleView = titleView;
    self.showAlbumButton.center = titleView.center;
    [titleView addSubview:self.showAlbumButton];
    
    
    // 右侧的确认按钮
    UIBarButtonItem *confirmItem = [[UIBarButtonItem alloc] initWithCustomView:self.confirmButton];
    self.navigationItem.rightBarButtonItem = confirmItem;
    
    
    /// 获得所有的自定义相簿
    [self getThumbnailImages];
}


/// 获取所有的自定义相册
- (void)getThumbnailImages {
    self.assetCollectionList = [NSMutableArray array];
    
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        
        // 获得个人收藏相册
        PHFetchResult<PHAssetCollection *> *favoritesCollection = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeSmartAlbumFavorites options:nil];
        // 获得相机胶卷
        PHFetchResult<PHAssetCollection *> *assetCollections = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeSmartAlbumUserLibrary options:nil];
        // 获得全部相片
        PHFetchResult<PHAssetCollection *> *cameraRolls = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeSmartAlbumUserLibrary options:nil];
        
        
        // 我的照片流 1.6.10重新加入..
        PHFetchResult *myPhotoStreamAlbum = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumMyPhotoStream options:nil];
        PHFetchResult *smartAlbums = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
        PHFetchResult *topLevelUserCollections = [PHCollectionList fetchTopLevelUserCollectionsWithOptions:nil];
        PHFetchResult *syncedAlbums = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumSyncedAlbum options:nil];
        PHFetchResult *sharedAlbums = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumCloudShared options:nil];
        
        
        for (PHAssetCollection *collection in cameraRolls) {
            ZBWAlbumModel *model = [[ZBWAlbumModel alloc] init];
            model.collection = collection;

            if (![model.collectionNumber isEqualToString:@"0"]) {
                [weakSelf.assetCollectionList addObject:model];
            }
        }
        
        for (PHAssetCollection *collection in myPhotoStreamAlbum) {
            ZBWAlbumModel *model = [[ZBWAlbumModel alloc] init];
            model.collection = collection;

            if (![model.collectionNumber isEqualToString:@"0"]) {
                [weakSelf.assetCollectionList addObject:model];
            }
        }
        for (PHAssetCollection *collection in smartAlbums) {
            ZBWAlbumModel *model = [[ZBWAlbumModel alloc] init];
            model.collection = collection;

            if (![model.collectionNumber isEqualToString:@"0"]) {
                [weakSelf.assetCollectionList addObject:model];
            }
        }
        
        for (PHAssetCollection *collection in topLevelUserCollections) {
            ZBWAlbumModel *model = [[ZBWAlbumModel alloc] init];
            model.collection = collection;

            if (![model.collectionNumber isEqualToString:@"0"]) {
                [weakSelf.assetCollectionList addObject:model];
            }
        }
        for (PHAssetCollection *collection in syncedAlbums) {
            ZBWAlbumModel *model = [[ZBWAlbumModel alloc] init];
            model.collection = collection;

            if (![model.collectionNumber isEqualToString:@"0"]) {
                [weakSelf.assetCollectionList addObject:model];
            }
        }
        
        for (PHAssetCollection *collection in sharedAlbums) {
            ZBWAlbumModel *model = [[ZBWAlbumModel alloc] init];
            model.collection = collection;

            if (![model.collectionNumber isEqualToString:@"0"]) {
                [weakSelf.assetCollectionList addObject:model];
            }
        }
        
        
        /*
        
        // 添加全部相册内容
        [cameraRolls enumerateObjectsWithOptions:NSEnumerationConcurrent usingBlock:^(PHAssetCollection * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            ZBWAlbumModel *model = [[ZBWAlbumModel alloc] init];
            model.collection = obj;
            
            if (![model.collectionNumber isEqualToString:@"0"]) {
                [weakSelf.assetCollectionList addObject:model];
            }
        }];
        
        [favoritesCollection enumerateObjectsWithOptions:NSEnumerationConcurrent usingBlock:^(PHAssetCollection * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            ZBWAlbumModel *model = [[ZBWAlbumModel alloc] init];
            model.collection = obj;
            
            if (![model.collectionNumber isEqualToString:@"0"]) {
                [weakSelf.assetCollectionList addObject:model];
            }
        }];
        
        [assetCollections enumerateObjectsWithOptions:NSEnumerationConcurrent usingBlock:^(PHAssetCollection * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            ZBWAlbumModel *model = [[ZBWAlbumModel alloc] init];
            model.collection = obj;
            if (![model.collectionNumber isEqualToString:@"0"]) {
                [weakSelf.assetCollectionList addObject:model];
            }
        }];
        
        */
        // 添加全部相册内容
//        for (PHAssetCollection *collection in cameraRolls) {
//            ZBWAlbumModel *model = [[ZBWAlbumModel alloc] init];
//            model.collection = collection;
//
//            if (![model.collectionNumber isEqualToString:@"0"]) {
//                [weakSelf.assetCollectionList addObject:model];
//            }
//        }
        
//        for (PHAssetCollection *collection in favoritesCollection) {
//            ZBWAlbumModel *model = [[ZBWAlbumModel alloc] init];
//            model.collection = collection;
//
//            if (![model.collectionNumber isEqualToString:@"0"]) {
//                [weakSelf.assetCollectionList addObject:model];
//            }
//        }
        
//        for (PHAssetCollection *collection in assetCollections) {
//            ZBWAlbumModel *model = [[ZBWAlbumModel alloc] init];
//            model.collection = collection;
//
//            if (![model.collectionNumber isEqualToString:@"0"]) {
//                [weakSelf.assetCollectionList addObject:model];
//            }
//
//        }
        
            dispatch_async(dispatch_get_main_queue(), ^{
                weakSelf.albumModel = weakSelf.assetCollectionList.firstObject;
            });
    });
}


#pragma mark - Set方法
-(void)setAlbumModel:(ZBWAlbumModel *)albumModel {
    _albumModel = albumModel;
    [self.showAlbumButton setTitle:albumModel.collectionTitle forState:UIControlStateNormal];
    [self.albumCollectionView reloadData];
}




#pragma mark - <UICollectionViewDataSource>
static NSString *albumCollectionViewCell = @"ZBWAlbumCollectionViewCell";
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.albumModel.assets.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ZBWAlbumCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:albumCollectionViewCell forIndexPath:indexPath];
    cell.row = indexPath.row;
    cell.asset = self.albumModel.assets[indexPath.row];
    [cell loadImage:indexPath];
    cell.isSelect = [self.albumModel.selectRows containsObject:@(indexPath.row)];
    
    [cell.selectButton setTitle:@"" forState:UIControlStateNormal];
    for (int i = 0; i < [ZBWPhotoManager standardPhotoManger].photoModelList.count; i++) {
        ZBWPhotoModel *model = [ZBWPhotoManager standardPhotoManger].photoModelList[i];
        if ([model.beLongTitle isEqualToString:self.albumModel.collectionTitle]) {
            if (indexPath.row == model.row) {
                cell.isSelect = YES;
                NSString *row = [NSString stringWithFormat:@"%d",i+1];
                [cell.selectButton setTitle:row forState:UIControlStateNormal];
            }
        }
    }

    
    __weak typeof(self) weakSelf = self;
    __weak typeof(cell) weakCell = cell;
    cell.selectPhotoAction = ^(PHAsset * _Nonnull asset) {
        BOOL isReloadCollectionView = NO;
        if ([weakSelf.albumModel.selectRows containsObject:@(indexPath.row)]) {
            [weakSelf.albumModel.selectRows removeObject:@(indexPath.row)];
            
            
            [ZBWPhotoManager standardPhotoManger].choiceCount--;
            
            
            for (int i = 0; i < [ZBWPhotoManager standardPhotoManger].photoModelList.count; i++) {
                ZBWPhotoModel *model = [ZBWPhotoManager standardPhotoManger].photoModelList[i];
                if ([model.beLongTitle isEqualToString:self.albumModel.collectionTitle]) {
                    if ([model.beLongTitle isEqualToString:weakSelf.albumModel.collectionTitle] && model.row == indexPath.row) {
                        [[ZBWPhotoManager standardPhotoManger].photoModelList removeObject:model];
                    }
                }
            }
                        
            
            isReloadCollectionView = [ZBWPhotoManager standardPhotoManger].choiceCount != [ZBWPhotoManager standardPhotoManger].maxCount;
        } else {
            if ([ZBWPhotoManager standardPhotoManger].maxCount == [ZBWPhotoManager standardPhotoManger].choiceCount) {
                return;
            }
            
            [weakSelf.albumModel.selectRows addObject:@(indexPath.row)];
            
            
            ZBWPhotoModel *photo = [[ZBWPhotoModel alloc]init];
            photo.beLongTitle = self.albumModel.collectionTitle;
            photo.row = indexPath.row;
            photo.asset = asset;
            [[ZBWPhotoManager standardPhotoManger].photoModelList addObject:photo];
            
            
            [ZBWPhotoManager standardPhotoManger].choiceCount++;
            isReloadCollectionView = [ZBWPhotoManager standardPhotoManger].choiceCount == [ZBWPhotoManager standardPhotoManger].maxCount;
            
            NSString *row = [NSString stringWithFormat:@"%lu",(unsigned long)[ZBWPhotoManager standardPhotoManger].photoModelList.count];
            [weakCell.selectButton setTitle:row forState:UIControlStateNormal];
        }
        
        if (isReloadCollectionView) {
            
//            if ([ZBWPhotoManager standardPhotoManger].choiceCount == [ZBWPhotoManager standardPhotoManger].maxCount) {
//                [weakSelf.albumCollectionView reloadData];
//                return;
//            }
            
            NSLog(@"1111");
            
            [weakSelf.albumCollectionView reloadData];
            
//            NSMutableArray <NSIndexPath*> *indexArray = [NSMutableArray array];
//            for (int i = 0; i < [ZBWPhotoManager standardPhotoManger].photoModelList.count; i++) {
//                ZBWPhotoModel *model = [ZBWPhotoManager standardPhotoManger].photoModelList[i];
//                NSIndexPath *indexPath = [NSIndexPath indexPathForRow:model.row inSection:0];
//                [indexArray addObject:indexPath];
//            }
//            [indexArray addObject:[NSIndexPath indexPathForRow:indexPath.row inSection:0]];
//            [weakSelf.albumCollectionView reloadItemsAtIndexPaths:indexArray];
            NSLog(@"222");
        } else {
            weakCell.isSelect = [weakSelf.albumModel.selectRows containsObject:@(indexPath.row)];
        }

    };
    
    return cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CGFloat w = (kScreenWidth - 30.f) / 4.f;
    CGFloat h = (kScreenWidth - 30.f) / 4.f;
    
//    NSLog(@"w = %.2f",w);
    return CGSizeMake(w, h);
    
//    return CGSizeMake((kScreenWidth - 20.f) / 3.f, (kScreenWidth - 20.f) / 3.f);
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(5, 5, 5, 5);
}


#pragma mark - 点击事件
-(void)showAlbum:(UIButton *)button {
    button.selected = !button.selected;
    
    [ZBWAlbumView showAlbumView:self.assetCollectionList navigationBarMaxY:CGRectGetMaxY(self.navigationController.navigationBar.frame) complete:^(ZBWAlbumModel *albumModel) {
        if (albumModel) {
            self.albumModel = albumModel;
        }
        
        button.selected = !button.selected;
    }];
}

-(void)backAction:(UIButton *)button {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)confirmAction:(UIButton *)button {
    if ([ZBWPhotoManager standardPhotoManger].choiceCount > 0) {
        button.enabled = NO;
//        NSLog(@"%@",[ZBWPhotoManager standardPhotoManger].photoModelList);
        if (self.confirmAction) {
            self.confirmAction();
        }
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}



#pragma mark - <UI创建>
- (UICollectionView *)albumCollectionView {
    if (_albumCollectionView == nil) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        flowLayout.minimumLineSpacing = 5.f;
        flowLayout.minimumInteritemSpacing = 5.f;
        
        _albumCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) collectionViewLayout:flowLayout];
        
        _albumCollectionView.delegate = self;
        _albumCollectionView.dataSource = self;
        _albumCollectionView.backgroundColor = [UIColor whiteColor];
        _albumCollectionView.scrollEnabled = YES;
        _albumCollectionView.alwaysBounceVertical = YES;
        [_albumCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] atScrollPosition:UICollectionViewScrollPositionTop animated:YES];
        
        [_albumCollectionView registerClass:[ZBWAlbumCollectionViewCell class] forCellWithReuseIdentifier:albumCollectionViewCell];
        
        [self.view addSubview:_albumCollectionView];
    }
    
    return _albumCollectionView;
}

-(UIButton *)showAlbumButton {
    if (!_showAlbumButton) {
        _showAlbumButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _showAlbumButton.frame = CGRectMake(0, 0, 120, 35);
        [_showAlbumButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_showAlbumButton setImage:[UIImage imageNamed:@"photo_select_down"] forState:UIControlStateNormal];
        [_showAlbumButton setImage:[UIImage imageNamed:@"photo_select_up"] forState:UIControlStateSelected];
        _showAlbumButton.titleLabel.font = [UIFont boldSystemFontOfSize:17];
        _showAlbumButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10.f);
        [_showAlbumButton addTarget:self action:@selector(showAlbum:) forControlEvents:UIControlEventTouchUpInside];
        
        
        
    }
    
    return _showAlbumButton;
}

-(UIButton *)cancelButton {
    if (!_cancelButton) {
        _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancelButton.frame = CGRectMake(0, 0, 50, 50);
        [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        _cancelButton.titleLabel.font = [UIFont systemFontOfSize:17];
        [_cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_cancelButton addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _cancelButton;
}

-(UIButton *)confirmButton {
    if (!_confirmButton) {
        _confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_confirmButton addTarget:self action:@selector(confirmAction:) forControlEvents:UIControlEventTouchUpInside];
        _confirmButton.enabled = NO;
        _confirmButton.frame = CGRectMake(0, 0, 80, 45);
        _confirmButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        _confirmButton.titleLabel.font = [UIFont systemFontOfSize:17];
        [_confirmButton setTitle:@"确定" forState:UIControlStateNormal];
        [_confirmButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    
    return _confirmButton;
}

@end
