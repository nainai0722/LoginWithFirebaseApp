//
//  TaskListDetailTableViewCell.h
//  prepareBoardApp
//0
//  Created by apple on 2018/06/05.
//  Copyright © 2018年 com.nainai0722. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"
#import "TaskListDetailTableViewCell.h"
@protocol TaskListDetailTableViewCellDelegate<NSObject>;
@optional
-(void)addPrepareActionForList:(UITableViewCell*)detailCell :(BOOL)isAdd;//add 1 delete 0
-(void)editPrepareActionForList:(UITableViewCell*)detailCell;
@end
@interface TaskListDetailTableViewCell : UITableViewCell{
    BOOL isAddAction;
}
@property (weak, nonatomic) IBOutlet UILabel *HeaderLabel;
@property (weak, nonatomic) IBOutlet UIButton *AddBtn;
@property (weak, nonatomic) IBOutlet UIButton *DeleteBtn;
@property (weak, nonatomic)  NSDictionary *info;
@property (nonatomic)  NSMutableArray *prepareActionList;
@property (weak, nonatomic) IBOutlet UIImageView *cellTaskImage;
/**
 delegateオブジェクト
 */
@property (weak, nonatomic) id <TaskListDetailTableViewCellDelegate> delegate;

@end


