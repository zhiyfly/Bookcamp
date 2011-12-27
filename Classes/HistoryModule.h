//
//  HistoryModule.h
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

#import <Foundation/Foundation.h>
#import "HistoryDataSource.h"

@interface HistoryModule : Module {
	TTTableView *_tableView;
	HistoryDataSource *_recordTableViewDataSource;
	BCTableViewVarHeightDelegate *_tableViewVarHeightDelegate;
	TTButton *_editBtn;
	
	NSManagedObjectContext *_managedObjectContext;
	
	NSMutableArray *_fetchedItems;
	NSMutableArray *_sections;
	
	id<TTTableViewDataSource> _dataSource;

}
@property (nonatomic, retain) id<TTTableViewDataSource> dataSource;
@property (nonatomic, retain, readonly) NSMutableArray *fetchedItems;
@property (nonatomic, retain, readonly) NSMutableArray *sections;
@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) BCTableViewVarHeightDelegate *tableViewVarHeightDelegate;
@property (nonatomic, retain, readonly) TTTableView *tableView;
@property (nonatomic, retain, readonly) TTButton *editBtn;
@property (nonatomic, retain) HistoryDataSource *recordTableViewDataSource;

-(void)fetch;
@end
