//
//  ViewController.m
//  RunTime1
//
//  Created by 刘峰 on 16/3/29.
//  Copyright © 2016年 halovv. All rights reserved.
//

#import "ViewController.h"
#import <objc/message.h>
#import <objc/runtime.h>
#import "MyView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    MyView *aView = [[MyView alloc] initWithFrame:CGRectMake(10, 10, 100, 200)];
    aView.backgroundColor = [UIColor cyanColor];
    [aView print:@"你好"];
    [aView print:@"hello"];
    [self.view addSubview:aView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
