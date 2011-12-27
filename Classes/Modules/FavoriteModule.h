//
//  FavoriteModule.h
//  bookcamp
//
//  Created by waiwai on 12/19/10.
//  Copyright 2010 __iwaiwai__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EditableListDateSource.h"

@interface FavoriteModule : Module{
	TTTableView *_tableView;
	EditableListDateSource *_recordTableViewDataSource;
	BCTableViewVarHeightDelegate *_tableViewVarHeightDelegate;
	TTButton *_editBtn;
	id<TTTableViewDataSource> _dataSource;
}

@property (nonatomic, retain) id<TTTableViewDataSource> dataSource;
@property (nonatomic, retain, readonly) BCTableViewVarHeightDelegate *tableViewVarHeightDelegate;
@property (nonatomic, retain, readonly) TTTableView *tableView;
@property (nonatomic, retain, readonly) TTButton *editBtn;
@property (nonatomic, retain) EditableListDateSource *recordTableViewDataSource;


@end
