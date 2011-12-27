//
//  BKTableViewVarHeightDelegate.m
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
