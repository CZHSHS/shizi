//
//  ShiPuTableViewCell.h
//  menu
//
//  Created by CZH on 2018/10/10.
//  Copyright © 2018年 CZH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShiPuModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface ShiPuTableViewCell : UITableViewCell
@property(nonatomic,strong)UIImageView * image_V;
@property(nonatomic,strong)UILabel * title_lab;
@property(nonatomic,strong)UILabel * sub_title_lab;
@property(nonatomic,strong)UILabel * time_lab;
-(void)reloadData:(ShiPuModel *)model;
@end

NS_ASSUME_NONNULL_END
