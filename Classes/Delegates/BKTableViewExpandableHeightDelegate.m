//
//  BKTableViewExpandableHeightDelegate.m
//  bookcamp
//
//  Created by waiwai on 1/2/11.
//  Copyright 2011 __iwaiwai__. All rights reserved.
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
