//
//  ShiPuDetailViewController.m
//  menu
//
//  Created by CZH on 2018/10/10.
//  Copyright © 2018年 CZH. All rights reserved.
//

#import "ShiPuDetailViewController.h"
#import <WebKit/WebKit.h>
#import <SVProgressHUD.h>
@interface ShiPuDetailViewController ()<WKNavigationDelegate,WKUIDelegate>
@property(nonatomic,strong)WKWebView * webView;
@end

@implementation ShiPuDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.webView = [[WKWebView alloc] initWithFrame:self.view.frame];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://wp.asopeixun.com/?p=%@",self.ID]]]];
    self.webView.navigationDelegate = self;
    self.webView.UIDelegate = self;
    //开了支持滑动返回
    self.webView.allowsBackForwardNavigationGestures = YES;
    [self.view addSubview:self.webView];

    
}
// 页面开始加载时调用
-(void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    [SVProgressHUD showWithStatus:@"正在加载"];
}
// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{//这里修改导航栏的标题，动态改变
    self.title = webView.title;
    [SVProgressHUD showSuccessWithStatus:@"加载成功"];
}
// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation{
    [SVProgressHUD showErrorWithStatus:@"加载失败"];
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
