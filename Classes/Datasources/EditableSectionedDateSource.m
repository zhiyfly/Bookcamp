//
//  EditableSectionedDateSource.m
//  bookcamp
//
//  Created by lin waiwai on 2/1/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "EditableSectionedDateSource.h"

@implementation EditableSectionedDateSource
///////////////////////////////////////////////////////////////////////////////////////////////////
- (Class)tableView:(UITableView*)tableView cellClassForObject:(id)object {
	if ([object isKindOfClass:[TTTableItem class]]) {
		return NSClassFromString([NSStringFromClass([object class]) stringByAppendingString:@"Cell"]);
	}
	// This will display an empty white table cell - probably not what you want, but it
	// is better than crashing, which is what happens if you return nil here
	return [super tableView:tableView cellClassForObject:object];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle 
											forRowAtIndexPath:(NSIndexPath *)indexPath{
	if (editingStyle == UITableViewCellEditingStyleDelete) {
		NSInteger rowCount = [tableView.dataSource tableView:tableView numberOfRowsInSection:indexPath.section];
		// in edit mode or not
		if (tableView.editing) {
			[self removeItemAtIndexPath:indexPath andSectionIfEmpty:YES];
		}
		//if it's the last one
		if (rowCount == 1) {
			[tableView deleteSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationFade];
		} else {
			[tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
		}
		if (!tableView.editing) {
			[self removeItemAtIndexPath:indexPath andSectionIfEmpty:YES];
		}
		[tableView endUpdates];
		[tableView beginUpdates];
	}  
	
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)dealloc {
    [super dealloc];
}


@end
