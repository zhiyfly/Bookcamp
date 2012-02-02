//
//  BKLink.m
//
// Created by lin waiwai(jiansihun@foxmail.com) on 1/19/11.
// Copyright 2011 __waiwai__. All rights reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
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
