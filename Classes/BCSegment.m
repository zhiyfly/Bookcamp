//
//  BCSegment.m
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

#import "BCSegment.h"

// UI
#import "Three20UI/TTButton.h"
#import "Three20UI/UIViewAdditions.h"

// Style
#import "Three20Style/TTGlobalStyle.h"
#import "Three20Style/TTStyleSheet.h"
#import "Three20Style/TTGridLayout.h"

// Core
#import "Three20Core/TTCorePreprocessorMacros.h"

@implementation BCSegment
@synthesize styleSuffix = _styleSuffix;

///////////////////////////////////////////////////////////////////////////////////////////////////
-(void)dealloc{
	TT_RELEASE_SAFELY(_styleSuffix);
	[super dealloc];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithFrame:(CGRect)frame  {
	if (self = [super initWithFrame:frame]) {	
	}
	return self;
}

-(void)setStyleSuffix:(NSString *)newSuffix{
	if (newSuffix != _styleSuffix) {
		_styleSuffix = [newSuffix retain];
		self.style = (_styleSuffix ? [TTSTYLESHEET styleWithSelector:[_styleSuffix stringByAppendingString:@"SegmentBar"]]
					  :TTSTYLE(segmentBar));
		if ([self.tabItems count]>0) {
			[self updateTabStyles];
		}
	}
}

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Private

///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSInteger)rowCount {
	return 1;
}

-(NSInteger)columnCount{
	return self.tabViews.count;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)updateTabStyles {
	CGFloat columnCount = [self columnCount];

	int column = 0;
	for (TTTab* tab in self.tabViews) {
	if (column == 0) {
		[tab setStylesWithSelector:(_styleSuffix ? [_styleSuffix stringByAppendingString:@"SegmentLeft:"]: @"segmentLeft:")];
	} else if (column == columnCount-1) {
		[tab setStylesWithSelector:(_styleSuffix ? [_styleSuffix stringByAppendingString:@"SegmentRight:"]: @"segmentRight:")];
	} else {
		[tab setStylesWithSelector:(_styleSuffix ? [_styleSuffix stringByAppendingString:@"SegmentCenter:"]: @"segmentCenter:")];
	}
		++column;
	}
}


///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark UIView


/////////////////////////////////////////////////////////////////////////////////////////////////
- (CGSize)sizeThatFits:(CGSize)size {
	CGSize styleSize = [super sizeThatFits:size];
	return CGSizeMake(size.width, styleSize.height);
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setTabItems:(NSArray*)tabItems {
	[super setTabItems:tabItems];
	self.style = (_styleSuffix ? [TTSTYLESHEET styleWithSelector:[_styleSuffix stringByAppendingString:@"SegmentBar"]]
															   :TTSTYLE(segmentBar));
}



@end
