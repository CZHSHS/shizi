//
//  KindDetailTextImageTableViewCell.m
//  menu
//
//  Created by CZH on 2018/10/9.
//  Copyright © 2018年 CZH. All rights reserved.
//

#import "KindDetailTextImageTableViewCell.h"
#import "Header.h"
#import <UIImageView+WebCache.h>
#import "CZHTool.h"
@implementation KindDetailTextImageTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self creatUI];
    }
    return self;
}
-(void)creatUI{
    
    [self.contentView addSubview:self.image_V];
    [self.contentView addSubview:self.info_lab];
    
}
-(void)reloadinfo:(NSDictionary *)dic{
    self.image_V.frame = CGRectMake(SCREEN_WIDTH/4, 0, SCREEN_WIDTH/2, SCREEN_WIDTH/2);
    [self.image_V sd_setImageWithURL:dic[@"img"]];
    self.info_lab.text = dic[@"step"];
    self.info_lab.frame = CGRectMake(20, CGRectGetMaxY(self.image_V.frame)+10, SCREEN_WIDTH-40, [CZHTool getLabelHeightWithText:self.info_lab.text width:SCREEN_WIDTH-40 font:13]);
}
-(UIImageView *)image_V{
    if (_image_V == nil) {
        _image_V = [[UIImageView alloc]init];
        _image_V.backgroundColor = [UIColor whiteColor];
    }
    return _image_V;
}
-(UILabel *)info_lab{
    if (_info_lab == nil) {
        _info_lab = [[UILabel alloc]init];
        _info_lab.textColor = [UIColor blackColor];
        _info_lab.backgroundColor = [UIColor whiteColor];
        _info_lab.font = [UIFont systemFontOfSize:13];
        _info_lab.numberOfLines = 0;
    }
    return _info_lab;
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
