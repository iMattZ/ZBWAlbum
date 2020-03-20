//
//  ZBWAlbumModel.m
//  ZBWAlbum
//
//  Created by 张博文 on 2020/3/19.
//  Copyright © 2020 com.bw. All rights reserved.
//

#import "ZBWAlbumModel.h"

@implementation ZBWAlbumModel
-(void)setCollection:(PHAssetCollection *)collection {
    _collection = collection;
    
    if ([collection.localizedTitle isEqualToString:@"All Photos"]) {
        self.collectionTitle = @"全部相册";
    } else {
        self.collectionTitle = collection.localizedTitle;
    }
    
    PHFetchOptions *option = [[PHFetchOptions alloc] init];
    if (!self.sortAscendingByModificationDate) {
        option.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:self.sortAscendingByModificationDate]];
    }
    
    self.collectionTitle = collection.localizedTitle;
    
    // 获得某个相簿中的所有PHAsset对象
    self.assets = [PHAsset fetchAssetsInAssetCollection:collection options:option];
    
    if (self.assets.count > 0) {
        self.firstAsset = self.assets[0];
    }
    self.collectionNumber = [NSString stringWithFormat:@"%ld", self.assets.count];
}


#pragma mark - Get方法
-(NSMutableArray<NSNumber *> *)selectRows {
    if (!_selectRows) {
        _selectRows = [NSMutableArray array];
    }
    
    return _selectRows;
}

@end
