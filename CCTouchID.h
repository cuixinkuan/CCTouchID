//
//  CCTouchID.h
//  CCTouchIDDemo
//
//  Created by admin on 16/1/23.
//  Copyright © 2016年 CXK. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <LocalAuthentication/LocalAuthentication.h>

#if TARGET_IPHONE_SIMULATOR
#define CCNotice(Chinese,English) [[[[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"] objectAtIndex:0] isEqualToString:@"zh-Hans-US"] ? Chinese : English
#elif TARGET_OS_IPHONE
#define CCNotice(Chinese,English) [[[[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"] objectAtIndex:0] isEqualToString:@"zh-Hans-CN"] ? Chinese : English
#endif

@class CCTouchID;
@protocol CCTouchIDDelegate <NSObject>

@required
/**
 *  TouchID 验证成功
 */
- (void)CCTouchIDAuthorizeSuccess;
/**
 *  TouchID 验证失败
 */
- (void)CCTouchIDAuthorizeFailure;


@optional
/**
 *  取消TouchID验证（用户点击了取消）
 */
- (void)CCTouchIDAuthorizeErrorUserCancel;
/**
 *  在TouchID中点击输入密码按钮
 */
- (void)CCTouchIDAuthorizeErrorUserFallback;
/**
 *  在验证TouchID的过程中被系统取消例如突然来电话，按了home键，锁屏等等
 */
- (void)CCTouchIDAuthorizeErrorSystemCancel;
/**
 *  无法启用TouchID,设备没有设置密码
 */
- (void)CCTouchIDAuthorizeErrorPasscodeNotSet;
/**
 *  设备没有录入TouchID，无法启用
 */
- (void)CCTouchIDAuthorizeErrorTouchIDNotEnrolled;
/**
 *  该设备的TouchID无效
 */
- (void)CCTouchIDAuthorizeErrorTouchIDNotAvailable;
/**
 *  多次继续使用TouchID失败被锁，需要用户输入密码解锁
 */
- (void)CCTouchIDAuthorizeErrorTouchIDLockout;
/**
 *  当前软件被挂起取消了授权，比如来电话了
 */
- (void)CCTouchIDAuthorizeErrorAppCancel;
/**
 *  在授权过程中，LAContext对象被释放了
 */
- (void)CCTouchIDAuthorizeErrorInvalidContext;
/**
 *  当前设备不支持指纹识别
 */
- (void)CCTouchIDIsNotSupport;

@end

@interface CCTouchID : LAContext

@property (nonatomic,weak)id <CCTouchIDDelegate> delegate;
/**
 *  发起TouchID验证
 *
 *  @param message       提示框显示信息
 *  @param fallbackTitle button title 默认为"Enter Password"
 *  @param delegate      代理
 */
- (void)startCCTouchIDWithMessage:(NSString *)message fallbackTitle:(NSString * )fallbackTitle delegate:(id <CCTouchIDDelegate>)delegate;

@end

