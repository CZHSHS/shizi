//
//  ShiPuViewController.m
//  menu
//
//  Created by CZH on 2018/10/10.
//  Copyright © 2018年 CZH. All rights reserved.
//

#import "ShiPuViewController.h"
#import "Header.h"
#import "ShiPuTableViewCell.h"
#import "HttpTool.h"
#import "ShiPuModel.h"
#import "ShiPuDetailViewController.h"
#import <SVProgressHUD.h>
#import "ViewController.h"
@interface ShiPuViewController ()<UITableViewDataSource,UITableViewDelegate,UIPickerViewDelegate,UIPickerViewDataSource>
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSMutableArray * dataSource;
@property(nonatomic,copy)NSString * ID;
@property(nonatomic,strong)UIPickerView * pickerView;
@property(nonatomic,strong)NSArray * type_arr;
@property(nonatomic,strong)UIView * picker_back_view;
@end

@implementation ShiPuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"yome_service_publish_upload_btn"] forBarMetrics:0];
    self.title = @"饮食资讯";
    self.ID = @"135";
    [self creatUI];
    [self creatDataSource];
    
    [self creatNav];
    
    [self creatPickerDataSource];
    [self creatPicker];
}
-(void)creatPicker{
    
    [self.view addSubview:self.picker_back_view];
    self.picker_back_view.frame = CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.height);
    UITapGestureRecognizer *tapGesturRecognizer=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(picker_back_viewClicked)];
    [self.picker_back_view addGestureRecognizer:tapGesturRecognizer];
    self.picker_back_view.userInteractionEnabled=YES;
    
    self.pickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, self.picker_back_view.frame.size.height-200, self.picker_back_view.frame.size.width, 200)];
    self.pickerView.delegate = self;
    self.pickerView.dataSource = self;
    self.pickerView.backgroundColor = [UIColor whiteColor];
    [self.picker_back_view addSubview:self.pickerView];
}
-(void)picker_back_viewClicked{
    [UIView animateWithDuration:0.3 animations:^{
        self.picker_back_view.frame = CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.height);
    }];
}
-(void)creatPickerDataSource{
    self.type_arr = @[@"养生",@"减肥",@"气功",@"美容",@"瘦身",@"健身",@"日料"];
}
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return self.type_arr.count;
}
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return self.type_arr[row];
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
//    NSLog(@"%@",[self.type_arr objectAtIndex:row]);
    switch (row) {
        case 0:
            //养生
            self.ID = @"135";
            break;
        case 1:
            //减肥
            self.ID = @"1";
            break;
        case 2:
            //减肥
            self.ID = @"20";
            break;
        case 3:
            //减肥
            self.ID = @"40";
            break;
        case 4:
            //瘦身
            self.ID = @"100";
            break;
        case 5:
            //健身
            self.ID = @"150";
            break;
        case 6:
            //日料
            self.ID = @"160";
            break;
        default:
            break;
    }
    [self.dataSource removeAllObjects];
    
    [self creatDataSource];
    
}

-(void)creatNav{
    UIButton *releaseButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [releaseButton setTitle:@"菜谱" forState:normal];
    [releaseButton addTarget:self action:@selector(releaseInfo) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *releaseButtonItem = [[UIBarButtonItem alloc] initWithCustomView:releaseButton];
    self.navigationItem.rightBarButtonItem = releaseButtonItem;
    
    UIButton *morebutton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [morebutton setTitle:@"更多" forState:normal];
    [morebutton addTarget:self action:@selector(moreInfo) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *morebuttonButtonItem = [[UIBarButtonItem alloc] initWithCustomView:morebutton];
    self.navigationItem.leftBarButtonItem = morebuttonButtonItem;
}
-(void)moreInfo{
    [UIView animateWithDuration:0.3 animations:^{
        self.picker_back_view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    }];
}
-(void)releaseInfo{
    ViewController * view = [[ViewController alloc]init];
    [self.navigationController pushViewController:view animated:YES];
}
-(void)creatDataSource{
    [SVProgressHUD showWithStatus:@"正在加载"];
    [HttpTool getWithURLString:[NSString stringWithFormat:@"http://wp.asopeixun.com:5000/get_post_from_category_id?category_id=%@",self.ID] parameters:@{} success:^(id date) {
        NSDictionary * dic = date;
        if ([[NSString stringWithFormat:@"%@",dic[@"error_code"]] isEqualToString:@"0"]) {
            NSArray * list = dic[@"list"][0][@"list"];
            for (NSDictionary * data_dic in list) {
                ShiPuModel * model = [ShiPuModel new];
                [model setValuesForKeysWithDictionary:data_dic];
                [self.dataSource addObject:model];
            }
            [self.tableView reloadData];
            [SVProgressHUD dismiss];
        }else{
//            NSLog(@"%@",dic[@"error"]);
            [SVProgressHUD showErrorWithStatus:dic[@"error"]];
        }
        [UIView animateWithDuration:0.3 animations:^{
            self.picker_back_view.frame = CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.height);
        }];
    } failure:^(NSError * _Nonnull error) {
        [UIView animateWithDuration:0.3 animations:^{
            self.picker_back_view.frame = CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.height);
        }];
    }];
}
-(void)creatUI{
    self.tableView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-64);
    [self.view addSubview:self.tableView];
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ShiPuTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[ShiPuTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    ShiPuModel * model = self.dataSource[indexPath.row];
    [cell reloadData:model];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ShiPuModel * model = self.dataSource[indexPath.row];
    ShiPuDetailViewController * detail = [[ShiPuDetailViewController alloc]init];
    detail.ID = model.ID;
    [self.navigationController pushViewController:detail animated:YES];
}
-(UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor whiteColor];
    }
    return _tableView;
}
- (NSMutableArray *)dataSource{
    if (_dataSource == nil) {
        _dataSource = [NSMutableArray new];
    }
    return _dataSource;
}
-(UIView *)picker_back_view{
    if (_picker_back_view == nil) {
        _picker_back_view = [[UIView alloc]init];
        _picker_back_view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    }
    return _picker_back_view;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
