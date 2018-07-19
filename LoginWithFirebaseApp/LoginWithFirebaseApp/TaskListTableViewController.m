//
//  TaskListTableViewController.m
//  prepareBoardApp
//
//  Created by apple on 2018/06/05.
//  Copyright © 2018年 com.nainai0722. All rights reserved.
//

#import "TaskListTableViewController.h"
#import "ViewController.h"
#import "PrepareViewController.h"
#import "addOriginalTaskViewController.h"
#import "ContentsManager.h"

@interface TaskListTableViewController (){
    BOOL isTouchBtn;
    int _selfWidth;
    int _selfHeight;
    ContentsManager *_ctManager;
    
}

@end

@implementation TaskListTableViewController

-(void)viewWillAppear:(BOOL)animated{
//     _prepareActionHeaderSectionArry = @[@"おはようの支度",@"おかえりの支度",@"おやすみの支度"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    isTouchBtn = NO;
    self.prepareActionArry = [[NSMutableArray alloc] init];
    _ctManager = [[ContentsManager alloc] init];
    if (self.imageDic == nil) {
        self.imageDic = _ctManager.imageDic;
    }
    UINib *nib = [UINib nibWithNibName:@"TaskListDetailTableViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"Cell"];
   
    _selfWidth = self.view.frame.size.width;
    _selfHeight = self.view.frame.size.height;
    UIButton *footterBtn = [[UIButton alloc]initWithFrame:CGRectMake(0,_selfHeight*9/10, _selfWidth, _selfHeight*1/10)];
    [footterBtn setTitle:@"TaskStart" forState:UIControlStateNormal];
    [footterBtn setBackgroundColor:[UIColor redColor]];
    [footterBtn addTarget:self action:@selector(touchTaskStartBtn:)
     forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:footterBtn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Incomplete implementation, return the number of sections
//    return [_prepareActionHeaderSectionArry count];
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForHeaderInSection:(NSInteger)section{
    return (CGFloat)20.0;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete implementation, return the number of rows
    return 5;
}

-(UITableView *)tableView:(UITableView*)tableView titleForHeaderInSection:(NSInteger)section{
    return _prepareActionHeaderSectionArry[section];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // カスタムセルを取得
    TaskListDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    /*
    NSArray *arr = @[@[@{@"key":@"着替え"},@{@"key":@"歯磨き"},@{@"key":@"トイレ"},@{@"key":@"朝ごはん"},@{@"key":@"虫除けスプレー"}],@[@{@"key":@"靴を脱ぐ"},@{@"key":@"手洗い"},@{@"key":@"挨拶"},@{@"key":@"洗濯機に制服投入"},@{@"key":@"ハロ君に夕飯"}],@[@{@"key":@"絵本選ぶ"},@{@"key":@"歯磨き"},@{@"key":@"トイレ"},@{@"key":@"連絡帳確認"},@{@"key":@"twitter"}]];
     */
    
    NSArray *arr = [self.imageDic allValues];
//    cell.HeaderLabel.text =  [[arr objectAtIndex:indexPath.section] objectAtIndex:indexPath.row][@"key"];
    cell.HeaderLabel.text =  [arr objectAtIndex:indexPath.row];
    cell.delegate = self;
    
//    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
//    NSDictionary* imageDic = [defaults dictionaryForKey:@"imageDic"];
//    NSDictionary *imageDic = _ctManager.imageDic;
    
    [cell.cellTaskImage setImage: [UIImage imageNamed:[self.imageDic objectForKey:cell.HeaderLabel.text]]];
    cell.cellTaskImage.contentMode = UIViewContentModeScaleAspectFit;
    
    return cell;
}
// LoginServiceDelegateを実装します
#pragma mark - DetailCellDelegate
-(void)addPrepareActionForList:(UITableViewCell*)detailCell :(BOOL)isAdd{
    if (detailCell) {
        NSLog(@"indexPath = %@", [self.tableView indexPathForCell:detailCell]);
    }
    TaskListDetailTableViewCell *cell = [self.tableView cellForRowAtIndexPath:[self.tableView indexPathForCell:detailCell]];
    if (isAdd) {
        [self.prepareActionArry addObject:cell.HeaderLabel.text];
    }else{
        NSMutableArray *discards = [NSMutableArray array];
        for (NSString *n in self.prepareActionArry) {
            if ([n isEqualToString:(NSString *)cell.HeaderLabel.text]) {
                [discards addObject:n];
            }
        }
        [self.prepareActionArry removeObjectsInArray:discards];
    }
    for (NSString *n in self.prepareActionArry) {
        NSLog(@"self.prepareActionArry %@",n);
    }
}

- (void)editPrepareActionForList:(UITableViewCell *)detailCell{
    /*タスクの詳細編集画面へ遷移する*/
        addOriginalTaskViewController *artvc = [[addOriginalTaskViewController alloc] init];
        artvc.fromView = 2;
        artvc.fromViewIndexPath = [self.tableView indexPathForCell:detailCell];
        artvc.delegate = self;
        [self presentViewController:artvc animated:YES completion:nil];
}

-(void)updateTaskDetailActin:(NSString*)str img:(UIImage*)img indexPath:(NSIndexPath*)indexPath{
    TaskListDetailTableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    
    NSMutableArray *discards = [NSMutableArray array];
    for (NSString *n in self.prepareActionArry) {
        if ([n isEqualToString:(NSString *)cell.HeaderLabel.text]) {
            [discards addObject:n];
        }
    }
    [self.prepareActionArry removeObjectsInArray:discards];
    
    [cell.cellTaskImage setImage:img];
    cell.cellTaskImage.contentMode = UIViewContentModeScaleAspectFit;
    cell.HeaderLabel.text = str;
    [self.prepareActionArry addObject:cell.HeaderLabel.text];
    
//    imgaDicのデータ再取得
    if (_ctManager != nil) {
        _ctManager = nil;
        _ctManager = [[ContentsManager alloc] init];
    }
}

- (void)touchTaskStartBtn:(UIButton*)sender{
//TODO ここを次は対処する
    
    PrepareViewController *vc = [[PrepareViewController alloc] init];
    vc.prepareAction =self.prepareActionArry;
    vc.imageDic = _ctManager.imageDic;
    [self presentViewController:vc animated:YES completion:nil];
    
//    ViewController *vc = [[ViewController alloc] init];
//    vc.prepareAction =self.prepareActionArry;
//    [self presentViewController:vc animated:YES completion:nil];
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    TaskListDetailTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [self.prepareActionArry addObject:cell.HeaderLabel.text];
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
