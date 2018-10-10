//
//  MenuKindsCollectionViewCell.m
//  menu
//
//  Created by 熠耀星空 on 2018/10/9.
//  Copyright © 2018年 熠耀星空. All rights reserved.
//

#import "MenuKindsCollectionViewCell.h"
#import <UIImageView+WebCache.h>
@implementation MenuKindsCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}
-(void)createUI{
    [self.contentView addSubview:self.image_view];
    self.image_view.frame = CGRectMake(10, 10, self.contentView.frame.size.width-20, self.contentView.frame.size.width-30);
    [self.image_view addSubview:self.name_lab];
    self.name_lab.frame = CGRectMake(0, self.image_view.frame.size.height-20, self.image_view.frame.size.width, 20);
}
-(void)reloaddata:(MenuKindsModel *)model{
    [self.image_view sd_setImageWithURL:[NSURL URLWithString:model.thumbnail] placeholderImage:[UIImage imageNamed:@"zanwu"]];
    self.name_lab.text = model.name;
}
- (UIImageView *)image_view{
    if (_image_view == nil) {
        _image_view = [[UIImageView alloc]init];
        _image_view.backgroundColor = [UIColor whiteColor];
    }
    return _image_view;
}
- (UILabel *)name_lab{
    if (_name_lab == nil) {
        _name_lab = [[UILabel alloc]init];
        _name_lab.textColor = [UIColor whiteColor];
        _name_lab.textAlignment = NSTextAlignmentCenter;
        _name_lab.backgroundColor = [UIColor blackColor];
        _name_lab.font = [UIFont systemFontOfSize:13];
    }
    return _name_lab;
}
@end
