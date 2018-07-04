
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
@interface addOriginalTaskViewController ()
{
    ContentsManager *_ctManager;
}
@property (weak, nonatomic) IBOutlet UIImageView *addOriginalTaskImage;
@property (weak, nonatomic) IBOutlet UITextField *addoriginalTaskName;
@property (strong, nonatomic) FIRDatabaseReference *ref;
@end

@implementation addOriginalTaskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _ctManager = [[ContentsManager alloc] init];
    // Do any additional setup after loading the view from its nib.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)touchBackView:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)touchRegistTaskBtn:(UIButton *)sender {
    if(self.fromView == 2){
        [self.delegate updateTaskDetailActin:self.addoriginalTaskName.text img:self.addOriginalTaskImage.image indexPath:self.fromViewIndexPath];
        [self dismissViewControllerAnimated:YES completion:nil];
    }else{
        self.ref = [[FIRDatabase database] reference];
        NSString *uid = [FIRAuth auth].currentUser.uid;
//        [[[_ref child:@"users"] child:uid]
//         setValue:@{@"userData": textField.text}];
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
