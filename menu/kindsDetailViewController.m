//
//  kindsDetailViewController.m
//  menu
//
//  Created by 熠耀星空 on 2018/10/9.
//  Copyright © 2018年 熠耀星空. All rights reserved.
//

#import "kindsDetailViewController.h"
#import "KindDetailImageTableViewCell.h"
#import "KindDetailTextTableViewCell.h"
#import "KindDetailTextImageTableViewCell.h"
#import "Header.h"
#import "CZHTool.h"
#import <UIImageView+WebCache.h>
@interface kindsDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSMutableArray * dataSource;
@property(nonatomic,strong)UIView * header_view;
@property(nonatomic,strong)UILabel * title_label;
@property(nonatomic,strong)UILabel * info_label;
@property(nonatomic,strong)UILabel * sumary_label;
@property(nonatomic,strong)UIImageView * big_image;
@property(nonatomic,strong)UILabel * jieshao_label;
@property(nonatomic,strong)UILabel * zhunbei_label;
@property(nonatomic,strong)UILabel * buzhou_label;
@end

@implementation kindsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = self.name;
    
    
    [self creatDataSource];
    [self creatUI];
}
-(void)creatDataSource{
    for (NSDictionary * dic in [self stringToJSON:self.recipe[@"method"]]) {
        [self.dataSource addObject:dic];
    }
    [self.tableView reloadData];
}


