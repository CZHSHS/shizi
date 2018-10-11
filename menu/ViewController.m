//
//  ViewController.m
//  menu
//
//  Created by CZH on 2018/10/9.
//  Copyright © 2018年 CZH. All rights reserved.
//

#import "ViewController.h"
#import "YQNetworkTools.h"
#import "HttpTool.h"
#import "Header.h"
#import "CategoryInfoModel.h"
#import "MenuKindsModel.h"
#import "MenuKindsCollectionViewCell.h"
#import <MJRefresh.h>
#import "kindsDetailViewController.h"
#import <SVProgressHUD.h>
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSMutableArray * dataSource;
@property(nonatomic,strong)NSMutableArray * title_arr;
@property(nonatomic,strong)NSMutableArray * kinds_dataSource;
@property(nonatomic,strong)UICollectionView * collectionView;
@property(nonatomic,copy)NSString * cid;
@property(nonatomic,assign)int page;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.page = 1;
    [self creatData];
    [self creatUI];
}
-(void)creatData{
    //http://apicloud.mob.com/v1/cook/category/query?key=28265b5a61274
    [HttpTool getWithURLString:@"http://apicloud.mob.com/v1/cook/category/query?key=28265b5a61274" parameters:@{} success:^(id dic) {
//        NSLog(@"%@",dic);
        NSDictionary * d = dic;
        NSArray * info_arr = d[@"result"][@"childs"];
        for (NSDictionary * for_dic in info_arr) {
            NSDictionary * title_dic = for_dic[@"categoryInfo"];
            CategoryInfoModel * title_model = [CategoryInfoModel new];
            [title_model setValuesForKeysWithDictionary:title_dic];
            [self.title_arr addObject:title_model];
            NSArray * arr = for_dic[@"childs"];
            NSMutableArray * a = [NSMutableArray new];
            for (NSDictionary * data_dic in arr) {
                NSDictionary * data = data_dic[@"categoryInfo"];
                CategoryInfoModel * model = [CategoryInfoModel new];
                [model setValuesForKeysWithDictionary:data];
                [a addObject:model];
            }
            [self.dataSource addObject:a];
            
            
        }
        CategoryInfoModel * model = self.dataSource[0][0];
        self.cid = model.ctgId;
        [self getMenuInfo:self.cid];
        [self.tableView reloadData];
    } failure:^(NSError * _Nonnull error) {
        
    }];
    
    
}
-(void)getMenuInfo:(NSString *)cid{
    [HttpTool getWithURLString:[NSString stringWithFormat:@"http://apicloud.mob.com/v1/cook/menu/search?key=28265b5a61274&cid=%@&page=%d&size=20",cid,self.page] parameters:@{} success:^(id data_dic) {
//        NSLog(@"%@",[NSString stringWithFormat:@"http://apicloud.mob.com/v1/cook/menu/search?key=28265b5a61274&cid=%@&page=%d&size=20",cid,self.page]);
        NSDictionary * dic = data_dic;
//        NSLog(@"%@",dic);
        NSString * retCode = dic[@"retCode"];
        if ([retCode isEqualToString:@"200"]) {
            NSArray * kinds_arr = dic[@"result"][@"list"];
            for (NSDictionary * for_dic in kinds_arr) {
                MenuKindsModel * model = [MenuKindsModel new];
                [model setValuesForKeysWithDictionary:for_dic];
                [self.kinds_dataSource addObject:model];
            }
            [self.collectionView reloadData];
            if (self.page == 0) {
                [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] atScrollPosition:UICollectionViewScrollPositionTop animated:YES];
            }
        }else{
            NSLog(@"%@",data_dic[@"msg"]);
            [SVProgressHUD showErrorWithStatus:data_dic[@"msg"]];
            
        }
    } failure:^(NSError * _Nonnull error) {
        
    }];
}
-(void)creatUI{
    [self.view addSubview:self.tableView];
    self.tableView.frame = CGRectMake(0, 0, SCREEN_WIDTH/3, SCREEN_HEIGHT);
    [self.view addSubview:self.collectionView];
    [self.collectionView registerClass:[MenuKindsCollectionViewCell class] forCellWithReuseIdentifier:@"kindCell"];
    self.collectionView.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.page = 0;
        [self getMenuInfo:self.cid];
        [self.collectionView.mj_header endRefreshing];
    }];
    
    self.collectionView.mj_footer = [MJRefreshAutoNormalFooter  footerWithRefreshingBlock:^{
        self.page++;
        [self getMenuInfo:self.cid];
        [self.collectionView.mj_footer endRefreshing];
    }];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataSource.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.dataSource[section] count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    CategoryInfoModel * model = self.dataSource[indexPath.section][indexPath.row];
    cell.textLabel.text = model.name;
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    return cell;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UILabel * title_lab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 30)];
    CategoryInfoModel * model = self.title_arr[section];
    title_lab.text = model.name;
    title_lab.textAlignment = NSTextAlignmentCenter;
    title_lab.font = [UIFont systemFontOfSize:13];
    title_lab.textColor = [UIColor orangeColor];
    title_lab.backgroundColor = [UIColor whiteColor];
    title_lab.layer.borderColor = [[UIColor orangeColor] CGColor];
    title_lab.layer.borderWidth = 0.5f;
    return title_lab;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.page = 0;
    [self.kinds_dataSource removeAllObjects];
    CategoryInfoModel * model = self.dataSource[indexPath.section][indexPath.row];
    self.cid = model.ctgId;
    [self getMenuInfo:self.cid];
    
}
#pragma collection
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.kinds_dataSource.count;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(SCREEN_WIDTH/3, SCREEN_WIDTH/3);
}
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    MenuKindsCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"kindCell" forIndexPath:indexPath];
    MenuKindsModel * model = self.kinds_dataSource[indexPath.row];
    [cell reloaddata:model];
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    MenuKindsModel * model = self.kinds_dataSource[indexPath.row];
    kindsDetailViewController * vc = [kindsDetailViewController new];
    vc.recipe = model.recipe;
    vc.name = model.name;
    [self.navigationController pushViewController:vc animated:YES];
}
-(NSMutableArray *)dataSource{
    if (_dataSource == nil) {
        _dataSource = [NSMutableArray new];
    }
    return _dataSource;
}
- (NSMutableArray *)title_arr{
    if (_title_arr == nil) {
        _title_arr = [NSMutableArray new];
    }
    return _title_arr;
}
-(NSMutableArray *)kinds_dataSource{
    if (_kinds_dataSource == nil) {
        _kinds_dataSource = [NSMutableArray new];
    }
    return _kinds_dataSource;
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
- (UICollectionView *)collectionView{
    if (_collectionView == nil) {
        UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/3, 0, SCREEN_WIDTH/3*2, SCREEN_HEIGHT) collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
    }
    return _collectionView;
}
@end
