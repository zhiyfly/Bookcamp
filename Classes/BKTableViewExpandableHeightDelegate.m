//
//  BKTableViewExpandableHeightDelegate.m
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

#import "BKTableViewExpandableHeightDelegate.h"

// UI
#import "Three20UI/TTTableViewDataSource.h"
#import "Three20UI/TTTableViewCell.h" 

@implementation BKTableViewExpandableHeightDelegate

@synthesize selectedCellIndexPath = _selectedCellIndexPath;

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)dealloc {
	TT_RELEASE_SAFELY(_selectedCellIndexPath);
	[super dealloc];
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	id<TTTableViewDataSource> dataSource = (id<TTTableViewDataSource>)tableView.dataSource;
	NSArray *reloadRows;
	id object = [dataSource tableView:tableView objectForRowAtIndexPath:indexPath];
	if (_selectedCellIndexPath && [_selectedCellIndexPath compare:indexPath] != NSOrderedSame) {
		reloadRows = [NSArray arrayWithObjects:_selectedCellIndexPath,indexPath,nil];
		[object setSelected:YES];
		object = [dataSource tableView:tableView objectForRowAtIndexPath:_selectedCellIndexPath];
		[object setSelected:NO];
	}else {
		reloadRows = [NSArray arrayWithObject:indexPath];
		[object setSelected:![object selected]];
	}
	[tableView reloadRowsAtIndexPaths:reloadRows withRowAnimation:UITableViewRowAnimationNone];  
	self.selectedCellIndexPath = indexPath ; 
	

}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath {
	[super tableView:tableView didSelectRowAtIndexPath:indexPath];
	
	
}

@end
