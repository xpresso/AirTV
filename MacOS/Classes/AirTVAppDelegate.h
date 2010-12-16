//
//  AirTunesAppDelegate.h
//  AirTunes
//
//  Created by Andy Roth on 12/14/10.
//  Copyright 2010 Resource Interactive. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <QuickTime/QuickTime.h>
#import <QTKit/QTKit.h>
#import "ATAirplayVideoService.h"

@interface AirTVAppDelegate : NSObject <NSApplicationDelegate, NSNetServiceDelegate, NSWindowDelegate>
{
    NSWindow *window;
	IBOutlet QTMovieView *movieView;
	IBOutlet NSImageView *imageView;
	
	ATAirplayVideoService *videoService;
}

@property (assign) IBOutlet NSWindow *window;

- (IBAction) toggleFullscreen:(id)sender;

@end
