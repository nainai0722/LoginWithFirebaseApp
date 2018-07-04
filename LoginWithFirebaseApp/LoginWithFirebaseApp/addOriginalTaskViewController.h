//
//  addOriginalTaskViewController.h
//  prepareBoardApp
//
//  Created by apple on 2018/06/11.
//  Copyright © 2018年 com.nainai0722. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Photos/Photos.h>
@import Firebase;

NS_ASSUME_NONNULL_BEGIN
@protocol TaskListDetailTableViewCellDelegate<NSObject>;
@optional
-(void)updateTaskDetailActin:(NSString*)str img:(UIImage*)img indexPath:(NSIndexPath*)indexPath;
@end
@interface addOriginalTaskViewController : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic) NSInteger *fromView;      // 1の時はTopViewからの呼び出し　２の時はTaskListTableViewからの呼び出しと定義する
@property (nonatomic) NSInteger *fromCellRow;
@property (nonatomic) NSIndexPath *fromViewIndexPath;

/**
 delegateオブジェクト
 */
@property (weak, nonatomic) id <TaskListDetailTableViewCellDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
