//
//  ViewController.m
//  SYMJSideSlideRefreshExample
//
//  Created by Sylar on 2019/1/12.
//  Copyright © 2019年 Sylar. All rights reserved.
//

#import "ViewController.h"
#import "UIScrollView+SJMJSideSildeRefresh.h"
#import "SYMJSideSlideRefreshBackStateFooter.h"

@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property(nonatomic,strong)UICollectionView *mainCollectionView;
@property(nonatomic,strong)UICollectionViewFlowLayout *flowLayout;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _flowLayout = [[UICollectionViewFlowLayout alloc]init];
    _flowLayout.itemSize = CGSizeMake(200, 190);
    _flowLayout.minimumLineSpacing = 20.f;
    _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    _mainCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 50, [UIScreen mainScreen].bounds.size.width, 190) collectionViewLayout:_flowLayout];
    _mainCollectionView.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:_mainCollectionView];
    _mainCollectionView.delegate = self;
    _mainCollectionView.dataSource = self;
    [_mainCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([UICollectionViewCell class])];
    [_mainCollectionView reloadData];
    _mainCollectionView.backgroundColor = [UIColor whiteColor];
    _mainCollectionView.sideSlide_footer = [SYMJSideSlideRefreshBackStateFooter footerWithRefreshingTarget:self refreshingAction:@selector(refresh)];
    _mainCollectionView.showsVerticalScrollIndicator = NO;
    _mainCollectionView.showsHorizontalScrollIndicator = NO;
    _mainCollectionView.layer.borderColor = [UIColor grayColor].CGColor;
    _mainCollectionView.layer.borderWidth = 2.0f;
    
    UILabel *tipsLabel = [[UILabel alloc]init];
    tipsLabel.font = [UIFont systemFontOfSize:30.0f];
    tipsLabel.text = @"向右滑动试试→";
    [tipsLabel sizeToFit];
    [self.view addSubview:tipsLabel];
    tipsLabel.frame = CGRectMake(0, CGRectGetMaxY(_mainCollectionView.frame) + 20, tipsLabel.frame.size.width, tipsLabel.frame.size.height);
}

-(void)refresh{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"End Refreshing");
        [_mainCollectionView.sideSlide_footer endRefreshing];
    });
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([UICollectionViewCell class]) forIndexPath:indexPath];
    cell.backgroundColor = [UIColor orangeColor];
    return cell;
    
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 16, 0, 16);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
