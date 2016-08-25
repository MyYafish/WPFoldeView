//
//  secondViewController.m
//  WPFoldedView
//
//  Created by 吴鹏 on 16/8/24.
//  Copyright © 2016年 wupeng. All rights reserved.
//

#import "secondViewController.h"
#import "ViewController.h"

#define WIDETH 100

@interface secondViewController ()<UITableViewDelegate , UITableViewDataSource>
{
    float localPoint;
}
@property (nonatomic , strong) ViewController * vc;
@property (nonatomic , strong) UITableView * tableView;

@end

@implementation secondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我k哥强无敌";
    self.vc = [[ViewController alloc]init];
    [self addChildViewController:self.vc];
    [self.view addSubview:self.vc.view];
    [self.view addSubview:self.tableView];
    UIPanGestureRecognizer * pangestur = [[UIPanGestureRecognizer alloc]initWithTarget:self
                                                                                action:
                                                                  @selector(edgePanGesture:)];
    [self.vc.view addGestureRecognizer:pangestur];
    localPoint = 0;
    [self animation:-M_PI_2 progress:0];
    
    
    UILabel * textLabel = [[UILabel alloc]initWithFrame:self.vc.view.frame];
    textLabel.textColor = [UIColor blackColor];
    textLabel.font = [UIFont systemFontOfSize:25];
    textLabel.text = @" 沿着手机边缘向右滑动---------->";
    
    [self.vc.view addSubview:textLabel];
    
    
}

#pragma mark - property

- (UITableView *)tableView
{
    if(!_tableView)
    {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDETH, CGRectGetHeight(self.view.frame)) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    }
    return _tableView;
}

#pragma mark - private


- (void)edgePanGesture:(UIPanGestureRecognizer*)recognizer
{
    
    CGRect rect = CGRectMake(0, 0, WIDETH + 20, CGRectGetHeight(self.view.frame));
    if(!CGRectContainsPoint(rect, [recognizer locationInView:self.view]))
        return;
    
    CGFloat progress;

    progress = [recognizer locationInView:self.view].x / WIDETH;
    
    progress = MIN(1.0, MAX(0.0, progress));
    if (recognizer.state == UIGestureRecognizerStateBegan)
    {
        localPoint = [recognizer locationInView:self.view].x;
        
    }else if (recognizer.state == UIGestureRecognizerStateChanged)
    {
        [self refreshView:progress];
        
    }else if (recognizer.state == UIGestureRecognizerStateCancelled || recognizer.state == UIGestureRecognizerStateEnded)
    {
        if (progress > 0.5) {
            
            [self refreshView:1];
        }else{
            [self refreshView:0];
        }
        
        
    }
}
- (void)animation:(float)x progress:(float)p
{
    CGPoint point = CGPointMake(0, 0);
    CATransform3D transfrom = CATransform3DIdentity;
    transfrom.m34 = 4.5/-2000;
    transfrom = CATransform3DRotate(transfrom, x, 0.0f, 1.0f, 0.0f);
    CALayer *layer = self.tableView.layer;
    layer.anchorPoint = point;
    layer.transform = transfrom;
    layer.position = CGPointMake(0, 0);
    
    self.vc.view.frame = CGRectMake(self.tableView.frame.size.width, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame));
    self.navigationController.navigationBar.frame = CGRectMake(self.tableView.frame.size.width, 20, CGRectGetWidth(self.view.frame), 44);
}

- (void)refreshView:(float)progress
{
    [self animation: -(M_PI_2 -M_PI_2 * progress) progress:progress];
}

#pragma mark - UITableViewDelegate & dataDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 200;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIImageView * imageview = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, WIDETH, 200)];
    imageview.image = [UIImage imageNamed:@"yingmo"];
    return imageview;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * str = @"cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:str];
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row];
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.font = [UIFont systemFontOfSize:18];
    
    return cell;
}

@end
