//
//  MyView.m
//  RunTime1
//
//  Created by 刘峰 on 16/3/29.
//  Copyright © 2016年 halovv. All rights reserved.
//

#import "MyView.h"
#import <objc/runtime.h>
@implementation MyView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
//runtime解码
-(id)initWithCoder:(NSCoder *)aDecoder
{
   self = [super initWithCoder:aDecoder];
    unsigned int count = 0;
    objc_property_t *propertys = class_copyPropertyList([self class], &count);
    for (int i = 0; i < count; i ++)
    {
        objc_property_t property = propertys[i];
        const char *name = property_getName(property);
        NSString *key = [NSString stringWithUTF8String:name];
        [self setValue:[aDecoder decodeObjectForKey:key] forKey:key];
    }
    return self;
}
//runtime编码
-(void)encodeWithCoder:(NSCoder *)aCoder
{
    unsigned count = 0;
    objc_property_t *propertys = class_copyPropertyList([self class], &count);
    for (int i = 0; i < count; i ++) {
        objc_property_t property = propertys[i];
        const char *name = property_getName(property);
        NSString *key = [NSString stringWithUTF8String:name];
        [aCoder encodeObject:[aCoder decodeObjectForKey:key] forKey:key];
    }
}
-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self ivarList];
        [self propertyList];
        [self methodList];
    }
    return self;
}

-(void)methodList
{
    uint count;
    Method *methods = class_copyMethodList([self class], &count);
    for (int i = 0; i < count; i ++) {
        Method method = methods[i];
        SEL sel = method_getName(method);
        NSString *name = NSStringFromSelector(sel);
        NSLog(@"%@",name);
    }
}
-(void)ivarList
{
    //    objc_getClass(<#const char *name#>)
    //    objc_getProtocol(<#const char *name#>)
    //    objc_msgSend()
    //    class_copyPropertyList([instance
    //                            class], &outCount);
    //    class_copyIvarList(id self, unsigned int *outCount)
    
    unsigned int count = 0;
    //    变量列表
    Ivar *ivars = class_copyIvarList([MyView class], &count);//获得成员变量列表的指针，带*
    for (int i = 0; i < count; i ++) {
        Ivar ivar = ivars[i];//成员变量不带*
        const char *ivarName = ivar_getName(ivar);//名称
        NSString *ivarNameOc = [NSString stringWithUTF8String:ivarName];
        NSLog(@"%@",ivarNameOc);//转换成oc对象
    }
}

-(void)propertyList
{
//    objc_setAssociatedObject(self, @"NSData", @"data", OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, "objTag", @"value", OBJC_ASSOCIATION_COPY);
//    objc_setAssociatedObject按键值形式添加属性
    NSString *value = objc_getAssociatedObject(self, "objTag");
//    objc_getAssociatedObject 获取属性
    NSLog(@"通过Associate设置:%@",value);
    unsigned int count = 0;
    objc_property_t *propertys = class_copyPropertyList([self class], &count);
    for (int i = 0; i < count; i ++)
    {
        objc_property_t property = propertys[i];
        const char *propName = property_getName(property);
        NSString *propNameOc = [NSString stringWithUTF8String:propName];
        NSLog(@"%@",propNameOc);
    }
    
}

-(void)print:(NSString*)str
{
    NSLog(@"%@",str);
}
@end
