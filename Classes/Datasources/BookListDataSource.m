//
//  BookListDataSource.m
//  bookcamp
//
//  Created by waiwai on 12/19/10.
//  Copyright 2010 __iwaiwai__. All rights reserved.
//

#import "BookListDataSource.h"


@implementation BookListDataSource

///////////////////////////////////////////////////////////////////////////////////////////////////
- (Class)tableView:(UITableView*)tableView cellClassForObject:(id)object {
	if ([object isKindOfClass:[TTTableItem class]]) {
		return NSClassFromString([NSStringFromClass([object class]) stringByAppendingString:@"Cell"]);
	}
	id cell = [super tableView:tableView cellClassForObject:object];
	// This will display an empty white table cell - probably not what you want, but it
	// is better than crashing, which is what happens if you return nil here
	return cell;
}

@end
