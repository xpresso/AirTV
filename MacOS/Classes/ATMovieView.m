//
//  ATMovieView.m
//  AirTV
//
//  Created by Andy Roth on 12/16/10.
//  Copyright 2010 Resource Interactive. All rights reserved.
//

#import "ATMovieView.h"


@implementation ATMovieView

- (void) keyDown:(NSEvent *)theEvent
{
	if([theEvent keyCode] == 53)
	{
		if([self isInFullScreenMode])
		{
			[self exitFullScreenModeWithOptions:nil];
		}
	}
}

@end
