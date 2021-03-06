//
//  AppDelegate.m
//  EraUmaVezUmDesenho
//
//  Created by Victor D. Savariego on 1/5/15.
//  Copyright (c) 2015 Four Kids. All rights reserved.
//

#import "AppDelegate.h"
#import "EVDMenuViewController.h"
#import "EVDBookShelf.h"
#import "EVDSettings.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [application setStatusBarHidden:YES];
    
    //Inicia musica de fundo
    NSString *path = [NSString stringWithFormat:@"%@/background.mp3", [[NSBundle mainBundle] resourcePath]];
    NSURL *soundUrl = [NSURL fileURLWithPath:path];
    _background = [[AVAudioPlayer alloc] initWithContentsOfURL:soundUrl error:nil];
    _background.numberOfLoops = -1;
    [_background setVolume:0.1];
    
    if ([EVDSettings getBoolForKey:@"settingsPlayBackgroundMusic"]) {
        [_background play];
    }
    
    //Delay para mostrar a launchscreen.
    //[NSThread sleepForTimeInterval:2.0];
    _window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    EVDMenuViewController *menu = [[EVDMenuViewController alloc] init];
    
    _navController = [[UINavigationController alloc]initWithRootViewController:menu];
    _navController.navigationBarHidden = YES;
    
    [_window setRootViewController:_navController];
    
    
    // Override point for customization after application launch.
    _window.backgroundColor = [UIColor whiteColor];
    [_window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    BOOL success = [[EVDBookShelf bookShelf] saveChanges];
    if (success) {
        NSLog(@"Livros foram salvos!!");
    }
    else{
        NSLog(@"Livros nao foram salvos :(( !!");
    }
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
