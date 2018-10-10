//
//  CZHTool.m
//  menu
//
//  Created by CZH on 2018/10/9.
//  Copyright © 2018年 CZH. All rights reserved.
//

#import "CZHTool.h"

@implementation CZHTool
+ (CGFloat)getLabelHeightWithText:(NSString *)text width:(CGFloat)width font: (CGFloat)font
{
    UIFont * text_font = [UIFont systemFontOfSize:font];
    if(NSFoundationVersionNumber >= NSFoundationVersionNumber_iOS_9_0) {
        text_font = [UIFont fontWithName:@"PingFangSC-Regular"size:font];
        
    }
    CGRect rect = [text boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:text_font} context:nil];
    
    return rect.size.height;
}
+ (CGFloat)getLabelWidthWithText:(NSString *)text width:(CGFloat)width font: (CGFloat)font
{
    UIFont * text_font = [UIFont systemFontOfSize:font];
    if(NSFoundationVersionNumber >= NSFoundationVersionNumber_iOS_9_0) {
        text_font = [UIFont fontWithName:@"PingFangSC-Regular"size:font];
        
    }
    CGRect rect = [text boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:text_font} context:nil];
    
    return rect.size.width;
}
@end
