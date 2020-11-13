//
//  ViewController.m
//  ceshitimer
//
//  Created by UED on 2020/11/13.
//

#import "ViewController.h"
#import "LQGCDTimer.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[LQGCDTimer shareHandler] autoStartTimerWithMark:@"dingshiqi1" timeInterval:1 acceptable:0 handler:^{
        NSLog(@"11111111");
    }];
    [[LQGCDTimer shareHandler] autoStartTimerWithMark:@"dingshiqi2" timeInterval:2 acceptable:0 handler:^{
        NSLog(@"22222222");
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [[LQGCDTimer shareHandler] stopAllTimer];
}
- (IBAction)startAction:(id)sender {
    [[LQGCDTimer shareHandler] handStartWithMark:@"dingshiqi1"];
}
- (IBAction)susperAction:(id)sender {
    [[LQGCDTimer shareHandler] suspendTimerWithMark:@"dingshiqi1"];
}
- (IBAction)stopAction:(id)sender {
    [[LQGCDTimer shareHandler] stopTimerWithMark:@"dingshiqi1"];
}

@end
