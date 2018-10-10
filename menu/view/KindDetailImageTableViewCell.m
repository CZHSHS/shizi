//
//  KindDetailImageTableViewCell.m
//  menu
//
//  Created by CZH on 2018/10/9.
//  Copyright © 2018年 CZH. All rights reserved.
//

#import "KindDetailImageTableViewCell.h"
#import <UIImageView+WebCache.h>
#import "Header.h"
@implementation KindDetailImageTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self creatUI];
    }
    return self;
}
-(void)creatUI{
    [self.contentView addSubview:self.image_V];
    
}
-(void)reloadInfo:(NSDictionary *)dic{
    self.image_V.frame = CGRectMake(0, 0, SCREEN_WIDTH/2, SCREEN_WIDTH/2);
    [self.image_V sd_setImageWithURL:[NSURL URLWithString:dic[@"img"]]];
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
