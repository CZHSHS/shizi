//
//  KindDetailTextImageTableViewCell.h
//  menu
//
//  Created by 熠耀星空 on 2018/10/9.
//  Copyright © 2018年 熠耀星空. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface KindDetailTextImageTableViewCell : UITableViewCell
@property(nonatomic,strong)UIImageView * image_V;
@property(nonatomic,strong)UILabel * info_lab;
-(void)reloadinfo:(NSDictionary *)dic;
@end

NS_ASSUME_NONNULL_END
