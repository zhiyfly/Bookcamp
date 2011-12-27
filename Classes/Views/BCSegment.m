//
//  BCSegment.m
//  bookcamp
//
//  Created by lin waiwai on 1/30/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
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
