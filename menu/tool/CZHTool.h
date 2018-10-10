//
//  CZHTool.h
//  menu
//
//  Created by CZH on 2018/10/9.
//  Copyright © 2018年 CZH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface CZHTool : NSObject
/**
 获取label的高度
 
 @param text 文字内容
 @param width 最大宽度
 @param font 字体大小
 @return 高度
 */
+ (CGFloat)getLabelHeightWithText:(NSString *)text width:(CGFloat)width font: (CGFloat)font;

/**
 获取label宽度
 
 @param text 文字内容
 @param width 最大宽度
 @param font 字体大小
 @return 宽度
 */
+ (CGFloat)getLabelWidthWithText:(NSString *)text width:(CGFloat)width font: (CGFloat)font;
@end

NS_ASSUME_NONNULL_END