-(void)creatUI{
    [self.view addSubview:self.tableView];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.frame = CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64);

    self.header_view.frame = CGRectMake(0, 0, self.tableView.frame.size.width, 70+[CZHTool getLabelHeightWithText:self.recipe[@"ingredients"] width:SCREEN_WIDTH-40 font:13]+[CZHTool getLabelHeightWithText:self.recipe[@"sumary"] width:SCREEN_WIDTH-40 font:13]+30+30+30+30);
    self.tableView.tableHeaderView = self.header_view;
    [self.header_view addSubview:self.title_label];
    self.title_label.frame = CGRectMake(0, 10, self.header_view.frame.size.width, 20);
    self.title_label.text = self.recipe[@"title"];
    
    [self.header_view addSubview:self.jieshao_label];
    self.jieshao_label.frame = CGRectMake(20, CGRectGetMaxY(self.title_label.frame)+10, SCREEN_WIDTH-40, 20);
    self.jieshao_label.text = @"简介";
    
    [self.header_view addSubview:self.sumary_label];
    self.sumary_label.frame = CGRectMake(20, CGRectGetMaxY(self.jieshao_label.frame)+10, SCREEN_WIDTH-40, [CZHTool getLabelHeightWithText:self.recipe[@"sumary"] width:SCREEN_WIDTH-40 font:13]);
    self.sumary_label.text = self.recipe[@"sumary"];
    
    NSString * big_image_url = self.recipe[@"img"];
    [self.header_view addSubview:self.big_image];
    if (big_image_url) {
        self.big_image.frame = CGRectMake(20, CGRectGetMaxY(self.sumary_label.frame)+10, self.tableView.frame.size.width-40, self.tableView.frame.size.width-40);
        self.header_view.frame = CGRectMake(0, 0, self.tableView.frame.size.width, 70+[CZHTool getLabelHeightWithText:self.recipe[@"ingredients"] width:SCREEN_WIDTH-40 font:13]+[CZHTool getLabelHeightWithText:self.recipe[@"sumary"] width:SCREEN_WIDTH-40 font:13]+self.tableView.frame.size.width-40+30+30+30+30);
        [self.big_image sd_setImageWithURL:[NSURL URLWithString:big_image_url]];
    }else{
        self.big_image.frame = CGRectMake(20, CGRectGetMaxY(self.sumary_label.frame)+10, self.tableView.frame.size.width-40, 0);
        [self.big_image sd_setImageWithURL:[NSURL URLWithString:big_image_url]];
        self.header_view.frame = CGRectMake(0, 0, self.tableView.frame.size.width, 70+[CZHTool getLabelHeightWithText:self.recipe[@"ingredients"] width:SCREEN_WIDTH-40 font:13]+[CZHTool getLabelHeightWithText:self.recipe[@"sumary"] width:SCREEN_WIDTH-40 font:13]+30+30+30+30);
    }
    
    [self.header_view addSubview:self.zhunbei_label];
    self.zhunbei_label.frame = CGRectMake(20, CGRectGetMaxY(self.big_image.frame)+10, SCREEN_WIDTH-40, 20);
    self.zhunbei_label.text = @"准备材料";
    
    [self.header_view addSubview:self.info_label];
    self.info_label.frame = CGRectMake(20, CGRectGetMaxY(self.zhunbei_label.frame)+10, self.tableView.frame.size.width-40, [CZHTool getLabelHeightWithText:self.recipe[@"ingredients"] width:SCREEN_WIDTH-40 font:13]+20);
    self.info_label.text = self.recipe[@"ingredients"];
    
    [self.header_view addSubview:self.buzhou_label];
    self.buzhou_label.frame = CGRectMake(20, CGRectGetMaxY(self.info_label.frame)+10, SCREEN_WIDTH-40, 20);
    self.buzhou_label.text = @"步骤";
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary * dic = self.dataSource[indexPath.row];
    if ([dic[@"img"] isKindOfClass:[NSString class]] && [dic[@"step"] isKindOfClass:[NSString class]]) {
        KindDetailTextImageTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"imageTextCell"];
        if (cell == nil) {
            cell = [[KindDetailTextImageTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"imageTextCell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell reloadinfo:dic];
        return cell;
    }else if ([dic[@"img"] isKindOfClass:[NSString class]] && ![dic[@"step"] isKindOfClass:[NSString class]]) {
        KindDetailImageTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"imageCell"];
        if (cell == nil) {
            cell = [[KindDetailImageTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"imageCell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell reloadInfo:dic];
        return cell;
    }else if (![dic[@"img"] isKindOfClass:[NSString class]] && [dic[@"step"] isKindOfClass:[NSString class]]) {
        KindDetailTextTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"textCell"];
        if (cell == nil) {
            cell = [[KindDetailTextTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"textCell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell reloadinfo:dic];
        return cell;
    }
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary * dic = self.dataSource[indexPath.row];
    if ([dic[@"img"] isKindOfClass:[NSString class]] && [dic[@"step"] isKindOfClass:[NSString class]]) {
        return SCREEN_WIDTH/2 + [CZHTool getLabelHeightWithText:dic[@"step"] width:SCREEN_WIDTH-40 font:13]+10;
    }else if ([dic[@"img"] isKindOfClass:[NSString class]] && ![dic[@"step"] isKindOfClass:[NSString class]]) {
        return SCREEN_WIDTH/2 + 10;
    }else if (![dic[@"img"] isKindOfClass:[NSString class]] && [dic[@"step"] isKindOfClass:[NSString class]]) {
        return [CZHTool getLabelHeightWithText:dic[@"step"] width:SCREEN_WIDTH-40 font:13]+10;
    }
    return 0;
}

- (NSArray *)stringToJSON:(NSString *)jsonStr {
    if (jsonStr) {
        id tmp = [NSJSONSerialization JSONObjectWithData:[jsonStr dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments | NSJSONReadingMutableLeaves | NSJSONReadingMutableContainers error:nil];
        
        if (tmp) {
            if ([tmp isKindOfClass:[NSArray class]]) {
                
                return tmp;
                
            } else if([tmp isKindOfClass:[NSString class]] || [tmp isKindOfClass:[NSDictionary class]]) {
                
                return [NSArray arrayWithObject:tmp];
                
            } else {
                return nil;
            }
        } else {
            return nil;
        }
        
    } else {
        return nil;
    }
}
-(NSMutableArray *)dataSource{
    if (_dataSource == nil) {
        _dataSource = [NSMutableArray new];
    }
    return _dataSource;
}
-(UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]init];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
    }
    return _tableView;
}
-(UIView *)header_view{
    if (_header_view == nil) {
        _header_view = [[UIView alloc]init];
        _header_view.backgroundColor = [UIColor whiteColor];
        
    }
    return _header_view;
}
-(UILabel *)title_label{
    if (_title_label == nil) {
        _title_label = [[UILabel alloc]init];
        _title_label.font = [UIFont boldSystemFontOfSize:15];
        _title_label.textAlignment = NSTextAlignmentCenter;
    }
    return _title_label;
}
-(UILabel *)info_label{
    if (_info_label == nil) {
        _info_label = [[UILabel alloc]init];
        _info_label.numberOfLines = 0;
        _info_label.textColor = [UIColor blackColor];
        _info_label.font = [UIFont systemFontOfSize:13];
    }
    return _info_label;
}
-(UILabel *)sumary_label{
    if (_sumary_label == nil) {
        _sumary_label = [[UILabel alloc]init];
        _sumary_label.numberOfLines = 0;
        _sumary_label.textColor = [UIColor blackColor];
        _sumary_label.font = [UIFont systemFontOfSize:13];
    }
    return _sumary_label;
}
-(UIImageView *)big_image{
    if (_big_image == nil) {
        _big_image = [[UIImageView alloc]init];
        _big_image.backgroundColor = [UIColor whiteColor];
    }
    return _big_image;
}
-(UILabel *)jieshao_label{
    if (_jieshao_label == nil) {
        _jieshao_label = [[UILabel alloc]init];
        _jieshao_label.textColor = [UIColor blackColor];
        _jieshao_label.font = [UIFont boldSystemFontOfSize:18];
        _jieshao_label.backgroundColor = [UIColor whiteColor];
    }
    return _jieshao_label;
}
- (UILabel *)zhunbei_label{
    if (_zhunbei_label == nil) {
        _zhunbei_label = [[UILabel alloc]init];
        _zhunbei_label.textColor = [UIColor blackColor];
        _zhunbei_label.font = [UIFont boldSystemFontOfSize:18];
        _zhunbei_label.backgroundColor = [UIColor whiteColor];
    }
    return _zhunbei_label;
}
- (UILabel *)buzhou_label{
    if (_buzhou_label == nil) {
        _buzhou_label = [[UILabel alloc]init];
        _buzhou_label.textColor = [UIColor blackColor];
        _buzhou_label.font = [UIFont boldSystemFontOfSize:18];
        _buzhou_label.backgroundColor = [UIColor whiteColor];
    }
    return _buzhou_label;
}
@end
