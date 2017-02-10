//
//  AppDelegate.m
//  MobScreenShareDome
//
//  Created by youzu on 17/1/23.
//  Copyright © 2017年 mob. All rights reserved.
//

#import "AppDelegate.h"

#import "MobScreenshotCenter.h"

// 腾讯开发平台(对应QQ和QQ空间)SDK头文件
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>

#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>

// 微信SDK头文件
#import "WXApi.h"

// 新浪微博SDK头文件(新浪微博SDK需要在项目Build Settings中的Other Linker Flags添加"-ObjC")
#import "WeiboSDK.h"

NSString *const shareSDKAppKey = @"1a131fa890c30";

// SinaWeibo
NSString *const appKey_Sina = @"2035386060";
NSString *const appSecret_Sina = @"9d9ac3942e56de49fffa3cc51fa123d9";
NSString *const redirectUri_Sina = @"http://www.sharesdk.cn";

// WeChat
NSString *const appId_WeChat = @"wx4868b35061f87885";
NSString *const appSecret_WeChat = @"64020361b8ec4c99936c0e3999a9f249";

// QQ
NSString *const appId_QQ = @"100371282";
NSString *const appKey_QQ = @"aed9b0303e3ed1e27bae87c33761161d";


@interface AppDelegate ()

@end

@implementation AppDelegate

/**
 初始化ShareSDK
 */
- (void)setupShareSDK
{
    [ShareSDK registerApp:shareSDKAppKey
          activePlatforms:@[
                            @(SSDKPlatformTypeSinaWeibo),
                            @(SSDKPlatformTypeMail),
                            @(SSDKPlatformTypeSMS),
                            @(SSDKPlatformTypeCopy),
                            @(SSDKPlatformTypeWechat),
                            @(SSDKPlatformTypeQQ)
                            ]
                 onImport:^(SSDKPlatformType platformType) {
                     switch (platformType)
                     {
                         case SSDKPlatformTypeWechat:
                             [ShareSDKConnector connectWeChat:[WXApi class]];
                             break;
                         case SSDKPlatformTypeQQ:
                             [ShareSDKConnector connectQQ:[QQApiInterface class] tencentOAuthClass:[TencentOAuth class]];
                             break;
                         case SSDKPlatformTypeSinaWeibo:
                             [ShareSDKConnector connectWeibo:[WeiboSDK class]];
                             break;
                         default:
                             break;
                     }
                 }
          onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo) {
              switch (platformType)
              {
                  case SSDKPlatformTypeSinaWeibo:
                      [appInfo SSDKSetupSinaWeiboByAppKey:appKey_Sina
                                                appSecret:appSecret_Sina
                                              redirectUri:redirectUri_Sina
                                                 authType:SSDKAuthTypeBoth];
                      break;
                  case SSDKPlatformTypeWechat:
                      [appInfo SSDKSetupWeChatByAppId:appId_WeChat
                                            appSecret:appSecret_WeChat];
                      break;
                  case SSDKPlatformTypeQQ:
                      [appInfo SSDKSetupQQByAppId:appId_QQ
                                           appKey:appKey_QQ
                                         authType:SSDKAuthTypeBoth];
                      break;
                  default:
                      break;
              }
          }];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [self setupShareSDK];
    //启动截屏监听
    [[MobScreenshotCenter shareInstance] start];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
