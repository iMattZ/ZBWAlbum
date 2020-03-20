
//
//  ZBWPhotoManager.m
//  ZBWAlbum
//
//  Created by 张博文 on 2020/3/18.
//  Copyright © 2020 com.bw. All rights reserved.
//


#import "ZBWPhotosManager.h"
#import "ZBWAlbumViewController.h"
#import "ZBWPhotoManager.h"

@implementation ZBWPhotosManager

/// 显示相册
/// @param viewController 跳转的控制器
/// @param maxCount 最大选择数量
/// @param albumArray 返回的图片数组
+ (void)showPhotosManager:(UIViewController*)viewController withMaxImageCount:(NSInteger)maxCount withAlbumArray:(void(^)(NSMutableArray <ZBWPhotoModel*>* albumArray))albumArray {
    
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (status == PHAuthorizationStatusAuthorized) {
                
                ZBWAlbumViewController *albumViewController = [[ZBWAlbumViewController alloc]init];
                albumViewController.confirmAction = ^{
                    albumArray([ZBWPhotoManager standardPhotoManger].photoModelList);
                };
                [ZBWPhotoManager standardPhotoManger].maxCount = maxCount;
                
                UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:albumViewController];
                
                nav.modalPresentationStyle = UIModalPresentationFullScreen;
                
                [viewController presentViewController:nav animated:YES completion:nil];
                
                
            }else {
                
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"访问相册" message:@"您还没有打开相册权限" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"去打开" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
                    if ([[UIApplication sharedApplication] canOpenURL:url]) {
                        [[UIApplication sharedApplication]openURL:url options:nil completionHandler:nil];
                    }
                }];
                
                UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
                [alertController addAction:action1];
                [alertController addAction:action2];
                
                [viewController presentViewController:alertController animated:YES completion:nil];
                
            }
        });
    }];
}
@end
