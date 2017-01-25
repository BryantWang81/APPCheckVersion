//
//  NewVersionHelper.m
//  App版本检测更新
//
//  Created by BryantWang on 2017/1/24.
//  Copyright © 2017年 BryantWang. All rights reserved.
//

#import "NewVersionHelper.h"
//上线APP的APPID
#define STOREAPPID @"1172752229"
@implementation NewVersionHelper
+(void)CheckAppVersion:(UpdateAppBlock)update
{
//先获取当前版本的版本号
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    
    NSString *currentVersion = infoDic[@"CFBundleShortVersionString"];
    
    //从网络获取AppStore版本号
    NSError *error;
    NSData *response = [NSURLConnection sendSynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://itunes.apple.com/cn/lookup?id=%@",STOREAPPID]]] returningResponse:nil error:nil];
    //结果为空
    if (response == nil) {
        NSLog(@"没有网络");
    }
    NSDictionary *appInfoDic = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableLeaves error:&error];
    //查询错误
    if (error) {
        NSLog(@"hsUpdateAppError:%@",error);
        return;
    }
    //获取结果
    NSArray *array = appInfoDic[@"results"];
    if (array.count <1) {
        NSLog(@"此App未上架或者未查询到");
        return;
    }
    NSDictionary *dic = array[0];
    NSString *appStoreVersion = dic[@"version"];
    
    //打印当前版本号
    NSLog(@"当前版本号:%@\n商店版本号:%@",currentVersion,appStoreVersion);
    //设置版本号
    currentVersion  = [currentVersion stringByReplacingOccurrencesOfString:@"." withString:@""];
    if (currentVersion.length == 2)
    {
        currentVersion = [currentVersion stringByAppendingString:@"0"];
    }
    else if (currentVersion.length == 1)
    {
    
        currentVersion = [currentVersion stringByAppendingString:@"00"];
    }
    appStoreVersion = [appStoreVersion stringByReplacingOccurrencesOfString:@"." withString:@""];
    if (appStoreVersion.length == 2)
    {
        appStoreVersion = [appStoreVersion stringByAppendingString:@"0"];
    }
    else if (appStoreVersion.length == 1)
    {
        
        appStoreVersion = [appStoreVersion stringByAppendingString:@"00"];
    }

    //若当前版本小于商店版本则更新
    if ([currentVersion floatValue] < [appStoreVersion floatValue]) {
        
        update(dic);
        
    }else{
     
        NSLog(@"现在已经是最新的了,还想怎么着");
    }
}
@end
