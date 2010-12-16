//
//  AirTunesAppDelegate.h
//  AirTunes
//
//  Created by Andy Roth on 12/14/10.
//  Copyright 2010 Resource Interactive. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <QTKit/QTKit.h>
#import "ATAirplayVideoService.h"
#import "ATMovieView.h"

@interface AirTVAppDelegate : NSObject <NSApplicationDelegate, NSNetServiceDelegate, NSWindowDelegate>
{
    NSWindow *window;
	IBOutlet ATMovieView *movieView;
	IBOutlet NSImageView *imageView;
	
	ATAirplayVideoService *videoService;
}

@property (assign) IBOutlet NSWindow *window;

- (IBAction) toggleFullscreen:(id)sender;
- (IBAction) showPhoto:(id)sender;

@end
