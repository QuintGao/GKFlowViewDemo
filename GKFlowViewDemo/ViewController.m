//
//  ViewController.m
//  GKFlowViewDemo
//
//  Created by QuintGao on 2019/9/1.
//  Copyright © 2019 QuintGao. All rights reserved.
//

#import "ViewController.h"
#import <JXCategoryView/JXCategoryView.h>
#import "NewPagedFlowView/NewPagedFlowView.h"

#define SCREEN_WIDTH    [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT   [UIScreen mainScreen].bounds.size.height

#define ADAPTATIONRATIO         SCREEN_WIDTH / 750.0f

#define IS_iPhoneX      ([UIScreen instancesRespondToSelector:@selector(currentMode)] ?\
(\
CGSizeEqualToSize(CGSizeMake(375, 812),[UIScreen mainScreen].bounds.size)\
||\
CGSizeEqualToSize(CGSizeMake(812, 375),[UIScreen mainScreen].bounds.size)\
||\
CGSizeEqualToSize(CGSizeMake(414, 896),[UIScreen mainScreen].bounds.size)\
||\
CGSizeEqualToSize(CGSizeMake(896, 414),[UIScreen mainScreen].bounds.size))\
:\
NO)

#define NAVBAR_HEIGHT           (IS_iPhoneX ? 88.0f : 64.0f)

@interface ViewController ()<NewPagedFlowViewDataSource, NewPagedFlowViewDelegate>

@property (nonatomic, strong) JXCategoryTitleView   *categoryView;

@property (nonatomic, strong) NewPagedFlowView      *flowView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.categoryView];
    [self.view addSubview:self.flowView];
    
    self.categoryView.frame = CGRectMake(0, NAVBAR_HEIGHT, SCREEN_WIDTH, ADAPTATIONRATIO * 100.0f);
    self.flowView.frame = CGRectMake(0, CGRectGetMaxY(self.categoryView.frame) + ADAPTATIONRATIO * 17.0f, SCREEN_WIDTH, ADAPTATIONRATIO * 850.0f);
    
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    pageControl.frame = CGRectMake(0, CGRectGetMaxY(self.flowView.frame) + ADAPTATIONRATIO * 36.0f, SCREEN_WIDTH, ADAPTATIONRATIO * 12.0f);
    pageControl.pageIndicatorTintColor = [UIColor colorWithRed:157/255.0 green:157/255.0 blue:157/255.0 alpha:1.0];
    pageControl.currentPageIndicatorTintColor = [UIColor colorWithRed:254/255.0 green:89/255.0 blue:93/255.0 alpha:1.0];
    [self.view addSubview:pageControl];
    
    self.flowView.pageControl = pageControl;
    
    [self.flowView reloadData];
}

#pragma mark - NewPagedFlowViewDataSource
- (NSInteger)numberOfPagesInFlowView:(NewPagedFlowView *)flowView {
    return 8;
}

- (PGIndexBannerSubiew *)flowView:(NewPagedFlowView *)flowView cellForPageAtIndex:(NSInteger)index {
    PGIndexBannerSubiew *subView = [flowView dequeueReusableCell];
    if (!subView) {
        subView = [PGIndexBannerSubiew new];
    }
    subView.mainImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%zd", index+1]];
    subView.coverView.hidden = YES;
    subView.layer.cornerRadius = ADAPTATIONRATIO * 10.0f;
    subView.layer.masksToBounds = YES;
    return subView;
}
#pragma mark - NewPagedFlowViewDelegate
- (CGSize)sizeForPageInFlowView:(NewPagedFlowView *)flowView {
    return CGSizeMake(ceilf(ADAPTATIONRATIO * 560.0f), ADAPTATIONRATIO * 850.0f);
}

#pragma mark - 懒加载
- (JXCategoryTitleView *)categoryView {
    if (!_categoryView) {
        _categoryView = [JXCategoryTitleView new];
        _categoryView.titles = @[@"免费听书", @"免费下载", @"会员专区", @"完美音质", @"免广告", @"尊享标志", @"更多折扣", @"更多福利"];
        _categoryView.titleFont = [UIFont systemFontOfSize:14.0f];
        _categoryView.titleSelectedFont = [UIFont systemFontOfSize:14.0f];
        _categoryView.titleColor = [UIColor colorWithRed:157/255.0 green:157/255.0 blue:157/255.0 alpha:1.0];
        _categoryView.titleSelectedColor = [UIColor colorWithRed:40/255.0 green:40/255.0 blue:40/255.0 alpha:1.0];
        
        JXCategoryIndicatorLineView *lineView = [JXCategoryIndicatorLineView new];
        lineView.lineStyle = JXCategoryIndicatorLineStyle_Normal;
        lineView.indicatorColor = [UIColor colorWithRed:254/255.0 green:89/255.0 blue:93/255.0 alpha:1.0];
        lineView.indicatorWidth = ADAPTATIONRATIO * 40.0f;
        lineView.indicatorHeight = ADAPTATIONRATIO * 4.0f;
        lineView.verticalMargin = ADAPTATIONRATIO * 25.0f;
        _categoryView.indicators = @[lineView];
        
        _categoryView.contentScrollView = self.flowView.scrollView;
    }
    return _categoryView;
}

- (NewPagedFlowView *)flowView {
    if (!_flowView) {
        _flowView = [NewPagedFlowView new];
        _flowView.dataSource = self;
        _flowView.delegate = self;
        _flowView.isOpenAutoScroll = NO;
        _flowView.isCarousel = NO;
        _flowView.leftRightMargin = ADAPTATIONRATIO * 100.0f;
        _flowView.topBottomMargin = ADAPTATIONRATIO * 80.0f;
    }
    return _flowView;
}

@end
