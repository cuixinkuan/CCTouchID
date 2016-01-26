//
//  ViewController.m
//  CCTouchIDDemo
//
//  Created by admin on 16/1/23.
//  Copyright © 2016年 CXK. All rights reserved.
//

#import "ViewController.h"
#import "CCTouchID.h"

@interface ViewController ()<CCTouchIDDelegate>

@property (weak, nonatomic) IBOutlet UILabel *Noticelabel;
@property (nonatomic,strong)CCTouchID * touchID;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 指纹识别
    CCTouchID * touchID = [[CCTouchID alloc] init];
    [touchID startCCTouchIDWithMessage:CCNotice(@"自定义信息", @"The Custom Message") fallbackTitle:CCNotice(@"按钮标题", @"Fallback Title") delegate:self];
    self.touchID = touchID;
}

- (IBAction)startCCTouchID:(id)sender {
    [self.touchID startCCTouchIDWithMessage:CCNotice(@"自定义信息", @"The Custom Message") fallbackTitle:CCNotice(@"按钮标题", @"Fallback Title") delegate:self];
}


#pragma  mark - CCTouchIDDelegate - 
- (void)CCTouchIDAuthorizeSuccess {
    self.Noticelabel.text = CCNotice(@"TouchID验证成功", @"Authorize Success");
}
- (void)CCTouchIDAuthorizeFailure {
    self.Noticelabel.text = CCNotice(@"TouchID验证失败", @"Authorize Failure");
}
- (void)CCTouchIDAuthorizeErrorUserCancel {
    self.Noticelabel.text = CCNotice(@"取消TouchID验证(用户点击了取消)", @"Authorize Error User Cancel");
}
- (void)CCTouchIDAuthorizeErrorUserFallback {
    self.Noticelabel.text = CCNotice(@"在TouchID对话框中点击输入密码按钮", @"Authorize Error User Fallback");
}
- (void)CCTouchIDAuthorizeErrorSystemCancel {
    self.Noticelabel.text = CCNotice(@"在TouchID验证过程中被系统取消", @"Authorize Error System Cancel");
}
- (void)CCTouchIDAuthorizeErrorPasscodeNotSet {
    self.Noticelabel.text = CCNotice(@"无法启用TouchID，设备没有设置密码", @"Authorize Error Passcode Not Set");
}
- (void)CCTouchIDAuthorizeErrorTouchIDNotEnrolled {
    self.Noticelabel.text = CCNotice(@"设备没有录入TouchID,无法启用TouchID", @"Authorize Error TouchID Not Enrolled");
}
- (void)CCTouchIDAuthorizeErrorTouchIDNotAvailable {
    self.Noticelabel.text = CCNotice(@"改设备的TouchID无效", @"Authorize Error TouchID Not Available");
}
- (void)CCTouchIDAuthorizeErrorTouchIDLockout {
    self.Noticelabel.text = CCNotice(@"多次连续使用TouchID失败被锁,需要用户输入密码解锁", @"Authorize LAError TouchID Lockout");
}
- (void)CCTouchIDAuthorizeErrorAppCancel {
    self.Noticelabel.text = CCNotice(@"当前软件被挂起取消了授权", @"Authorize LAError AppCancel");
}
- (void)CCTouchIDAuthorizeErrorInvalidContext {
    self.Noticelabel.text = CCNotice(@"授权过程中LAContext对象被释放", @"Authorize LAError Invalid Context");
}
- (void)CCTouchIDIsNotSupport {
    self.Noticelabel.text = CCNotice(@"当前设备不支持指纹识别", @"The Current Device Don't Support");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
