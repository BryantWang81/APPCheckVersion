//
//  ViewController.m
//  App版本检测更新
//
//  Created by BryantWang on 2017/1/24.
//  Copyright © 2017年 BryantWang. All rights reserved.
//

#import "ViewController.h"
#import "NewVersionHelper.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [NewVersionHelper CheckAppVersion:^(NSDictionary *info) {
        NSLog(@"检查到有更新,更新信息是%@",info);
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
