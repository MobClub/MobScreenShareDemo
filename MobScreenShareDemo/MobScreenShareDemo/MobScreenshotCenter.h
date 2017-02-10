//
//  MobScreenshotCenter.h
//  MobScreenShareDome
//
//  Created by youzu on 17/1/23.
//  Copyright © 2017年 mob. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 监听截屏时间 iOS7及以上支持
 */
@interface MobScreenshotCenter : NSObject

+ (MobScreenshotCenter *)shareInstance;

/**
 启动截屏监听
 */
- (void)start;

/**
 停止截屏监听
 */
- (void)stop;
@end
