//
//  TopViewController.m
//  prepareBoardApp
//
//  Created by apple on 2018/06/07.
//  Copyright © 2018年 com.nainai0722. All rights reserved.
//

#import "TopViewController.h"
#import "ContentsManager.h"
#import <FIRDatabase.h>
#import <FirebaseAuth.h>
#import "TaskListTableViewController.h"
#import "addOriginalTaskViewController.h"
@interface TopViewController (){
        ContentsManager *_ctManager;
}
//@property (strong, nonatomic) FIRDatabaseReference *ref;
@property (weak, nonatomic) UILabel *yourUid;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *collectBtn;
@property (strong,nonatomic) NSDictionary * yourData;
@end

@implementation TopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    
    /*データを引っ張り出す*/
    NSString *userID = [FIRAuth auth].currentUser.uid;
    
    self.yourUid.text = userID;
    _ctManager = [[ContentsManager alloc] init];
    
    
    self.yourData = _ctManager.imageDic;

    
    for (UIButton *button in self.collectBtn) {
            button.imageView.contentMode = UIViewContentModeScaleAspectFit;
    }
}
- (IBAction)touchBtn:(UIButton *)sender {
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:sender.titleLabel.text forKey:@"taskName"];
    [ud synchronize];
    
    TaskListTableViewController *vc = [[TaskListTableViewController alloc] init];
    [self presentViewController:vc animated:YES completion:nil];
}
- (IBAction)touchAddOriginalTask:(id)sender {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"お支度名追加"
                                                                             message:@"お支度名追加画面へ行きます"
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"button title"
                                                     style:UIAlertActionStyleDefault
                                                   handler:^(UIAlertAction *action) {
                                                       NSLog(@"clicked Button title: %@", action.title);
                                                       
                                                       //画面遷移用に使う
                                                       addOriginalTaskViewController *vc = [[addOriginalTaskViewController alloc] init];
                                                       [self presentViewController:vc animated:YES completion:nil];
                                                   }];
    [alertController addAction:action];
    [self presentViewController:alertController
                       animated:YES
                     completion:^{
                         NSLog(@"displayed");
                     }];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
/*
 //画面遷移用に使う
 ViewController *vc = [[ViewController alloc] init];
 vc.prepareAction =self.prepareActionArry;
 [self presentViewController:vc animated:YES completion:nil];
 */



@end
