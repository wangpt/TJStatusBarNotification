//
//  TJStatusBarClient.m
//  TJStatusBarNotification
//
//  Created by 王朋涛 on 16/9/9.
//  Copyright © 2016年 王朋涛. All rights reserved.
//

#import "TJStatusBarClient.h"

@implementation TJStatusBarClient

+ (void)showStatusBarQueryStr:(NSString *)tipStr{
    [JDStatusBarNotification showWithStatus:tipStr styleName:JDStatusBarStyleSuccess];
    [JDStatusBarNotification showActivityIndicator:YES indicatorStyle:UIActivityIndicatorViewStyleWhite];
}

+ (void)showStatusBarSuccessStr:(NSString *)tipStr{
    if ([JDStatusBarNotification isVisible]) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [JDStatusBarNotification showActivityIndicator:NO indicatorStyle:UIActivityIndicatorViewStyleWhite];
            [JDStatusBarNotification showWithStatus:tipStr dismissAfter:1.5 styleName:JDStatusBarStyleSuccess];
        });
    }else{
        [JDStatusBarNotification showActivityIndicator:NO indicatorStyle:UIActivityIndicatorViewStyleWhite];
        [JDStatusBarNotification showWithStatus:tipStr dismissAfter:1.0 styleName:JDStatusBarStyleSuccess];
    }
}

+ (void)showStatusBarErrorStr:(NSString *)errorStr{
    if ([JDStatusBarNotification isVisible]) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [JDStatusBarNotification showActivityIndicator:NO indicatorStyle:UIActivityIndicatorViewStyleWhite];
            [JDStatusBarNotification showWithStatus:errorStr dismissAfter:1.5 styleName:JDStatusBarStyleError];
        });
    }else{
        [JDStatusBarNotification showActivityIndicator:NO indicatorStyle:UIActivityIndicatorViewStyleWhite];
        [JDStatusBarNotification showWithStatus:errorStr dismissAfter:1.5 styleName:JDStatusBarStyleError];
    }
}

+ (void)showStatusBarWarnStr:(NSString *)tipStr{
    if ([JDStatusBarNotification isVisible]) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [JDStatusBarNotification showActivityIndicator:NO indicatorStyle:UIActivityIndicatorViewStyleWhite];
            [JDStatusBarNotification showWithStatus:tipStr dismissAfter:1.5 styleName:JDStatusBarStyleWarning];
        });
    }else{
        [JDStatusBarNotification showActivityIndicator:NO indicatorStyle:UIActivityIndicatorViewStyleWhite];
        [JDStatusBarNotification showWithStatus:tipStr dismissAfter:1.0 styleName:JDStatusBarStyleWarning];
    }
}
+ (void)statusBarDismiss{
    [JDStatusBarNotification dismiss];
}

+ (void)showStatusBarProgress:(CGFloat)progress{
    if(![JDStatusBarNotification isVisible]) {
        [JDStatusBarNotification showWithStatus:@"请稍等..." styleName:JDStatusBarStyleDefault];
    }
    [JDStatusBarNotification showProgress:progress];
}

+ (void)showStatusBarProgress:(CGFloat)progress styleName:(NSString*)styleName{
    if(![JDStatusBarNotification isVisible]) {
        [JDStatusBarNotification showWithStatus:@"请稍等..." styleName:styleName];
    }
    [JDStatusBarNotification showProgress:progress];
}

+ (void)hiddenStatusBarProgress{
    [JDStatusBarNotification showProgress:0.0];
}



@end
