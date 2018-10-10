//
//  MenuKindsCollectionViewCell.h
//  menu
//
//  Created by 熠耀星空 on 2018/10/9.
//  Copyright © 2018年 熠耀星空. All rights reserved.
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
