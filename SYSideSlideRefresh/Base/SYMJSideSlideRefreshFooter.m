//
//  SYMJSideSlideRefreshFooter.m
//  Pods
//
//  Created by Sylar on 2019/1/12.
//

#import "SYMJSideSlideRefreshFooter.h"

@implementation SYMJSideSlideRefreshFooter

#pragma mark - 构造方法
+ (instancetype)footerWithRefreshingBlock:(MJRefreshComponentRefreshingBlock)refreshingBlock
{
    SYMJSideSlideRefreshFooter *cmp = [[self alloc] init];
    cmp.refreshingBlock = refreshingBlock;
    return cmp;
}
+ (instancetype)footerWithRefreshingTarget:(id)target refreshingAction:(SEL)action
{
    SYMJSideSlideRefreshFooter *cmp = [[self alloc] init];
    [cmp setRefreshingTarget:target refreshingAction:action];
    return cmp;
}

#pragma mark - 重写父类的方法
- (void)prepare
{
    [super prepare];
        
    // 默认不会自动隐藏
    self.automaticallyHidden = NO;
}

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    [super willMoveToSuperview:newSuperview];
    
    if (newSuperview) {
        // 监听scrollView数据的变化
        if ([self.scrollView isKindOfClass:[UITableView class]] || [self.scrollView isKindOfClass:[UICollectionView class]]) {
            [self.scrollView setMj_reloadDataBlock:^(NSInteger totalDataCount) {
                if (self.isAutomaticallyHidden) {
                    self.hidden = (totalDataCount == 0);
                }
            }];
        }
    }
}

#pragma mark - 公共方法
- (void)endRefreshingWithNoMoreData
{
    MJRefreshDispatchAsyncOnMainQueue(self.state = MJRefreshStateNoMoreData;)
}

- (void)noticeNoMoreData
{
    [self endRefreshingWithNoMoreData];
}

- (void)resetNoMoreData
{
    MJRefreshDispatchAsyncOnMainQueue(self.state = MJRefreshStateIdle;)
}

- (void)setAutomaticallyHidden:(BOOL)automaticallyHidden
{
    _automaticallyHidden = automaticallyHidden;
}

@end
