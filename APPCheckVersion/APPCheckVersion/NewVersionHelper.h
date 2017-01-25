//
//  NewVersionHelper.h
//  App版本检测更新
//
//  Created by BryantWang on 2017/1/24.
//  Copyright © 2017年 BryantWang. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^UpdateAppBlock)(NSDictionary*info);
@interface NewVersionHelper : NSObject
//检查版本方法
+(void)CheckAppVersion:(UpdateAppBlock)update;
@end
