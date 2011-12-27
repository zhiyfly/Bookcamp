//
//  BKLink.m
//  bookcamp
//
//  Created by waiwai on 12/29/10.
//  Copyright 2010 __iwaiwai__. All rights reserved.
//

#import "BKLink.h"


// UI
#import "Three20UI/TTNavigator.h"
#import "Three20UI/TTView.h"

// UINavigator
#import "Three20UINavigator/TTURLAction.h"

// Style
#import "Three20Style/TTGlobalStyle.h"
#import "Three20Style/TTStyleSheet.h"
#import "Three20Style/TTShape.h"

// Core
#import "Three20Core/TTCorePreprocessorMacros.h"

@implementation BKLink


@synthesize URLAction = _URLAction;




///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)dealloc {
	TT_RELEASE_SAFELY(_URLAction);
	
	[super dealloc];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Private


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)linkTouched {
	[[TTNavigator navigator] openURLAction:_URLAction];
}



///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setURLAction:(TTURLAction*)URLAction {
	[URLAction retain];
	[_URLAction release];
	_URLAction = URLAction;
	
	self.userInteractionEnabled = !!URLAction;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)URL {
	return _URLAction.urlPath;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setURL:(id)URL {
	[self addTarget: self
             action: @selector(linkTouched) forControlEvents:UIControlEventTouchUpInside];
	self.URLAction = [[TTURLAction actionWithURLPath:URL] applyAnimated:YES];
}




@end
