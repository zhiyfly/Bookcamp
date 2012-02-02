//
//  BKTabBar.m
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
#import "BKTabBar.h"


@implementation BKTabBar

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
		if ([tabItem respondsToSelector:@selector(style)] && [tabItem style]) {
			[tab setStylesWithSelector:[tabItem style]];
		} else {
			[tab setStylesWithSelector:self.tabStyle];
		}
		
		[tab        addTarget: self
					   action: @selector(tabTouchedUp:)
			 forControlEvents: UIControlEventTouchUpInside];
		[self addTab:tab];
		[_tabViews addObject:tab];
		if (i == _selectedTabIndex) {
			tab.selected = YES;
		}
	}
	
	[self setNeedsLayout];
}

@end
