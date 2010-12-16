//
//  ATAirplayVideoService.m
//  AirTunes
//
//  Created by Andy Roth on 12/14/10.
//  Copyright 2010 Resource Interactive. All rights reserved.
//

#import "ATAirplayVideoService.h"
#import "NSString+RIExtended.h"


#pragma mark -
#pragma mark Private

@interface ATAirplayVideoService (Private)

- (long) nextTag;
- (void) sendReverse:(AsyncSocket *)socket;
- (void) sendOK:(AsyncSocket *)socket;
- (void) sendScrub:(AsyncSocket *)socket;

@end

@implementation ATAirplayVideoService

@synthesize movieView, imageView;

static int PORT = 6001;

#pragma mark -
#pragma mark Init

- (id) init
{
	if(self = [super init])
	{
		bonjourService = [[NSNetService alloc] initWithDomain:@"" type:@"_airplay._tcp" name:@"" port:PORT];
		[bonjourService setDelegate:self];
		
		listeningSocket = [[AsyncSocket alloc] initWithDelegate:self];
	}
	
	return self;
}

#pragma mark -
#pragma mark Public Methods

- (void) start
{
	currentTag = 0;
	
	// Create the listening socket first
	[listeningSocket acceptOnPort:PORT error:NULL];
	
	// Publish the service last
	[bonjourService startMonitoring];
	[bonjourService publish];
}

- (void) showPhoto
{
	[imageView setHidden:NO];
	[movieView setHidden:YES];
	
	NSImage *image = [[NSImage alloc] initWithData:photoData];
	imageView.image = image;
	[image release];
}

#pragma mark -
#pragma mark Socket Delegate

- (void)onSocket:(AsyncSocket *)sock didAcceptNewSocket:(AsyncSocket *)newSocket
{
	// Prepare photo data before listening
	if(photoData)
	{
		[photoData release];
	}
	
	photoData = [[NSMutableData alloc] init];
	
	// Read socket data
	[newSocket readDataWithTimeout:120 tag:[self nextTag]];
}

- (void)onSocket:(AsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag
{
	NSString *message = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
	
	// If it can't be a string, its an image
	if(message == nil)
	{
		[photoData appendData:data];
	}
	
	if(![message contains:@"HTTP/1.1 404"])
	{
		NSLog(@"read new data : %@", message);
	}
	
	// Parse the command that's been sent.
	NSArray *lines = [message componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
	NSString *firstLine = [lines objectAtIndex:0];
	NSArray *words = [firstLine componentsSeparatedByString:@" "];
	NSString *command = [words objectAtIndex:1];
	
	if([command isEqualToString:@"/reverse"])
	{
		[self sendReverse:sock];
	}
	else if([command isEqualToString:@"/play"])
	{
		// Swap the views
		[imageView setHidden:YES];
		[movieView setHidden:NO];
		
		// Get the content location
		NSString *contentLine = [lines objectAtIndex:8];
		NSArray *contentWords = [contentLine componentsSeparatedByString:@" "];
		NSString *contentURL = [contentWords objectAtIndex:1];
		
		// Get the starting position
		NSString *posLine = [lines objectAtIndex:9];
		NSArray *posWords = [posLine componentsSeparatedByString:@" "];
		NSString *posString = [posWords objectAtIndex:1];
		float realPos = [posString floatValue];
		
		movie = [QTMovie movieWithURL:[NSURL URLWithString:contentURL] error:NULL];
		[movie autoplay];
		[movie setCurrentTime:QTMakeTimeWithTimeInterval(realPos)];
		movieView.movie = movie;
	}
	else if([firstLine contains:@"GET /scrub"])
	{
		[self sendScrub:sock];
	}
	else if([firstLine contains:@"POST /scrub"])
	{
		NSArray *scrubComponents = [command componentsSeparatedByString:@"?position="];
		NSString *scrub = [scrubComponents objectAtIndex:1];
		float realScrub = [scrub floatValue];
		QTTime time = QTMakeTimeWithTimeInterval(realScrub);
		
		[movie setCurrentTime:time];
	}
	else if([command contains:@"/rate"])
	{
		NSArray *rateComponents = [command componentsSeparatedByString:@"?value="];
		NSString *rate = [rateComponents objectAtIndex:1];
		float realRate = [rate floatValue];
		
		[movie setRate:realRate];
	}
	else if([command isEqualToString:@"/stop"])
	{
		[movie stop];
		movieView.movie = nil;
	}
	
	[message release];
	
	[self sendOK:sock];
	[sock readDataWithTimeout:120 tag:[self nextTag]];
}
	
#pragma mark -
#pragma mark Private Methods

- (long) nextTag
{
	currentTag++;
	return currentTag;
}

- (void) sendReverse:(AsyncSocket *)socket
{
	NSString *handshake = @"HTTP/1.1 101 Switching Protocols\n"
							"Upgrade: PTTH/1.0\n"
							"Connection: Upgrade\n\n";
	
	[socket writeData:[handshake dataUsingEncoding:NSUTF8StringEncoding] withTimeout:30 tag:[self nextTag]];
}

- (void) sendOK:(AsyncSocket *)socket
{
	NSString *ok = @"HTTP/1.1 200 OK\n"
					"Content-Length: 0\n\n";
	
	[socket writeData:[ok dataUsingEncoding:NSUTF8StringEncoding] withTimeout:30 tag:[self nextTag]];
}

- (void) sendScrub:(AsyncSocket *)socket
{
	NSTimeInterval interval;
	QTGetTimeInterval(movie.currentTime, &interval);
	
	NSTimeInterval duration;
	QTGetTimeInterval(movie.duration, &duration);
	
	NSString *body = [[NSString alloc] initWithFormat:@"duration: %.6f\nposition: %.6f\n",  duration, interval];
	int length = [body length];
	NSString *scrub = [[NSString alloc] initWithFormat:@"HTTP/1.1 200 OK\n"
														"Content-Length: %d\n\n%@\n\n", length, body];
	
	//NSLog(@"SENDING : %@", scrub);
	
	[socket writeData:[scrub dataUsingEncoding:NSUTF8StringEncoding] withTimeout:30 tag:[self nextTag]];
	
	[body release];
	[scrub release];
}

@end
