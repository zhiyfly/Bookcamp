//
//  HistoryModule.h
//  bookcamp
//
//  Created by waiwai on 12/19/10.
//  Copyright 2010 __iwaiwai__. All rights reserved.
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
