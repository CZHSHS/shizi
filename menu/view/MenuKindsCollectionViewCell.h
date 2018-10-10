//
//  MenuKindsCollectionViewCell.h
//  menu
//
//  Created by CZH on 2018/10/9.
//  Copyright © 2018年 CZH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuKindsModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface MenuKindsCollectionViewCell : UICollectionViewCell
@property(nonatomic,strong)UIImageView * image_view;
@property(nonatomic,strong)UILabel * name_lab;
-(void)reloaddata:(MenuKindsModel *)model;
@end

NS_ASSUME_NONNULL_END
