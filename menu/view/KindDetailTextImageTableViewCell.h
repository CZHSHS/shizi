//
//  KindDetailTextImageTableViewCell.h
//  menu
//
//  Created by CZH on 2018/10/9.
//  Copyright © 2018年 CZH. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface KindDetailTextImageTableViewCell : UITableViewCell
@property(nonatomic,strong)UIImageView * image_V;
@property(nonatomic,strong)UILabel * info_lab;
-(void)reloadinfo:(NSDictionary *)dic;
@end

NS_ASSUME_NONNULL_END
