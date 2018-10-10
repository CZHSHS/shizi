//
//  MenuKindsModel.h
//  menu
//
//  Created by 熠耀星空 on 2018/10/9.
//  Copyright © 2018年 熠耀星空. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MenuKindsModel : NSObject
@property(nonatomic,strong)NSArray * ctgIds;
@property(nonatomic,copy)NSString * ctgTitles;
@property(nonatomic,copy)NSString * menuId;
@property(nonatomic,copy)NSString * name;

/**
 图片
 */
@property(nonatomic,copy)NSString * thumbnail;

/**
 步骤
 */
@property(nonatomic,copy)NSDictionary * recipe;
@end

NS_ASSUME_NONNULL_END
