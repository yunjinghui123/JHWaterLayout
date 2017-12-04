//
//  UIViewController+Extension.m
//  mm
//
//  Created by yunjinghui on 2017/11/24.
//  Copyright © 2017年 jinghui. All rights reserved.
//

#import <UIKit/UIKit.h>

@implementation UIViewController (Extension)

+ (void)load {
    Method method1 = class_getInstanceMethod(self, NSSelectorFromString(@"dealloc"));
    Method method2 = class_getInstanceMethod(self, @selector(jh_dealloc));
    
    method_exchangeImplementations(method1, method2);
}

- (void)jh_dealloc {
    NSLog(@"%@--挂了", self);
        [self jh_dealloc];
}

@end
