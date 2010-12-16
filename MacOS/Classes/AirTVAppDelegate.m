//
//  AirTunesAppDelegate.m
//  AirTunes
//
//  Created by Andy Roth on 12/14/10.
//  Copyright 2010 Resource Interactive. All rights reserved.
//

#import "AirTVAppDelegate.h"

@implementation AirTVAppDelegate

@synthesize window;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
	videoService = [[ATAirplayVideoService alloc] init];
	videoService.movieView = movieView;
	videoService.imageView = imageView;
	[videoService start];
}

- (IBAction) toggleFullscreen:(id)sender
{
	if([movieView isInFullScreenMode])
	{
		[movieView exitFullScreenModeWithOptions:nil];
	}
	else
	{
		[movieView enterFullScreenMode:[NSScreen mainScreen] withOptions:[NSDictionary dictionaryWithObject:[NSNumber numberWithBool:NO] forKey:NSFullScreenModeAllScreens]];
	}
}

- (IBAction) showPhoto:(id)sender
{
	[videoService showPhoto];
}

- (void)windowWillClose:(NSNotification *)notification
{
	exit(0);
}

@end
