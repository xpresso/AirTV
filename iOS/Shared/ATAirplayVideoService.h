//
//  ATAirplayVideoService.h
//  AirTunes
//
//  Created by Andy Roth on 12/14/10.
//  Copyright 2010 Resource Interactive. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import "AsyncSocket.h"


@interface ATAirplayVideoService : NSObject <NSNetServiceDelegate, AsyncSocketDelegate>
{
	AsyncSocket *listeningSocket;
	NSNetService *bonjourService;
	
	MPMoviePlayerController *moviePlayer;
	long currentTag;
}

@property (nonatomic, retain) MPMoviePlayerController *moviePlayer;

- (void) start;

@end
