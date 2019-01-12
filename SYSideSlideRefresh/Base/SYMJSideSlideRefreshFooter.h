//
//  SYMJSideSlideRefreshFooter.h
//  Pods
//
//  Created by Sylar on 2019/1/12.
//

#import "SYMJSideSlideRefreshComponent.h"

NS_ASSUME_NONNULL_BEGIN

@interface SYMJSideSlideRefreshFooter : SYMJSideSlideRefreshComponent

/** 创建footer */
+ (instancetype)footerWithRefreshingBlock:(MJRefreshComponentRefreshingBlock)refreshingBlock;
/** 创建footer */
+ (instancetype)footerWithRefreshingTarget:(id)target refreshingAction:(SEL)action;

/** 提示没有更多的数据 */
- (void)endRefreshingWithNoMoreData;

/** 重置没有更多的数据（消除没有更多数据的状态） */
- (void)resetNoMoreData;

/** 忽略多少scrollView的contentInset的bottom */
@property (assign, nonatomic) CGFloat ignoredScrollViewContentInsetBottom;

/** 自动根据有无数据来显示和隐藏（有数据就显示，没有数据隐藏。默认是NO） */
@property (assign, nonatomic, getter=isAutomaticallyHidden) BOOL automaticallyHidden MJRefreshDeprecated("不建议使用此属性，开发者请自行控制footer的显示和隐藏。基于安全考虑，在未来的某些版本此属性可能作废");

@end

NS_ASSUME_NONNULL_END
