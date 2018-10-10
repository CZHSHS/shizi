//
//  KindDetailTextTableViewCell.m
//  menu
//
//  Created by 熠耀星空 on 2018/10/9.
//  Copyright © 2018年 熠耀星空. All rights reserved.
//

#import "KindDetailTextTableViewCell.h"
#import "Header.h"
#import "CZHTool.h"
@implementation KindDetailTextTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self creatUI];
    }
    return self;
}
-(void)creatUI{
    
    [self.contentView addSubview:self.info_lab];
    
}
-(void)reloadinfo:(NSDictionary *)dic{
    self.info_lab.text = dic[@"step"];
    self.info_lab.frame = CGRectMake(20, 0, SCREEN_WIDTH-40, [CZHTool getLabelHeightWithText:self.info_lab.text width:SCREEN_WIDTH-40 font:13]);
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
