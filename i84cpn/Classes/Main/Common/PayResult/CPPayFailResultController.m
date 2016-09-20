//
//  CPPayFailResultController.m
//  i84cpn
//
//  Created by 爱巴士-余夏伟 on 16/5/28.
//  Copyright © 2016年 5i84. All rights reserved.
//

#import "CPPayFailResultController.h"
#import "CPPayResultController.h"
#import "CPAlipayModel.h"
#import <i84cpn-Swift.h>

@interface CPPayFailResultController (){
    CPAlipayModel *alipayModel;
}

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *buttonBottom;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageTop;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *buttonTop;

@end

@implementation CPPayFailResultController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"付款结果";
    self.imageTop.constant = 140 * SCALE_HEIGHT;
    self.buttonBottom.constant = 58 * SCALE_HEIGHT;
    self.buttonTop.constant = 33 *SCALE_HEIGHT;
    
    alipayModel = [CPAlipayModel shareCPAlipayModel];
    
    //注册通知,接收支付宝APP支付回调
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(paySuccess) name:@"ALIPAY_SUCCESS" object:nil];
}


-(void)dealloc{
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"ALIPAY_SUCCESS" object:nil];
}

#pragma mark 前往我的订单
- (IBAction)myOrderClick:(UIButton *)sender {
    NSMutableArray * array =[[NSMutableArray alloc]initWithArray:self.navigationController.viewControllers];
    for (UIViewController *VC in array) {
        if ([VC isKindOfClass:[CPMyOrdersViewController class]]) {
            [self.navigationController popToViewController:VC animated:YES];
        }
    }
    CPMyOrdersViewController *orderVC = [[CPMyOrdersViewController alloc] init];
    [self.navigationController pushViewController:orderVC animated:YES];
}

#pragma mark 选择支付宝
- (IBAction)alipayClick:(UIButton *)sender {
    ((UIButton *)[self.view viewWithTag:101]).selected = NO;
    sender.selected = !sender.selected;
}


#pragma mark 选择微信支付
- (IBAction)weChatClick:(UIButton *)sender {
    ((UIButton *)[self.view viewWithTag:100]).selected = NO;
    sender.selected = !sender.selected;
}


#pragma mark 支付
- (IBAction)payClick:(UIButton *)sender {
    [alipayModel alipaySuccessBlock:^(id responseObject) {
        CPPayResultController *successVC = [[CPPayResultController alloc] init];
        [self.navigationController pushViewController:successVC animated:YES];
    } failureBlock:^(NSError *error) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"订单支付失败" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles: nil];
        [alert show];
    }];
}

-(void)paySuccess{
    CPPayResultController *successVC = [[CPPayResultController alloc] init];
    [self.navigationController pushViewController:successVC animated:YES];
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

@end
