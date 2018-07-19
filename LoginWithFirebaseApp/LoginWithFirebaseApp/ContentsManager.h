//
//  ContentsManager.h
//  LoginWithFirebaseApp
//
//  Created by apple on 2018/07/02.
//  Copyright © 2018年 com.nainai0722. All rights reserved.
//

#import <Foundation/Foundation.h>
@import Firebase;
@interface ContentsManager : NSObject
@property (strong,nonatomic) NSDictionary * imageDic;
//@property (strong,nonatomic) NSInteger *imageDicNum;
- (void)updateData:(NSString *)dateStr withImgStr:(NSString *)imageName;
- (NSInteger)imgaeDicNum;
@end
