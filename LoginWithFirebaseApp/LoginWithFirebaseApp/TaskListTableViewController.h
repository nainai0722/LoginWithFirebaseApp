//
//  TaskListTableViewController.h
//  prepareBoardApp
//
//  Created by apple on 2018/06/05.
//  Copyright © 2018年 com.nainai0722. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TaskListDetailTableViewCell.h"
@interface TaskListTableViewController : UITableViewController<TaskListDetailTableViewCellDelegate>

@property (nonatomic)  NSMutableArray *prepareActionArry;
@property (weak,nonatomic)  NSMutableArray *prepareActionHeaderSectionArry;
@property(strong,nonatomic)TaskListDetailTableViewCell *detailCell;
@end
