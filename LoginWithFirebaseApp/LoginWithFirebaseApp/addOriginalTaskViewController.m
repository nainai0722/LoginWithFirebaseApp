
//  addOriginalTaskViewController.m
//  prepareBoardApp
//
//  Created by apple on 2018/06/11.
//  Copyright © 2018年 com.nainai0722. All rights reserved.
//

#import "addOriginalTaskViewController.h"
#import "TaskListTableViewController.h"
#import "ContentsManager.h"
#import <FirebaseAuth.h>
#import <FIRDatabase.h>
#import <FirebaseStorage.h>
@interface addOriginalTaskViewController ()
{
    ContentsManager *_ctManager;
}
@property (weak, nonatomic) IBOutlet UIImageView *addOriginalTaskImage;
@property (weak, nonatomic) IBOutlet UITextField *addoriginalTaskName;
@property (strong, nonatomic) FIRDatabaseReference *ref;
@property (strong, nonatomic) FIRStorageReference *storageRef;
@end

@implementation addOriginalTaskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _ctManager = [[ContentsManager alloc] init];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)touchBackView:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)touchRegistTaskBtn:(UIButton *)sender {
    if(self.fromView == (NSInteger)2){
        [_ctManager updateData:self.addoriginalTaskName.text withImgStr:[NSString stringWithFormat:@"images/test%ld.png",1+[_ctManager.imageDic count]]];
        
        FIRStorage *imageStorage = [FIRStorage storage];
        self.storageRef = [imageStorage reference];
        
//        self.addOriginalTaskImage.imageをNSDataに変換
 /*
  
        
        // 取得した画像の縦サイズ、横サイズを取得する
        int imageW = aImage.size.width;
        int imageH = aImage.size.height;
        
        // リサイズする倍率を作成する。
        float scale = (imageW > imageH ? 320.0f/imageH : 320.0f/imageW);
        
        // 比率に合わせてリサイズする。
        // ポイントはUIGraphicsXXとdrawInRectを用いて、リサイズ後のサイズで、
        // aImageを書き出し、書き出した画像を取得することで、
        // リサイズ後の画像を取得します。
        CGSize resizedSize = CGSizeMake(imageW * scale, imageH * scale);
        UIGraphicsBeginImageContext(resizedSize);
        [aImaged drawInRect:CGRectMake(0, 0, resizedSize.width, resizedSize.height)];
        UIImage* resizedImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
  
  */
        
        // 取得した画像の縦サイズ、横サイズを取得する
        int imageW = self.addOriginalTaskImage.image.size.width;
        int imageH = self.addOriginalTaskImage.image.size.height;
        
        // リサイズする倍率を作成する。
        float scale = (imageW > imageH ? 320.0f/imageH : 320.0f/imageW);
        
        // 比率に合わせてリサイズする。
        // ポイントはUIGraphicsXXとdrawInRectを用いて、リサイズ後のサイズで、
        // aImageを書き出し、書き出した画像を取得することで、
        // リサイズ後の画像を取得します。
        CGSize resizedSize = CGSizeMake(imageW * scale, imageH * scale);
        UIGraphicsBeginImageContext(resizedSize);
        [self.addOriginalTaskImage.image drawInRect:CGRectMake(0, 0, resizedSize.width, resizedSize.height)];
        UIImage* resizedImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        NSData *data = UIImagePNGRepresentation(resizedImage);
        FIRStorageReference *reference = [self.storageRef child:[NSString stringWithFormat:@"test%ld.png",1+[_ctManager.imageDic count]]];
        FIRStorageReference *imageReference = [self.storageRef child:[NSString stringWithFormat:@"images/test%ld.png",1+[_ctManager.imageDic count]]];
        [reference.name isEqualToString:imageReference.name];
        
        // Upload the file to the path "images/rivers.jpg"
        FIRStorageUploadTask *uploadTask = [imageReference putData:data
                                                     metadata:nil
                                                   completion:^(FIRStorageMetadata *metadata,
                                                                NSError *error) {
                                                       if (error != nil) {
                                                           // Uh-oh, a   n error occurred!
                                                       } else {
                                                           // Metadata contains file metadata such as size, content-type, and download URL.
                                                           int size = metadata.size;
                                                           // You can also access to download URL after upload.
                                                           [imageReference downloadURLWithCompletion:^(NSURL * _Nullable URL, NSError * _Nullable error) {
                                                               if (error != nil) {
                                                                   // Uh-oh, an error occurred!
                                                               } else {
                                                                   NSURL *downloadURL = URL;
                                                               }
                                                           }];
                                                       }
                                                   }];
        
        [self.delegate updateTaskDetailActin:self.addoriginalTaskName.text img:self.addOriginalTaskImage.image indexPath:self.fromViewIndexPath];
        [self dismissViewControllerAnimated:YES completion:nil];
    }else{
        self.ref = [[FIRDatabase database] reference];
        NSString *uid = [FIRAuth auth].currentUser.uid;
        [[[[_ref child:@"users"] child:uid] child:@"userData"]
         setValue:@{self.addoriginalTaskName.text:@"taskName"}];
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        [ud setObject:self.addoriginalTaskName.text forKey:@"taskName"];
        [ud synchronize];
        TaskListTableViewController *vc = [[TaskListTableViewController alloc] init];
        [self presentViewController:vc animated:YES completion:nil];
    }
}
- (IBAction)touchSelectTaskImageBtn:(UIButton *)sender{
    
    UIImagePickerController *imgPic = [[UIImagePickerController alloc]init];
    imgPic.delegate = self;
    [imgPic setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    [self presentViewController: imgPic animated:YES completion:nil];
}
- (void)imagePickerController :(UIImagePickerController *)picker
        didFinishPickingImage :(UIImage *)image editingInfo :(NSDictionary *)editingInfo {
    // 読み込んだ画像表示
        UIGraphicsBeginImageContext(self.view.frame.size);
        [image drawInRect:self.view.bounds];
        UIImage *iv = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        NSData *data = UIImagePNGRepresentation(image);
        NSString *filePath;
        self.addOriginalTaskImage.image = image;
        NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
        NSDictionary* imageDic = [defaults dictionaryForKey:@"imageDic"];
        int imageDicCoutnt = (int)[imageDic count]+1;
        filePath = [NSString stringWithFormat:@"%@/image%d.png", [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"],imageDicCoutnt];
    
        if ([data writeToFile:filePath atomically:YES]) {
            NSMutableDictionary* dictionary = [imageDic mutableCopy];
            [dictionary setObject:filePath forKey:self.addoriginalTaskName.text];
            [defaults setObject:[dictionary copy] forKey:@"imageDic"];
            [defaults synchronize];
        } else {
            NSLog(@"Error");
        }
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
