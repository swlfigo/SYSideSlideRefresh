//
//  UIScrollView+SJMJSideSildeRefresh.m
//  SYMJSideSlideRefresh_Example
//
//  Created by Sylar on 2019/1/12.
//  Copyright © 2019年 swlfigo. All rights reserved.
//

#import "UIScrollView+SJMJSideSildeRefresh.h"
#import "SYMJSideSlideRefreshFooter.h"
#import <objc/runtime.h>

@implementation NSObject (SJMJSideSildeRefresh)

+ (void)exchangeInstanceMethod1:(SEL)method1 method2:(SEL)method2
{
    method_exchangeImplementations(class_getInstanceMethod(self, method1), class_getInstanceMethod(self, method2));
}

+ (void)exchangeClassMethod1:(SEL)method1 method2:(SEL)method2
{
    method_exchangeImplementations(class_getClassMethod(self, method1), class_getClassMethod(self, method2));
}

@end


@implementation UIScrollView (SJMJSideSildeRefresh)
#pragma mark - footer
static const char SYMJSideSlideRefreshFooterKey = '\0';
- (void)setSideSlide_footer:(SYMJSideSlideRefreshFooter *)sideSlide_footer
{
    if (sideSlide_footer != self.sideSlide_footer) {
        // 删除旧的，添加新的
        [self.sideSlide_footer removeFromSuperview];
        [self insertSubview:sideSlide_footer atIndex:0];
        
        // 存储新的
        objc_setAssociatedObject(self, &SYMJSideSlideRefreshFooterKey,
                                 sideSlide_footer, OBJC_ASSOCIATION_RETAIN);
    }
}

- (SYMJSideSlideRefreshFooter *)sideSlide_footer
{
    return objc_getAssociatedObject(self, &SYMJSideSlideRefreshFooterKey);
}

#pragma mark - other
- (NSInteger)mj_totalDataCount
{
    NSInteger totalCount = 0;
    if ([self isKindOfClass:[UITableView class]]) {
        UITableView *tableView = (UITableView *)self;
        
        for (NSInteger section = 0; section<tableView.numberOfSections; section++) {
            totalCount += [tableView numberOfRowsInSection:section];
        }
    } else if ([self isKindOfClass:[UICollectionView class]]) {
        UICollectionView *collectionView = (UICollectionView *)self;
        
        for (NSInteger section = 0; section<collectionView.numberOfSections; section++) {
            totalCount += [collectionView numberOfItemsInSection:section];
        }
    }
    return totalCount;
}

static const char MJRefreshReloadDataBlockKey = '\0';
- (void)setMj_reloadDataBlock:(void (^)(NSInteger))mj_reloadDataBlock
{
    [self willChangeValueForKey:@"mj_reloadDataBlock"]; // KVO
    objc_setAssociatedObject(self, &MJRefreshReloadDataBlockKey, mj_reloadDataBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self didChangeValueForKey:@"mj_reloadDataBlock"]; // KVO
}

- (void (^)(NSInteger))mj_reloadDataBlock
{
    return objc_getAssociatedObject(self, &MJRefreshReloadDataBlockKey);
}

- (void)executeReloadDataBlock
{
    !self.mj_reloadDataBlock ? : self.mj_reloadDataBlock(self.mj_totalDataCount);
}
@end

@implementation UITableView (SJMJSideSildeRefresh)

+ (void)load
{
    [self exchangeInstanceMethod1:@selector(reloadData) method2:@selector(mj_reloadData)];
}

- (void)mj_reloadData
{
    [self mj_reloadData];
    
    [self executeReloadDataBlock];
}
@end

@implementation UICollectionView (SJMJSideSildeRefresh)

+ (void)load
{
    [self exchangeInstanceMethod1:@selector(reloadData) method2:@selector(mj_reloadData)];
}

- (void)mj_reloadData
{
    [self mj_reloadData];
    
    [self executeReloadDataBlock];
}
@end
