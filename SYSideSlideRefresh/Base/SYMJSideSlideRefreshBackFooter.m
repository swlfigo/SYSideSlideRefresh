//
//  SYMJSideSlideRefreshBackFooter.m
//  Pods
//
//  Created by Sylar on 2019/1/12.
//

#import "SYMJSideSlideRefreshBackFooter.h"

@interface SYMJSideSlideRefreshBackFooter()

@property (assign, nonatomic) NSInteger lastRefreshCount;
@property (assign, nonatomic) CGFloat lastBottomDelta;

@end

@implementation SYMJSideSlideRefreshBackFooter
#pragma mark - 初始化
- (void)willMoveToSuperview:(UIView *)newSuperview
{
    [super willMoveToSuperview:newSuperview];
    
    [self scrollViewContentSizeDidChange:nil];
}

- (void)setState:(MJRefreshState)state
{
    MJRefreshCheckState
    
    // 根据状态来设置属性
    if (state == MJRefreshStateNoMoreData || state == MJRefreshStateIdle) {
        // 刷新完毕
        if (MJRefreshStateRefreshing == oldState) {
            [UIView animateWithDuration:MJRefreshSlowAnimationDuration animations:^{
                self.scrollView.mj_insetR -= self.lastBottomDelta;
                
                // 自动调整透明度
                if (self.isAutomaticallyChangeAlpha) self.alpha = 0.0;
            } completion:^(BOOL finished) {
                self.pullingPercent = 0.0;
                
                if (self.endRefreshingCompletionBlock) {
                    self.endRefreshingCompletionBlock();
                }
            }];
        }
        
        CGFloat deltaH = [self heightForContentBreakView];
        // 刚刷新完毕
        if (MJRefreshStateRefreshing == oldState && deltaH > 0 && self.scrollView.mj_totalDataCount != self.lastRefreshCount) {
            self.scrollView.mj_offsetX = self.scrollView.mj_offsetX;
        }
    } else if (state == MJRefreshStateRefreshing) {
        
        // 记录刷新前的数量
        self.lastRefreshCount = self.scrollView.mj_totalDataCount;
        
        [UIView animateWithDuration:MJRefreshFastAnimationDuration animations:^{
            CGFloat bottom = self.mj_w + self.scrollViewOriginalInset.right;
            CGFloat deltaH = [self heightForContentBreakView];
            if (deltaH < 0) { // 如果内容高度小于view的高度
                bottom -= deltaH;
            }
            self.lastBottomDelta = bottom - self.scrollView.mj_insetR;
            self.scrollView.mj_insetR = bottom;
            self.scrollView.mj_offsetX = [self happenOffsetX] + self.mj_w;
        } completion:^(BOOL finished) {
            [self executeRefreshingCallback];
        }];
    }
}

- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change{
    [super scrollViewContentOffsetDidChange:change];
    
    // 如果正在刷新，直接返回
    if (self.state == MJRefreshStateRefreshing) return;
    
    _scrollViewOriginalInset = self.scrollView.mj_inset;
    
    // 当前的contentOffset
    CGFloat currentOffsetX = self.scrollView.mj_offsetX;
    // 尾部控件刚好出现的offsetX
    CGFloat happenOffsetX = [self happenOffsetX];
    // 如果是向下滚动到看不见尾部控件，直接返回
    if (currentOffsetX <= happenOffsetX) return;
    
    CGFloat pullingPercent = (currentOffsetX - happenOffsetX) / self.mj_w;
    
    // 如果已全部加载，仅设置pullingPercent，然后返回
    if (self.state == MJRefreshStateNoMoreData) {
        self.pullingPercent = pullingPercent;
        return;
    }
    
    if (self.scrollView.isDragging) {
        self.pullingPercent = pullingPercent;
        // 普通 和 即将刷新 的临界点
        CGFloat normal2pullingOffsetX = happenOffsetX + self.mj_w;
        
        
        if (self.state == MJRefreshStateIdle && currentOffsetX > normal2pullingOffsetX) {
            // 转为即将刷新状态
            self.state = MJRefreshStatePulling;
        } else if (self.state == MJRefreshStatePulling && currentOffsetX <= normal2pullingOffsetX) {
            // 转为普通状态
            self.state = MJRefreshStateIdle;
        }
    } else if (self.state == MJRefreshStatePulling) {// 即将刷新 && 手松开
        // 开始刷新
        [self beginRefreshing];
    } else if (pullingPercent < 1) {
        self.pullingPercent = pullingPercent;
    }
}

- (void)scrollViewContentSizeDidChange:(NSDictionary *)change{
    [super scrollViewContentSizeDidChange:change];
    
    // 内容的高度
    CGFloat contentHeight = self.scrollView.mj_contentW - self.scrollViewOriginalInset.left - self.scrollViewOriginalInset.right ;
    // 表格的高度
    CGFloat scrollHeight = self.scrollView.mj_w - self.scrollViewOriginalInset.left - self.scrollViewOriginalInset.right ;
    // 设置位置和尺寸
    self.mj_x = MAX(contentHeight, scrollHeight);
    self.mj_y = 0;
}


#pragma mark - 私有方法
#pragma mark 获得scrollView的内容 超出 view 的高度
- (CGFloat)heightForContentBreakView
{
    CGFloat w = self.scrollView.frame.size.width - self.scrollViewOriginalInset.left - self.scrollViewOriginalInset.right;
    return self.scrollView.contentSize.width - w;
}

#pragma mark 刚好看到上拉刷新控件时的contentOffset.y
- (CGFloat)happenOffsetX
{
    CGFloat deltaW = [self heightForContentBreakView];
    if (deltaW > 0) {
        return deltaW - self.scrollViewOriginalInset.left;
    } else {
        return - self.scrollViewOriginalInset.left;
    }
}
@end
