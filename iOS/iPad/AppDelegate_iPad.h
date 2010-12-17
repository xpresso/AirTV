//
//  AppDelegate_iPad.h
//  AirTV
//
//  Created by Andy Roth on 12/16/10.
//  Copyright 2010 Resource Interactive. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import "ATAirplayVideoService.h"

@interface AppDelegate_iPad : NSObject <UIApplicationDelegate>
{
    UIWindow *window;
	
	MPMoviePlayerController *moviePlayer;
	ATAirplayVideoService *videoService;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@end

