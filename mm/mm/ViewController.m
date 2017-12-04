//
//  ViewController.m
//  mm
//
//  Created by yunjinghui on 2017/11/23.
//  Copyright © 2017年 jinghui. All rights reserved.
//

#import "ViewController.h"
#import <objc/runtime.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    Method method1 = class_getInstanceMethod([TestCell class], @selector(run));
    Method method2 = class_getInstanceMethod([TestCell class], @selector(study));
    
    method_exchangeImplementations(method1, method2);
    
    TestCell *cell = [[TestCell alloc] init];
    [cell run];
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
