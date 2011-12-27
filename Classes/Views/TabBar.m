//
//  TabBar.m
//  bookcamp
//
//  Created by waiwai on 12/15/10.
//  Copyright 2010 __iwaiwai__. All rights reserved.
//

#import "TabBar.h"


@implementation TabBar

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setTabItems:(NSArray*)tabItems {
	[_tabItems release];
	_tabItems =  [tabItems retain];
	
	for (int i = 0; i < _tabViews.count; ++i) {
		TTTab* tab = [_tabViews objectAtIndex:i];
		[tab removeFromSuperview];
	}
	
	[_tabViews removeAllObjects];
	
	if (_selectedTabIndex >= _tabViews.count) {
		_selectedTabIndex = 0;
	}
	
	for (int i = 0; i < _tabItems.count; ++i) {
		TTTabItem* tabItem = [_tabItems objectAtIndex:i];
		TTTab* tab = [[[TTTab alloc] initWithItem:tabItem tabBar:self] autorelease];
		[tab setStylesWithSelector:self.tabStyle];
		
		[tab addTarget:self action:@selector(tabTouchedUp:) forControlEvents:UIControlEventTouchUpInside];
		[self addTab:tab];
		[_tabViews addObject:tab];
		if (i == _selectedTabIndex) {
			tab.selected = YES;
		}
	}
	
	[self setNeedsLayout];
}

@end
