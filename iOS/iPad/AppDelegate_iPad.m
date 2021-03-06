//
//  AppDelegate_iPad.m
//  AirTV
//
//  Created by Andy Roth on 12/16/10.
//  Copyright 2010 Resource Interactive. All rights reserved.
//

#import "AppDelegate_iPad.h"

@implementation AppDelegate_iPad

@synthesize window;


#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{    
    moviePlayer = [[MPMoviePlayerController alloc] init];
	moviePlayer.view.frame = CGRectMake(0, 0, window.frame.size.width, window.frame.size.height);
	moviePlayer.shouldAutoplay = YES;
	[moviePlayer setControlStyle:MPMovieControlStyleNone];
	[window addSubview:moviePlayer.view];
	
    videoService = [[ATAirplayVideoService alloc] init];
	videoService.moviePlayer = moviePlayer;
	[videoService start];
    
    [self.window makeKeyAndVisible];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive.
     */
}


- (void)applicationWillTerminate:(UIApplication *)application {
    /*
     Called when the application is about to terminate.
     */
}


#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}


- (void)dealloc {
    [window release];
    [super dealloc];
}


@end
