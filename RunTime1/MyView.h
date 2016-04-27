//
//  MyView.h
//  RunTime1
//
//  Created by 刘峰 on 16/3/29.
//  Copyright © 2016年 halovv. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyView : UIView<NSCoding>
{
    int _width;
    float _height;
}
@property(nonatomic,strong)UILabel *lab;
@property(nonatomic,strong)UITextView *text;
-(void)print:(NSString*)str;
@end
