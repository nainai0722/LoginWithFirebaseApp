//
//  FirstViewController.m
//  LoginWithFirebaseApp
//
//  Created by apple on 2018/06/30.
//  Copyright © 2018年 com.nainai0722. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nametf;
@property (weak, nonatomic) IBOutlet UITextField *eMailtf;

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)touchCreateNewUserBtn:(id)sender {
}
- (IBAction)touchEnableEmailBtn:(id)sender {
    if (self.eMailtf.enabled) {
        self.eMailtf.enabled = NO;
    }else{
        self.eMailtf.enabled = YES;
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
