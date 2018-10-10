//
//  ShiPuTableViewCell.m
//  menu
//
//  Created by 熠耀星空 on 2018/10/10.
//  Copyright © 2018年 熠耀星空. All rights reserved.
//

#import "ShiPuTableViewCell.h"
#import "Header.h"
#import <UIImageView+WebCache.h>
#import "CZHTool.h"
@implementation ShiPuTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self creatUI];
    }
    return self;
}
-(void)creatUI{
    
    [self.contentView addSubview:self.image_V];
    self.image_V.frame = CGRectMake(20, 10, 80, 60);
    
    [self.contentView addSubview:self.title_lab];
    self.title_lab.frame = CGRectMake(CGRectGetMaxX(self.image_V.frame)+10, self.image_V.frame.origin.y, SCREEN_WIDTH - 20 - self.image_V.frame.size.width - 10 - 20, 40);
    
    [self.contentView addSubview:self.sub_title_lab];
    self.sub_title_lab.frame = CGRectMake(self.title_lab.frame.origin.x, CGRectGetMaxY(self.title_lab.frame)+5, self.title_lab.frame.size.width/2, 20);
    
    [self.contentView addSubview:self.time_lab];
    self.time_lab.frame = CGRectMake(CGRectGetMaxX(self.sub_title_lab.frame), self.sub_title_lab.frame.origin.y, self.sub_title_lab.frame.size.width, 20);
}
- (void)reloadData:(ShiPuModel *)model{
    [self.image_V sd_setImageWithURL:[NSURL URLWithString:model.thumb]];
    
    self.title_lab.text = model.title;
    
    self.sub_title_lab.text = model.subcatename;
    self.time_lab.text = [[NSString stringWithFormat:@"%@",model.edittime] substringWithRange:NSMakeRange(0, 10)];;
}
-(UILabel *)time_lab{
    if (_time_lab == nil) {
        _time_lab = [[UILabel alloc]init];
        _time_lab.textColor = [UIColor blackColor];
        _time_lab.numberOfLines = 1;
        _time_lab.textAlignment = NSTextAlignmentRight;
        _time_lab.font = [UIFont systemFontOfSize:13];
    }
    return _time_lab;
}
-(UILabel *)sub_title_lab{
    if (_sub_title_lab == nil) {
        _sub_title_lab = [[UILabel alloc]init];
        _sub_title_lab.textColor = [UIColor grayColor];
        _sub_title_lab.numberOfLines = 1;
        _sub_title_lab.font = [UIFont systemFontOfSize:13];
    }
    return _sub_title_lab;
}
-(UILabel *)title_lab{
    if (_title_lab == nil) {
        _title_lab = [[UILabel alloc]init];
        _title_lab.textColor = [UIColor blackColor];
        _title_lab.numberOfLines = 2;
        _title_lab.font = [UIFont boldSystemFontOfSize:15];
    }
    return _title_lab;
}
-(UIImageView *)image_V{
    if (_image_V == nil) {
        _image_V = [[UIImageView alloc]init];
        _image_V.backgroundColor = [UIColor whiteColor];
    }
    return _image_V;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
