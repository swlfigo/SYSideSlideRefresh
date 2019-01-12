//
//  UIScrollView+SJMJSideSildeRefresh.h
//  SYMJSideSlideRefresh_Example
//
//  Created by Sylar on 2019/1/12.
//  Copyright © 2019年 swlfigo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SYMJSideSlideRefreshConst.h"
NS_ASSUME_NONNULL_BEGIN

@class SYMJSideSlideRefreshFooter;
@interface UIScrollView (SJMJSideSildeRefresh)
/** 右拉刷新控件 */
@property (strong, nonatomic) SYMJSideSlideRefreshFooter *sideSlide_footer;

#pragma mark - other
- (NSInteger)mj_totalDataCount;
@property (copy, nonatomic) void (^mj_reloadDataBlock)(NSInteger totalDataCount);
@end

NS_ASSUME_NONNULL_END
