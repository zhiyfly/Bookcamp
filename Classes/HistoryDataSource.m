//
//  HistoryDataSource.m
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

#import "HistoryDataSource.h"
#import "Book.h"
#import "SimpleBookItem.h"
@interface HistoryDataSource (Private)


- (void)bookContextDidSave:(NSNotification*)saveNotification;


@end


@implementation HistoryDataSource (Private)

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)bookContextDidSave:(NSNotification*)saveNotification {
	NSArray *insertedObjects = [saveNotification.userInfo objectForKey:NSInsertedObjectsKey];
	HistoryModel* aModel  = (HistoryModel*)self.model;
	NSString *author;
	for (Book *book in insertedObjects) {
		[aModel.books insertObject:book atIndex:0];
		if ([book.authors count] > 0) {
			author = [book.authors objectAtIndex:0];
		} else {
			author = @"";
		}
		
		NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
		[dateFormatter setDateFormat:@"yyyy-MM-dd"];
		[dateFormatter setLocale:[NSLocale currentLocale]];
		NSString* dateStr = [dateFormatter stringFromDate:book.pubdate];
		
		
		if ([self.sections count] == 0 ) {
			[self.sections addObject:dateStr];
			[self.items addObject:[NSMutableArray array]];
		}
		[[self.items objectAtIndex:0] insertObject:[SimpleBookItem itemWithText:book.bookName 
																		caption:[NSString stringWithFormat:@"%@/%@/%@",author,book.publisher, 
																				 dateStr]
																			URL:[NSString stringWithFormat:@"tt://book/%@",book.oid]]
										   atIndex:0];
		NSIndexPath *indexPath = [NSIndexPath  indexPathForRow:0 inSection:0];
		[aModel didInsertObject:book atIndexPath:indexPath];
	}
	NSManagedObjectContext *context = (NSManagedObjectContext*)saveNotification.object;
	
	[aModel.managedObjectContext mergeChangesFromContextDidSaveNotification:saveNotification];
	
}



@end

@implementation HistoryDataSource

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)dealloc {
	NSNotificationCenter *dnc = [NSNotificationCenter defaultCenter];
	[dnc removeObserver:self name:HistoriedObjectContextDidSaveNotification object:nil];
	TT_RELEASE_SAFELY (_historyModel);
    [super dealloc];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
-(id)init{
	if (self = [super init]) {
		_historyModel = [[HistoryModel alloc] init];
		NSNotificationCenter *dnc = [NSNotificationCenter defaultCenter];
		[dnc addObserver:self selector:@selector(bookContextDidSave:) name:HistoriedObjectContextDidSaveNotification object:nil];
	}
	return self;
}



///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle 
						forRowAtIndexPath:(NSIndexPath *)indexPath{
	//remove from datebase
	HistoryModel* aModel  = (HistoryModel*)self.model;
	Book *book = [aModel.books objectAtIndex:indexPath.row];
 	NSManagedObjectContext *moc  = book.managedObjectContext;
	[moc deleteObject:book];
	[aModel.books removeObjectAtIndex:indexPath.row];
	NSError *error = nil;
	if ([moc save:&error]) {
		[super tableView:tableView commitEditingStyle:editingStyle forRowAtIndexPath:indexPath];
	} else {
		BCNSLog(@"Unresolved error %@, %@", error, [error userInfo]);
	}	
	
	
}


- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell *cell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
	TTView *backgroundView = [[[TTView alloc] initWithFrame:cell.bounds] autorelease];
	backgroundView.style = TTSTYLE(favoriteTableCellStyle);
	cell.backgroundView = backgroundView;
	return cell;
}

-(NSMutableArray*)sections{
	if (!_sections) {
		_sections = [[NSMutableArray alloc] init];
	}
	return _sections;
}

-(NSMutableArray*)items{
	if (!_items) {
		_items = [[NSMutableArray alloc] init];
	}
	return _items;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)tableViewDidLoadModel:(UITableView*)tableView {
	HistoryModel* aModel  = (HistoryModel*)self.model;
	NSString *lastDate = nil;
	NSMutableArray *rows ;
	NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
	[dateFormatter setDateFormat:@"yyyy-MM-dd"];
	[dateFormatter setLocale:[NSLocale currentLocale]];
	NSString *author;
	for (Book *book in aModel.books) {
		NSString* dateStr = [dateFormatter stringFromDate:book.savedDate];
		if ([book.authors count] > 0) {
			author = [book.authors objectAtIndex:0];
		} else {
			author = @"";
		}
		if (![dateStr isEqualToString:lastDate]  ) {
			rows = [NSMutableArray array];
			[self.items addObject:rows];
			if (dateStr) {
				[self.sections addObject:dateStr];
			}
		}
		[rows addObject:[SimpleBookItem itemWithText:book.bookName 
											 caption:[NSString stringWithFormat:@"%@/%@/%@",author,book.publisher, 
													  dateStr]
												 URL:[NSString stringWithFormat:@"tt://book/%@",book.oid]]];
		lastDate = dateStr;
	}
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (id<TTModel>)model {
	return _historyModel;
}


@end
