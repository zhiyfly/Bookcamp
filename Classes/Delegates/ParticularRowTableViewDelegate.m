//
//  ParticularRowTableViewDelegate.m
//  bookcamp
//
//  Created by lin waiwai on 7/24/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ParticularRowTableViewDelegate.h"


@implementation ParticularRowTableViewDelegate

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
	if ([cell respondsToSelector:@selector(willBeDisplayed:)]) {
		[cell willBeDisplayed:tableView];
	}
}

@end
