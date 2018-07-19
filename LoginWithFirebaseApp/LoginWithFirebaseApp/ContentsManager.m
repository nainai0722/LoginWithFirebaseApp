//
//  ContentsManager.m
//  LoginWithFirebaseApp
//
//  Created by apple on 2018/07/02.
//  Copyright © 2018年 com.nainai0722. All rights reserved.
//

#import "ContentsManager.h"
#import <FIRDatabase.h>
#import <FirebaseAuth.h>
@interface ContentsManager()
@property (strong, nonatomic) FIRDatabaseReference *ref;
@end

@implementation ContentsManager
// 初期化します、シングルトンにしたければしてください。
- (id)init
{
    self = [super init];
    if (self) {
        if(self.imageDic == nil){
            [self readData];
        }else{
            return self.imageDic;
        }
    }
    return self;
}



// データ読みこんで保持します
- (void)readData{
    //    yourData
    self.ref = [[FIRDatabase database] reference];
    NSString *userID = [FIRAuth auth].currentUser.uid;
    
    if(self.imageDic != nil){return;}
    
    [[[self.ref child:@"users"] child:userID] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
        // Get user value
        NSLog(@"snapShot %@",snapshot);
        NSLog(@"userName %@",snapshot.value[@"username"]);
        NSDictionary *userdata = snapshot.value[@"userData"];
        if ([userdata count] == 0) {
            [[[[self.ref child:@"users"] child:userID] child:@"userData"] setValue:[self defaultyourData]];
            self.imageDic = [self defaultyourData];
        }else{
            self.imageDic = userdata;
        }
        // ...
    } withCancelBlock:^(NSError * _Nonnull error) {
        NSLog(@"%@", error.localizedDescription);
    }];
}

- (NSInteger)imgaeDicNum{
    
    if (self.imageDic == nil) {
        
        self.ref = [[FIRDatabase database] reference];
        NSString *userID = [FIRAuth auth].currentUser.uid;
        [[[self.ref child:@"users"] child:userID] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
            // Get user value
            NSLog(@"snapShot %@",snapshot);
            NSLog(@"userName %@",snapshot.value[@"username"]);
            NSDictionary *userdata = snapshot.value[@"userData"];
            if ([userdata count] == 0) {
                [[[[self.ref child:@"users"] child:userID] child:@"userData"] setValue:[self defaultyourData]];
                self.imageDic = [self defaultyourData];
            }else{
                self.imageDic = userdata;
            }
            // ...
        } withCancelBlock:^(NSError * _Nonnull error) {
            NSLog(@"%@", error.localizedDescription);
        }];
    }
    
    return [self.imageDic count];
}

// アップデートします
- (void)updateData:(NSString *)dateStr withImgStr:(NSString *)imageName{
    //    yourData
    self.ref = [[FIRDatabase database] reference];
    NSString *userID = [FIRAuth auth].currentUser.uid;
    
    [[[[self.ref child:@"users"] child:userID] child:@"userData"] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
        // Get user value
        NSLog(@"add Date Str %@",snapshot.value[dateStr]);
        NSDictionary *userdata = snapshot.value[dateStr];
        if ([userdata count] == 0) {
            [[[[[self.ref child:@"users"] child:userID] child:@"userData"] child:dateStr] setValue:imageName];
        }else{
            NSString *key = [[self.ref child:@"userData"] childByAutoId].key;
            NSDictionary *post = @{imageName:imageName};
            NSDictionary *childUpdates = @{[@"/users/" stringByAppendingString:key]: post,
                                           [NSString stringWithFormat:@"/%@/", userID]: post};
            [self.ref updateChildValues:childUpdates];
        }
        // ...
    } withCancelBlock:^(NSError * _Nonnull error) {
        NSLog(@"%@", error.localizedDescription);
    }];
}

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

