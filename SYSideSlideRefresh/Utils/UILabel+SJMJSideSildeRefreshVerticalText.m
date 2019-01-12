//
//  UILabel+SJMJSideSildeRefreshVerticalText.m
//  SYMJSideSlideRefresh_Example
//
//  Created by Sylar on 2019/1/12.
//  Copyright © 2019年 swlfigo. All rights reserved.
//

#import "UILabel+SJMJSideSildeRefreshVerticalText.h"
#import "objc/Runtime.h"

@implementation UILabel (SJMJSideSildeRefreshVerticalText)
- (NSString *)verticalText{
    // 利用runtime添加属性
    return objc_getAssociatedObject(self, @selector(verticalText));
}

- (void)setVerticalText:(NSString *)verticalText{
    if (!verticalText) {
        verticalText = @"";
    }
    objc_setAssociatedObject(self, &verticalText, verticalText, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    NSMutableString *str = [[NSMutableString alloc] initWithString:verticalText];
    NSInteger count = str.length;
    for (int i = 1; i < count; i ++) {
        [str insertString:@"\n" atIndex:i*2-1];
    }
    self.text = str;
    self.numberOfLines = 0;
}

@end
