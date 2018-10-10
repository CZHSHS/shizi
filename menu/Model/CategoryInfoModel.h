//
//  CategoryInfoModel.h
//  menu
//
//  Created by CZH on 2018/10/9.
//  Copyright © 2018年 CZH. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CategoryInfoModel : NSObject
@property(nonatomic,copy)NSString * ctgId;
@property(nonatomic,copy)NSString * name;
@property(nonatomic,copy)NSString * parentId;
@end

NS_ASSUME_NONNULL_END
