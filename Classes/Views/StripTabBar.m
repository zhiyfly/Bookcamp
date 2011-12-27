//
//  StripTabBar.m
//  bookcamp
//
//  Created by lin waiwai on 7/24/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "StripTabBar.h"


@implementation StripTabBar

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)updateTabStyles {
	int columnCount = [self.tabViews count];
	int column = 0;
	for (TTTab* tab in self.tabViews) {
		if (column == 0) {
			[tab setStylesWithSelector:@"stripTabLeft:"];
		} else if (column == columnCount - 1) {
			[tab setStylesWithSelector:@"stripTabRight:"];
		} else {
			[tab setStylesWithSelector:@"stripTabCenter:"];
		}
		++column;
	}
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setTabItems:(NSArray*)tabItems {
	[super setTabItems:tabItems];
	[self updateTabStyles];
}


@end
