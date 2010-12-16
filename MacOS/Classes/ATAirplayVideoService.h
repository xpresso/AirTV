//
//  ATAirplayVideoService.h
//  AirTunes
//
//  Created by Andy Roth on 12/14/10.
//  Copyright 2010 Resource Interactive. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QTKit/QTKit.h>
#import "AsyncSocket.h"


@interface ATAirplayVideoService : NSObject <NSNetServiceDelegate, AsyncSocketDelegate>
{
	AsyncSocket *listeningSocket;
	NSNetService *bonjourService;
	
	BOOL isUpgraded;
	BOOL isPlaying;
	
	QTMovieView *movieView;
	QTMovie *movie;
	long currentTag;
	
	NSImageView *imageView;
	
	NSMutableData *photoData;
}

@property (nonatomic, retain) QTMovieView *movieView;
@property (nonatomic, retain) NSImageView *imageView;

- (void) start;
- (void) showPhoto;

@end
