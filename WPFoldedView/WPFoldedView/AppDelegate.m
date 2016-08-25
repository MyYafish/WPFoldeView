//
//  AppDelegate.m
//  WPFoldedView
//
//  Created by 吴鹏 on 16/8/24.
//  Copyright © 2016年 wupeng. All rights reserved.
//

#import "AppDelegate.h"
#import "secondViewController.h"
#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    
    secondViewController * contentView = [[secondViewController alloc]init];
    
    
    UINavigationController * na = [[UINavigationController alloc]initWithRootViewController:contentView];
    self.window.rootViewController = na;
    
    
    [self.window makeKeyAndVisible];
    
    return YES;
}

@end
