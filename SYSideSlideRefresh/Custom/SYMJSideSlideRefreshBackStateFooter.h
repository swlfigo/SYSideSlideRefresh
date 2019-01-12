//
//  SYMJSideSlideRefreshBackStateFooter.h
//  Pods
//
//  Created by Sylar on 2019/1/12.
//

#import "SYMJSideSlideRefreshBackFooter.h"

NS_ASSUME_NONNULL_BEGIN

@interface SYMJSideSlideRefreshBackStateFooter : SYMJSideSlideRefreshBackFooter

/** 文字距离圈圈、箭头的距离 */
@property (assign, nonatomic) CGFloat labelLeftInset;
/** 显示刷新状态的label */
@property (strong, nonatomic) UILabel *stateLabel;
/** 设置state状态下的文字 */
- (void)setTitle:(NSString *)title forState:(MJRefreshState)state;

/** 获取state状态下的title */
- (NSString *)titleForState:(MJRefreshState)state;

@end

NS_ASSUME_NONNULL_END
