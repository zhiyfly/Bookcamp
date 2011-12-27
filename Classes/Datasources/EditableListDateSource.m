//
//  EditableListDateSource.m
//  bookcamp
//
//  Created by lin waiwai on 2/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "EditableListDateSource.h"


@implementation EditableListDateSource

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle 
	forRowAtIndexPath:(NSIndexPath *)indexPath{
	if (editingStyle == UITableViewCellEditingStyleDelete) {
		// in edit mode or not
		if (tableView.editing) {
			[self.items removeObjectAtIndex:indexPath.row];
		}
		[tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
		if (!tableView.editing) {
			[self.items removeObjectAtIndex:indexPath.row];
		}
		[tableView endUpdates];
		[tableView beginUpdates];
	}  
}

@end
