//
//  MyView+catagory1.m
//  RunTime1
//
//  Created by 刘峰 on 16/3/30.
//  Copyright © 2016年 halovv. All rights reserved.
//

#import "MyView+catagory1.h"
#import <objc/runtime.h>
#import <objc/message.h>

@implementation MyView (catagory1)
+(void)load
{
//    方法置换用在类别加载过程中
    Method method1 = class_getInstanceMethod([MyView class], @selector(print:));
    Method method2 = class_getInstanceMethod([MyView class], @selector(print1:));
    method_exchangeImplementations(method1, method2);
}
-(void)print1:(NSString*)str
{
    if ([str isEqualToString:@"hello"])
    {
        NSLog(@"hello,world");
    }
    else
    {NSLog(@"%@",str);}
}
@end
