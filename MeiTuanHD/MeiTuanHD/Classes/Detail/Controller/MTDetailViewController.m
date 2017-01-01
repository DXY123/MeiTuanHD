//
//  MTDetailViewController.m
//  MeiTuanHD
//
//  Created by DXY on 16/12/29.
//  Copyright © 2016年 DXY. All rights reserved.
//

#import "MTDetailViewController.h"
//自定义导航
#import "MTDetailNavView.h"
//详情中间的View
#import "MTDetailCenterView.h"

#import "MTDealModel.h"

@interface MTDetailViewController ()<DPRequestDelegate,UIWebViewDelegate>

//自定义导航的view
@property(nonatomic,strong) MTDetailNavView * detailNavView;
//详情中间的View
@property(nonatomic,strong) MTDetailCenterView * detailCenterView;
//webView
@property(nonatomic,strong) UIWebView * webView;

@end

@implementation MTDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpUI];
    [self loadData];
}

#pragma mark - 加载数据
- (void)loadData{
    //实例化
    DPAPI * api = [DPAPI new];
    //请求参数
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    
    params[@"deal_id"] = self.dealModel.deal_id;
    
    //发送请求
    [api requestWithURL:@"v1/deal/get_single_deal" params:params delegate:self];
    
}

#pragma mark - DPRequestDelegate
//成功
- (void)request:(DPRequest *)request didFinishLoadingWithResult:(id)result{
    NSLog(@"请求成功:%@",result);
    self.dealModel = [MTDealModel yy_modelWithJSON:[result[@"deals"] firstObject]];
    
    //赋值
    self.detailCenterView.dealModel = self.dealModel;
    
}

//请求失败
-(void)request:(DPRequest *)request didFailWithError:(NSError *)error{
    NSLog(@"请求失败:%@",error);
}


#pragma mark - 监听方法
//自定义navView的返回按钮点击事件
- (void)backClick{
    [self dismissViewControllerAnimated:true completion:nil];
}

#pragma mark - 设置视图
- (void)setUpUI{
    self.view.backgroundColor = HMColor(240, 240, 240);
    //添加控件
    [self.view addSubview:self.detailNavView];
    [self.view addSubview:self.detailCenterView];
    [self.view addSubview:self.webView];
    
    [self.detailNavView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.view);
        make.size.equalTo(CGSizeMake(400, 64));
    }];
    
    [self.detailCenterView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.detailNavView);
        make.top.equalTo(self.detailNavView.mas_bottom);
        make.bottom.equalTo(self.view);
    }];
    
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.bottom.equalTo(self.view);
        make.left.equalTo(self.detailNavView.mas_right).offset(20);
    }];
    
}


#pragma mark - UIWebViewDelegate
//想要拿到更多详情页面的网址,需要使用代理
//http://m.dianping.com/tuan/deal/moreinfo/15982763
//http://m.dianping.com/tuan/deal/moreinfo/20514039
//将要加载request
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
//    NSLog(@"urlString%@",request.URL.absoluteString);
    
    
    return true;
}


-(void)webViewDidFinishLoad:(UIWebView *)webView{
    //js 注入语句
    NSMutableString * js = [[NSMutableString alloc]init];
    //删除头部 图文详情描述
    [js appendString:@"var header = document.getElementsByTagName('header')[0];header.parentElement.removeChild(header);"];
    
     //删除顶部"立即购买"
    [js appendString:@"var box = document.getElementsByClassName('cost-box')[0];box.parentElement.removeChild(box);"];
    
    //删除底部大众点评相关信息
    [js appendString:@"var footer = document.getElementsByClassName('footer')[0];footer.parentElement.removeChild(footer);"];
    
    //删除底部 价格和"立即购买"
    [js appendString:@"var buy = document.getElementsByClassName('buy-now')[0];buy.parentElement.removeChild(buy);"];
    
    [webView stringByEvaluatingJavaScriptFromString:js];
    
}

/*
 
 //删除头部标题栏"图文详情"
 var header = document.getElementsByTagName('header')[0];header.parentElement.removeChild(header);
 
 //删除顶部"立即购买"
 var box = document.getElementsByClassName('cost-box')[0];box.parentElement.removeChild(box);
 
 //删除底部大众点评相关信息
 var footer = document.getElementsByClassName('footer')[0];footer.parentElement.removeChild(footer);
 
 //删除底部 价格和"立即购买"
 var buy = document.getElementsByClassName('buy-now')[0];buy.parentElement.removeChild(buy);
 
 */


#pragma mark - 懒加载
- (MTDetailNavView *)detailNavView{
    if (!_detailNavView) {
        WeakSelf(MTDetailViewController);
        _detailNavView = [MTDetailNavView new];
        [_detailNavView setDetailNavViewBlock:^{
            [weakSelf backClick];
        }];
    }
    return _detailNavView;
}

- (MTDetailCenterView *)detailCenterView{
    if (!_detailCenterView) {
        _detailCenterView = [MTDetailCenterView new];
    }
    return _detailCenterView;
}

-(UIWebView *)webView{
    if (!_webView) {
        _webView = [UIWebView new];
        _webView.delegate = self;
        //增加边距
        _webView.scrollView.contentInset = UIEdgeInsetsMake(20, 0, 20, 0);
        _webView.backgroundColor = HMColor(240, 240, 240);
        
        //deal_id:8-21551250
        //获取range
        NSRange range = [self.dealModel.deal_id rangeOfString:@"-"];
        //dealID
        NSString * dealId = [self.dealModel.deal_id substringFromIndex:range.location + range.length];
        //更多图文详情的网址
        NSString * dealUrlString = [NSString stringWithFormat:@"http://m.dianping.com/tuan/deal/moreinfo/%@",dealId];
        
        
        
        //加载页面
        [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:dealUrlString]]];
    }
    return _webView;
}

@end
