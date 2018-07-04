//
//  ViewController.m
//  LoginWithFirebaseApp
//
//  Created by apple on 2018/06/26.
//  Copyright © 2018年 com.nainai0722. All rights reserved.
//

#import "ViewController.h"
#import "NextViewController.h"
#import "TopViewController.h"
#import <FirebaseAuth.h>
#import <FIRDatabase.h>
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *enterIDlabel;
@property (weak, nonatomic) IBOutlet UILabel *enterPasswordLabel;
@property (weak, nonatomic) IBOutlet UITextField *idTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *createNewuserBtn;
@property (weak, nonatomic) IBOutlet UIButton *LoginBtn;
@property (weak, nonatomic) IBOutlet UITextField *nametf;
@property (weak, nonatomic) IBOutlet UITextField *eMailtf;
@property (weak, nonatomic) IBOutlet UIButton *enableEmailBtn;
@property (weak, nonatomic) IBOutlet UILabel *enableEmailLabel;
@property (weak, nonatomic) IBOutlet UIButton *NewUserBtn;
@property (strong, nonatomic) FIRDatabaseReference *ref;
@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.idTextField.hidden = YES;
    self.passwordTextField.hidden = YES;
    self.createNewuserBtn.hidden = YES;
    self.LoginBtn.hidden = YES;
    self.nametf.hidden = YES;
    self.eMailtf.hidden = YES;
    self.enableEmailLabel.hidden = YES;
    self.enableEmailBtn.hidden = YES;
    
    NSLog(@"uid = %@", [FIRAuth auth].currentUser.uid);

    NSString *uid = [FIRAuth auth].currentUser.uid;
    if (self.firstFlag) {
        self.enterIDlabel.text = @"Enter your name";
        self.nametf.hidden = NO;
        self.enterPasswordLabel.text = @"Enter Email";  self.enableEmailLabel.hidden = NO;
        self.enableEmailBtn.hidden = NO;
        self.NewUserBtn.hidden = NO;
    }else{
        if (uid != nil) {
//            /*自動ログインを実施する*/
//            self.ref = [[FIRDatabase database] reference];
            TopViewController *controller = [[TopViewController alloc] initWithNibName:@"TopViewController" bundle:nil];
            [self.navigationController pushViewController:controller animated:YES];
            return;
        }else{
        self.nametf.hidden = YES;
        self.eMailtf.hidden = YES;
        self.NewUserBtn.hidden = YES;
        self.idTextField.hidden = NO;
        self.passwordTextField.hidden = NO;
//        self.createNewuserBtn.hidden = YES;
        self.LoginBtn.hidden = NO;
        self.enableEmailLabel.hidden = NO;
        self.enableEmailBtn.hidden = NO;
        self.createNewuserBtn.hidden = YES;
        }
    }
    self.idTextField.delegate = self;
    
    
//    [[FIRAuth auth] signInAnonymouslyWithCompletion:(FIRUser *_Nullable user, NSError *_Nullable error) {
//        if (error) {
//            NSLog(@"Error");
//        } else {
//            NSLog(@"uid = %@", [FIRAuth auth].currentUser.uid);
////            if(block) block(nil);
//        }
//    }];
//    [self signInAnonymously:nil];
}
- (IBAction)touchEnableEmailBtn:(id)sender {
    self.eMailtf.hidden = NO;
}


-(BOOL)textFieldShouldEndEditing:(UITextField*)textField
{
    // 編集終了時に呼ばれるメソッド
    // YESを返した場合は編集が終了し、
    // NO を返した場合は編集が終了しない
    return YES;
}
-(void)textFieldDidEndEditing:(UITextField*)textField
{
    // 編集終了時に呼ばれるメソッド
    // No.03がYESを返したあとに呼ばれる
    self.ref = [[FIRDatabase database] reference];
    
    NSString *uid = [FIRAuth auth].currentUser.uid;
    
    [[[_ref child:@"users"] child:uid]
     setValue:@{@"username": textField.text}];
}
-(BOOL)textFieldShouldReturn:(UITextField*)textField
{
    // Retunキー(右下のボタン)を押した時に呼ばれるメソッド
    // YESを返した場合は編集が終了し、
    // NO を返した場合は編集が終了しない
    self.ref = [[FIRDatabase database] reference];
    
    NSString *uid = [FIRAuth auth].currentUser.uid;
    
    [[[_ref child:@"users"] child:uid]
     setValue:@{@"username": textField.text}];
    return YES;
}

- (void)viewWillDisappear:(BOOL)animated{
//    [[FIRAuth auth] removeAuthStateDidChangeListener:_handle];
}
- (IBAction)LoginUser:(id)sender {
//    [self showSpinner:^{
        // [START headless_email_auth]
        [[FIRAuth auth] signInWithEmail:self.idTextField.text
                               password:self.passwordTextField.text
                             completion:^(FIRAuthDataResult * _Nullable authResult,
                                          NSError * _Nullable error) {
                                 // [START_EXCLUDE]
//                                 [self hideSpinner:^{
                                     if (error) {
//                                         [self showMessagePrompt:error.localizedDescription];
                                         return;
                                     }
                                    
//                                     [self.navigationController popViewControllerAnimated:YES];
                                 NextViewController *controller = [[NextViewController alloc] initWithNibName:@"NextViewController" bundle:nil];
                                 [self.navigationController pushViewController:controller animated:YES];
//                                 }];
                                 // [END_EXCLUDE]
                             }];
        // [END headless_email_auth]
//    }];
    
}
- (IBAction)touchNewUserBtn:(id)sender {
    /*
     匿名もしくはメールにて登録
     匿名の時はシンプルに匿名メソッド利用かつ、DBに名前登録する
     
    */
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
