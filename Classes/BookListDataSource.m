//
//  BookListDataSource.m
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
