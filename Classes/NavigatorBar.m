//
//  DetailToolbar.m
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

#import "NavigatorBar.h"
// UI
#import "Three20UI/TTImageView.h"
#import "Three20UI/TTTableMessageItem.h"
#import "Three20UI/UIViewAdditions.h"
#import "Three20Style/UIFontAdditions.h"

// Style
#import "Three20Style/TTGlobalStyle.h"
#import "Three20Style/TTDefaultStyleSheet.h"

// Core
#import "Three20Core/TTCorePreprocessorMacros.h"
#import "Three20Core/NSDateAdditions.h"

static const int NavigatorBarLeftPadding = 10;
static const int NavigatorBarRightPadding = 10;
static const int NavigatorItemGap = 5;

@implementation NavigatorBar

@synthesize leftPadding ;
@synthesize rightPadding ;
@synthesize itemGap;
@synthesize navigatorLeftViews = _navigatorLeftViews;
@synthesize navigatorRightViews = _navigatorRightViews;
@synthesize navigatorCenterViews = _navigatorCenterViews;

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)dealloc {
	TT_RELEASE_SAFELY(_navigatorLeftViews);
	TT_RELEASE_SAFELY(_navigatorRightViews);
	TT_RELEASE_SAFELY(_navigatorCenterViews);
	
	[super dealloc];
}


-(id) initWithFrame:(CGRect)frame{
	if (self = [super initWithFrame:frame]) {
		self.autoresizesSubviews = YES;
		self.autoresizingMask = UIViewAutoresizingFlexibleWidth	| UIViewAutoresizingFlexibleBottomMargin;
		leftPadding = -1;
		rightPadding = -1;
		itemGap = -1;
	}
	return self;
}

-(NSMutableArray*)navigatorLeftViews{
	if (!_navigatorLeftViews) {
		_navigatorLeftViews = [[NSMutableArray alloc] initWithCapacity:1];
	}
	return _navigatorLeftViews;
}

-(NSMutableArray*)navigatorRightViews{
	if (!_navigatorRightViews) {
		_navigatorRightViews = [[NSMutableArray alloc] initWithCapacity:1];
	}
	return _navigatorRightViews;
}

-(NSMutableArray*)navigatorCenterViews{
	if (!_navigatorCenterViews) {
		_navigatorCenterViews = [[NSMutableArray alloc] initWithCapacity:1];
	}
	return _navigatorCenterViews;
}



///////////////////////////////////////////////////////////////////////////////////////////////////
-(void)addToNavigatorView:(UIView*)aView align:(NavigationViewAlignment)align{
	
	CGRect viewFrame = self.frame;
	CGFloat viewHeight = CGRectGetHeight(viewFrame);
	CGFloat viewWidth = CGRectGetWidth(viewFrame);
	if (leftPadding == -1) {
		leftPadding == NavigatorBarLeftPadding;
	}
	if (rightPadding == -1) {
		rightPadding  == NavigatorBarRightPadding;
	}
	if (itemGap == -1) {
		itemGap = NavigatorItemGap;
	}
	
	aView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleTopMargin; 
	switch (align) {
		case NavigationViewAlignCenter:	
			if ([self.navigatorCenterViews count] > 0) {
				for (UIView *sub in self.navigatorCenterViews) {
					sub.frame = CGRectMake(CGRectGetMinX(sub.frame)-(CGRectGetWidth(aView.frame)+itemGap)/2, 
										   CGRectGetMinY(sub.frame), 
										   CGRectGetWidth(sub.frame), 
										   CGRectGetHeight(sub.frame));
				}
				aView.frame = CGRectMake(CGRectGetMaxX([[self.navigatorCenterViews lastObject] frame]) + itemGap, 
										 (viewHeight - CGRectGetHeight(aView.frame))/2, 
										 CGRectGetWidth(aView.frame), 
										 CGRectGetHeight(aView.frame));
			}
			else {
				aView.frame = CGRectMake((viewWidth - CGRectGetWidth(aView.frame))/2, 
										 (viewHeight - CGRectGetHeight(aView.frame))/2, 
										 CGRectGetWidth(aView.frame), 
										 CGRectGetHeight(aView.frame));
			}
			[self.navigatorCenterViews addObject:aView];
			break;
		case NavigationViewAlignRight:
			aView.frame = CGRectMake([self.navigatorRightViews count]>0 ? 
									 (CGRectGetMinX( [[self.navigatorRightViews lastObject] frame]) - itemGap - CGRectGetWidth(aView.frame))
									 :viewWidth - rightPadding-CGRectGetWidth(aView.frame), 
									 (viewHeight - CGRectGetHeight(aView.frame))/2, 
									 CGRectGetWidth(aView.frame), 
									 CGRectGetHeight(aView.frame));
			
			[self.navigatorRightViews addObject:aView];
			break;
		case NavigationViewAlignLeft:
		default:
			aView.frame = CGRectMake([self.navigatorLeftViews count]>0 ? 
									 (leftPadding + CGRectGetMaxX([[self.navigatorLeftViews lastObject] frame]) + itemGap)
									 :leftPadding, 
									 (CGRectGetHeight(viewFrame) - CGRectGetHeight(aView.frame))/2, 
									 CGRectGetWidth(aView.frame), 
									 CGRectGetHeight(aView.frame));
			
			[self.navigatorLeftViews addObject:aView];
			break;
	}
	[self addSubview:aView];
	
}




@end
