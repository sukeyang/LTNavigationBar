//
//  ViewController.m
//  LTNavigationBar
//
//  Created by ltebean on 15-2-15.
//  Copyright (c) 2015年 ltebean. All rights reserved.
//

#import "BGColorDemoViewController.h"
#import "UINavigationBar+Awesome.h"
#import "UIScrollView+NavigationBar.h"
#import "CommonMacro.h"
#import "UIView+SSAdd.h"
#import "ScrollingNavbarDemoViewController.h"

#define NAVBAR_CHANGE_POINT 50

@interface BGColorDemoViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) UIView *m_navView;

@end

@implementation BGColorDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.tableView.dataSource = self;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
//    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor clearColor]];
    
    self.tableView.navigationType = NavigationTypeHiden;
    
//    [self m_navView];
}


- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self m_navView];
    self.tableView.frameY = self.m_navView.frameHeight;
    
    self.tableView.navigationView = self.m_navView;
}

- (UIView *)m_navView {
    if (_m_navView) {
        return _m_navView;
    }
    float height =  64 ;
    float offSet =  20 ;
    _m_navView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, AppScreenWidth, height)];
    _m_navView.backgroundColor = [UINavigationBar appearance].barTintColor;
//    _m_navView.alpha = 0;
    [self.view addSubview:_m_navView];
    
//    UIView *_mNavBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, AppScreenWidth, height)];
//    _mNavBackView.backgroundColor = [UINavigationBar appearance].barTintColor;
    //    _mNavBackView.alpha = 0;
//    [self.view addSubview:_mNavBackView];
    
//    float btnW = 44.;
//    UIButton *categoryBtn = [[UIButton alloc] initWithFrame:CGRectMake(AppScreenWidth - btnW - leftOrRightMargin, offSet, btnW, btnW)];
//    categoryBtn.tag = 102;
////    [categoryBtn highlightedButtonWithImageOnly:@"g_market_classify"];
//    categoryBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
//    [categoryBtn addTarget:self action:@selector(goToClassify) forControlEvents:UIControlEventTouchUpInside];
//    [_mNavBackView addSubview:categoryBtn];
//    [categoryBtn setEnlargeEdgeWithTop:10 right:10 bottom:10 left:20];
    
//    float searchBtnH = 30.;
//    UIButton *searchBtn = [[UIButton alloc] initWithFrame:CGRectMake((AppScreenWidth - 374/2.0)/2.0, offSet + (44 - searchBtnH)/2.0, 374/2.0, searchBtnH)];
//    searchBtn.tag = 101;
//    //    searchBtn.alpha = 0.9;
//    searchBtn.layer.cornerRadius = searchBtn.frameHeight / 2.0;
//    searchBtn.titleLabel.font = [UIFont systemFontOfSize:M_FRONT_THREETEEN];
//    searchBtn.clipsToBounds = YES;
//    [searchBtn highlightedButtonNOChangeWithImage:@"g_market_search" wihtTitleColor:Color999999];
//    searchBtn.contentEdgeInsets = UIEdgeInsetsMake(0,
//                                                   leftOrRightMargin,
//                                                   0,
//                                                   0);
//    [searchBtn setTitle:@"搜索商品" forState:UIControlStateNormal];
//    
//    CGFloat titleOffset = 3.0;
//    searchBtn.titleEdgeInsets = UIEdgeInsetsMake(0,
//                                                 titleOffset,
//                                                 0,
//                                                 -titleOffset/2);
//    
//    searchBtn.imageEdgeInsets = UIEdgeInsetsMake(0,
//                                                 -leftOrRightMargin/2,
//                                                 0,
//                                                 leftOrRightMargin/2);
//    [searchBtn addTarget:self action:@selector(goToSearch) forControlEvents:UIControlEventTouchUpInside];
//    [_mNavBackView addSubview:searchBtn];
//    
//    PGNavbarMEGView *leftBarItem = [[PGNavbarMEGView alloc]init];
//    leftBarItem.frameX = leftOrRightMargin;
//    leftBarItem.centerY = searchBtn.centerY;
//    [_mNavBackView addSubview:leftBarItem];
    
    return _m_navView;
}

//- (void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//    UIColor * color = [UIColor colorWithRed:0/255.0 green:175/255.0 blue:240/255.0 alpha:1];
//    CGFloat offsetY = scrollView.contentOffset.y;
//    if (offsetY > NAVBAR_CHANGE_POINT) {
//        CGFloat alpha = MIN(1, 1 - ((NAVBAR_CHANGE_POINT + 64 - offsetY) / 64));
//        [self.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:alpha]];
//    } else {
//        [self.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:0]];
//    }
//}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    self.tableView.delegate = self;
//    [self scrollViewDidScroll:self.tableView];
//    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
     self.navigationController.navigationBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.tableView.delegate = nil;
//    [self.navigationController.navigationBar lt_reset];
}

#pragma mark UITableViewDatasource

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"header";
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ScrollingNavbarDemoViewController *ScrollingNav =  [[ScrollingNavbarDemoViewController alloc] init];
    [self.navigationController pushViewController:ScrollingNav animated:YES];    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    cell.textLabel.text = @"text";
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 65;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
