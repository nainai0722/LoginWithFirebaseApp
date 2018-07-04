//
//  NextViewController.m
//  animationNavigationBarApp
//
//  Created by apple on 2018/06/21.
//  Copyright © 2018年 com.nainai0722. All rights reserved.
//

#import "NextViewController.h"
#import <FIRDatabase.h>
#import <FirebaseAuth.h>
@interface NextViewController ()
//@property (strong, nonatomic) FIRDatabaseReference *ref;
@property (weak, nonatomic) IBOutlet UILabel *yourUid;
@property (strong,nonatomic) NSDictionary *userInfo;
@end

@implementation NextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.ref = [[FIRDatabase database] reference];
    
    /*データを引っ張り出す*/
    NSString *userID = [FIRAuth auth].currentUser.uid;
    
    self.yourUid.text = userID;
//    [[[_ref child:@"users"] child:userID] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
//        // Get user value
//        NSLog(@"snapShot %@",snapshot);
//        NSLog(@"userName %@",snapshot.value[@"username"]);
//        NSDictionary *userdata = snapshot.value[@"userData"];
//        if ([userdata count] == 0) {
//            [[[[_ref child:@"users"] child:userID] child:@"userData"] setValue:[self defaultyourData]];
//        }else{
//            
//        }
//        // ...
//    } withCancelBlock:^(NSError * _Nonnull error) {
//        NSLog(@"%@", error.localizedDescription);
//    }];
//    [[[_ref child:@"users"] child:uid]
//     setValue:@{@"username": @"testUser001"}];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(NSDictionary * )defaultyourData{
    NSMutableDictionary* dictionary = [NSMutableDictionary dictionary];
    [dictionary setObject:@"kigaeGirl.png" forKey:@"着替え"];
    [dictionary setObject:@"family_hamigaki_shiage.png" forKey:@"歯磨き"];
    [dictionary setObject:@"toiletKid.png" forKey:@"トイレ"];
    [dictionary setObject:@"food_gohan.png" forKey:@"朝ごはん"];
    [dictionary setObject:@"mushiyoke.png" forKey:@"虫除けスプレー"];
    [dictionary setObject:@"kutsu_nugu_good.png" forKey:@"靴を脱ぐ"];
    [dictionary setObject:@"tearai_hand_suidou.png" forKey:@"手洗い"];
    [dictionary setObject:@"ojigi_girl.png" forKey:@"挨拶"];
    [dictionary setObject:@"sentaku_kago.png" forKey:@"洗濯機に制服投入"];
    [dictionary setObject:@"pet_oyatsu_dog.png" forKey:@"ハロ君に夕飯"];
    [dictionary setObject:@"book_renrakuchou.png" forKey:@"連絡帳確認"];
    [dictionary setObject:@"bluebird_baka.png" forKey:@"twitter"];
    [dictionary setObject:@"ehon_hahako.png" forKey:@"絵本選ぶ"];
    
    return [dictionary copy];
}

@end
