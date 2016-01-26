//
//  CCTouchID.m
//  CCTouchIDDemo
//
//  Created by admin on 16/1/23.
//  Copyright © 2016年 CXK. All rights reserved.
//

#import "CCTouchID.h"

@interface CCTouchID ()

@end

@implementation CCTouchID

- (void)startCCTouchIDWithMessage:(NSString *)message fallbackTitle:(NSString *)fallbackTitle delegate:(id<CCTouchIDDelegate>)delegate {
    LAContext * context = [[LAContext alloc] init];
    context.localizedFallbackTitle = fallbackTitle;
    NSError * error = nil;
    self.delegate = delegate;
    NSAssert(self.delegate != nil, CCNotice(@"CCTouchIDDelegate 不能为空", @"CCTouchIDDelegate must be non-nil"));
    
    if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]) {
        
        [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:message == nil ? CCNotice(@"默认提示信息", @"The Default Message") : message reply:^(BOOL success, NSError * _Nullable error) {
            
            if (success) {
                if ([self.delegate respondsToSelector:@selector(CCTouchIDAuthorizeSuccess)]) {
                    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                        [self.delegate CCTouchIDAuthorizeSuccess];
                    }];
                }
            }else if (error) {
                switch (error.code) {
                    case LAErrorAuthenticationFailed:
                    {
                        if ([self.delegate respondsToSelector:@selector(CCTouchIDAuthorizeFailure)]) {
                            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                                [self.delegate CCTouchIDAuthorizeFailure];
                            }];
                        }
                    }
                        break;
                    case LAErrorUserCancel:
                    {
                        if ([self.delegate respondsToSelector:@selector(CCTouchIDAuthorizeErrorUserCancel)]) {
                            [[NSOperationQueue mainQueue]addOperationWithBlock:^{
                                [self.delegate CCTouchIDAuthorizeErrorUserCancel];
                            }];
                        }
                    }
                        break;
                    case LAErrorUserFallback:
                    {
                        if ([self.delegate respondsToSelector:@selector(CCTouchIDAuthorizeErrorUserFallback)]) {
                            [[NSOperationQueue mainQueue]addOperationWithBlock:^{
                                [self.delegate CCTouchIDAuthorizeErrorUserFallback];
                            }];
                        }
                    }
                        break;
                    case LAErrorSystemCancel:
                    {
                        if ([self.delegate respondsToSelector:@selector(CCTouchIDAuthorizeErrorSystemCancel)]) {
                            [[NSOperationQueue mainQueue]addOperationWithBlock:^{
                                [self.delegate CCTouchIDAuthorizeErrorSystemCancel];
                            }];
                        }
                    }
                        break;
                    case LAErrorTouchIDNotEnrolled:
                    {
                        if ([self.delegate respondsToSelector:@selector(CCTouchIDAuthorizeErrorTouchIDNotEnrolled)]) {
                            [[NSOperationQueue mainQueue]addOperationWithBlock:^{
                                [self.delegate CCTouchIDAuthorizeErrorTouchIDNotEnrolled];
                            }];
                        }
                    }
                        break;
                    case LAErrorPasscodeNotSet:
                    {
                        if ([self.delegate respondsToSelector:@selector(CCTouchIDAuthorizeErrorPasscodeNotSet)]) {
                            [[NSOperationQueue mainQueue]addOperationWithBlock:^{
                                [self.delegate CCTouchIDAuthorizeErrorPasscodeNotSet];
                            }];
                        }
                    }
                        break;
                    case LAErrorTouchIDNotAvailable:
                    {
                        if ([self.delegate respondsToSelector:@selector(CCTouchIDAuthorizeErrorTouchIDNotAvailable)]) {
                            [[NSOperationQueue mainQueue]addOperationWithBlock:^{
                                [self.delegate CCTouchIDAuthorizeErrorTouchIDNotAvailable];
                            }];
                        }
                    }
                        break;
                    case LAErrorTouchIDLockout:
                    {
                        if ([self.delegate respondsToSelector:@selector(CCTouchIDAuthorizeErrorTouchIDLockout)]) {
                            [[NSOperationQueue mainQueue]addOperationWithBlock:^{
                                [self.delegate CCTouchIDAuthorizeErrorTouchIDLockout];
                            }];
                        }
                    }
                        break;
                    case LAErrorAppCancel:
                    {
                        if ([self.delegate respondsToSelector:@selector(CCTouchIDAuthorizeErrorAppCancel)]) {
                            [[NSOperationQueue mainQueue]addOperationWithBlock:^{
                                [self.delegate CCTouchIDAuthorizeErrorAppCancel];
                            }];
                        }
                    }
                        break;
                    case LAErrorInvalidContext:
                    {
                        if ([self.delegate respondsToSelector:@selector(CCTouchIDAuthorizeErrorInvalidContext)]) {
                            [[NSOperationQueue mainQueue]addOperationWithBlock:^{
                                [self.delegate CCTouchIDAuthorizeErrorInvalidContext];
                            }];
                        }
                    }
                        break;
                        
//                    default:
//                        break;
                }
            }
            
        }];
    }else {
        if ([self.delegate respondsToSelector:@selector(CCTouchIDIsNotSupport)]) {
            [self.delegate CCTouchIDIsNotSupport];
        }
    }
    
}

@end
