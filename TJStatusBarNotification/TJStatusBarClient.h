//
//  TJStatusBarClient.h
//  TJStatusBarNotification
//
//  Created by 王朋涛 on 16/9/9.
//  Copyright © 2016年 王朋涛. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JDStatusBarNotification.h"

@interface TJStatusBarClient : NSObject
+ (void)showStatusBarQueryStr:(NSString *)tipStr;
+ (void)showStatusBarSuccessStr:(NSString *)tipStr;
+ (void)showStatusBarErrorStr:(NSString *)errorStr;
+ (void)showStatusBarWarnStr:(NSString *)tipStr;
+ (void)statusBarDismiss;
+ (void)showStatusBarProgress:(CGFloat)progress;
+ (void)showStatusBarProgress:(CGFloat)progress styleName:(NSString*)styleName;
+ (void)hiddenStatusBarProgress;
@end
