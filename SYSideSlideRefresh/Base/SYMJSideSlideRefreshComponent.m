//
//  SYMJSideSlideRefreshComponent.m
//  Pods
//
//  Created by Sylar on 2019/1/12.
//

#import "SYMJSideSlideRefreshComponent.h"

@implementation SYMJSideSlideRefreshComponent
@synthesize state = _state;

- (void)prepare
{
    // 基本属性
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    self.backgroundColor = [UIColor clearColor];
}

- (void)setState:(MJRefreshState)state
{
    _state = state;
    
    // 加入主队列的目的是等setState:方法调用完毕、设置完文字后再去布局子控件
    MJRefreshDispatchAsyncOnMainQueue([self setNeedsLayout];)
}

- (void)willMoveToSuperview:(UIView *)newSuperview{
    [super willMoveToSuperview:newSuperview];
    //MJ基类重写了这个方法，导致只能上下弹性滑动
    //如果要达到侧滑效果,需要将基类改变的属性重写
    if (newSuperview) {
        
        //基类已经做了判断赋值，如果存在且是 UIScrollView子类就会进来此判断
        //判断逻辑可自行查看MJ基类

        self.mj_h = newSuperview.mj_h;
        self.mj_x = -_scrollView.mj_insetR;
        
        // 设置自己的高度
        self.mj_w = SYMJSideSlideRefreshFooterWidth;
        
        self.scrollView.alwaysBounceVertical = NO;
        self.scrollView.alwaysBounceHorizontal = YES;
    }
}

- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change{}
- (void)scrollViewContentSizeDidChange:(NSDictionary *)change{}
- (void)scrollViewPanStateDidChange:(NSDictionary *)change{}

@end
