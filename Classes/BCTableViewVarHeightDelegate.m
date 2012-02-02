    //
//  BKTableViewVarHeightDelegate.m
//  bookcamp
//
//  Created by lin waiwai on 1/30/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "BCTableViewVarHeightDelegate.h"

// UI
#import "Three20UI/TTTableViewDataSource.h"
#import "Three20UI/TTTableViewCell.h" 

@implementation BCTableViewVarHeightDelegate

- (CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath {
	id<TTTableViewDataSource> dataSource = (id<TTTableViewDataSource>)tableView.dataSource;
	
	id object = [dataSource tableView:tableView objectForRowAtIndexPath:indexPath];
	Class cls = [dataSource tableView:tableView cellClassForObject:object];

	return  [cls tableView:tableView rowHeightForObject:object];
}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section 
{
	if ([tableView.dataSource respondsToSelector:@selector(tableView:titleForHeaderInSection:)]) {
		UIView *headerView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 30)] autorelease];
		UILabel *label = [[[UILabel alloc] initWithFrame:CGRectMake(10, 3, tableView.bounds.size.width - 10, 18)] autorelease];

		label.text = [tableView.dataSource tableView:tableView titleForHeaderInSection:section];
		label.textColor = [UIColor blackColor];
		label.backgroundColor = [UIColor clearColor];
		[headerView addSubview:label];
		[headerView setBackgroundColor:RGBCOLOR(241,241,241)];
		return headerView;
	}
	return nil;
}



@end
