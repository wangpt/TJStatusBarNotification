//
//  TJExampleController.m
//  TJStatusBarNotification
//
//  Created by tao on 2018/8/16.
//  Copyright © 2018年 王朋涛. All rights reserved.
//

#import "TJExampleController.h"
#import "TJStatusBarClient.h"
@interface TJExample : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) SEL selector;

@end


@implementation TJExample

+ (instancetype)exampleWithTitle:(NSString *)title selector:(NSString *)selector {
    TJExample *example = [[self class] new];
    example.title = title;
    example.selector = NSSelectorFromString(selector);
    return example;
}
@end

static NSString * const kTJCellReuseIdentifier = @"kTJCellReuseIdentifier";
static NSString * const TJStatusBarStyleProgress  = @"TJStatusBarStyleProgress";

@interface TJExampleController ()
@property (nonatomic, strong) NSArray<TJExample *> *examples;
@property (nonatomic, assign) CGFloat progress;
@property (nonatomic, weak) NSTimer *timer;

@end

@implementation TJExampleController
- (void)customStyle{
    [JDStatusBarNotification addStyleNamed:TJStatusBarStyleProgress
                                   prepare:^JDStatusBarStyle *(JDStatusBarStyle *style) {
                                       style.textColor = [UIColor whiteColor];
                                       style.barColor = [UIColor colorWithRed:199/255.0 green:36/255.0 blue:195/255.0 alpha:1.000];
                                       style.animationType = JDStatusBarAnimationTypeBounce;
                                       style.progressBarColor = [UIColor colorWithRed:245/255.0 green:45/255.0 blue:152/255.0 alpha:1.000];
                                       
                                       style.progressBarHeight = [[UIApplication sharedApplication] statusBarFrame].size.height;
                                       style.progressBarPosition = JDStatusBarProgressBarPositionTop;
                                       return style;
                                   }];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"JDStatusBarNotification";
    self.view.backgroundColor = [UIColor whiteColor];
    self.examples = @[[TJExample exampleWithTitle:@"loading" selector:@"loadExample"],
                      [TJExample exampleWithTitle:@"success" selector:@"successExample"],
                      [TJExample exampleWithTitle:@"error" selector:@"errorExample"],
                      [TJExample exampleWithTitle:@"warn" selector:@"warnExample"],
                      [TJExample exampleWithTitle:@"progress" selector:@"progressExample"],
                      [TJExample exampleWithTitle:@"custom" selector:@"customExample"],

                      ];
    [self.tableView registerClass:UITableViewCell.class forCellReuseIdentifier:kTJCellReuseIdentifier];
    [self customStyle];
}
#pragma mark - Examples
- (void)loadExample{
    [TJStatusBarClient showStatusBarQueryStr:@"加载中..."];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [TJStatusBarClient statusBarDismiss];
    });
}

-(void)successExample{
    [TJStatusBarClient showStatusBarSuccessStr:@"加载成功"];
}

- (void)errorExample{
    [TJStatusBarClient showStatusBarErrorStr:@"加载失败"];
}

- (void)warnExample{
    [TJStatusBarClient showStatusBarWarnStr:@"参数有误"];

}
- (void)progressExample {
    // This just increases the progress indicator in a loop.
    [TJStatusBarClient showStatusBarProgress:self.progress];
    if (self.progress < 1.0) {
        CGFloat step = 0.02;
        self.timer = [NSTimer scheduledTimerWithTimeInterval:step target:self
                                                    selector:@selector(progressExample)
                                                    userInfo:nil repeats:NO];
        self.progress += step;
    } else {
        [JDStatusBarNotification dismissAfter:0.5];
    }
}
- (void)customExample{
    [TJStatusBarClient showStatusBarProgress:self.progress styleName:TJStatusBarStyleProgress];
    if (self.progress < 1.0) {
        CGFloat step = 0.02;
        self.timer = [NSTimer scheduledTimerWithTimeInterval:step target:self
                                                    selector:@selector(progressExample)
                                                    userInfo:nil repeats:NO];
        self.progress += step;
    } else {
        [JDStatusBarNotification dismissAfter:0.5];
    }
    
}
#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.examples.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kTJCellReuseIdentifier forIndexPath:indexPath];
    TJExample *example = self.examples[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@ - %@",example.title,NSStringFromSelector(example.selector)];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    TJExample *example = self.examples[indexPath.row];
    self.progress = 0.0f;
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    [self performSelector:example.selector];
#pragma clang diagnostic pop
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    });
}

@end
