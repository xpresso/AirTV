//
//  AppDelegate_iPhone.h
//  AirTV
//
//  Created by Andy Roth on 12/16/10.
//  Copyright 2010 Resource Interactive. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ATAirplayVideoService.h"
#import <MediaPlayer/MediaPlayer.h>

@interface AppDelegate_iPhone : NSObject <UIApplicationDelegate>
{
    UIWindow *window;
	
	MPMoviePlayerController *moviePlayer;
	ATAirplayVideoService *videoService;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@end

