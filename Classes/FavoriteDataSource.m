//
//  FavoriteDataSource.m
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
#import "FavoriteDataSource.h"
#import "Book.h"
#import "SimpleBookItem.h"
@interface FavoriteDataSource (Private)

- (void)bookContextDidSave:(NSNotification*)saveNotification;

@end

@implementation FavoriteDataSource (Private)

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)bookContextDidSave:(NSNotification*)saveNotification {
	NSArray *insertedObjects = [saveNotification.userInfo objectForKey:NSInsertedObjectsKey];
	Book *book;
	FavoriteModel* aModel  = (FavoriteModel*)self.model;
	NSString *author;
	for ( book in insertedObjects) {
		
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
		
		[self.items insertObject:[SimpleBookItem itemWithText:book.bookName 
													  caption:[NSString stringWithFormat:@"%@%@%@",
															   author?[NSString stringWithFormat:@"%@/",author]:@"",
															   book.publisher?[NSString stringWithFormat:@"%@/",book.publisher]:@"",
															   dateStr?[NSString stringWithFormat:@"%@",dateStr]:@""]
														  URL:[NSString stringWithFormat:@"tt://book/%@",book.oid]]
						 atIndex:0];
		NSIndexPath *indexPath = [NSIndexPath  indexPathForRow:0 inSection:0];
		[aModel didInsertObject:book atIndexPath:indexPath];
	}
	NSManagedObjectContext *context = (NSManagedObjectContext*)saveNotification.object;
	
	[aModel.managedObjectContext mergeChangesFromContextDidSaveNotification:saveNotification];
}

@end

@implementation FavoriteDataSource

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)dealloc {
	NSNotificationCenter *dnc = [NSNotificationCenter defaultCenter];
	[dnc removeObserver:self name:FavoritedObjectContextDidSaveNotification object:nil];
	TT_RELEASE_SAFELY (_favoriteModel);
    [super dealloc];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
-(id)init{
	if (self = [super init]) {
		_favoriteModel = [[FavoriteModel alloc] init];
		NSNotificationCenter *dnc = [NSNotificationCenter defaultCenter];
		[dnc addObserver:self selector:@selector(bookContextDidSave:) name:FavoritedObjectContextDidSaveNotification object:nil];
	}
	return self;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle 
	forRowAtIndexPath:(NSIndexPath *)indexPath{
	//remove from datebase
	FavoriteModel* aModel  = (FavoriteModel*)self.model;
	Book *book = [aModel.books objectAtIndex:indexPath.row];
	[aModel.books removeObjectAtIndex:indexPath.row];
 	NSManagedObjectContext *moc  = book.managedObjectContext;
	[moc deleteObject:book];
	NSError *error;
	if ([moc save:&error]) {
		[super tableView:tableView commitEditingStyle:editingStyle forRowAtIndexPath:indexPath];
	} else {
		BCNSLog(@"Unresolved error %@, %@", error, [error userInfo]);
	}	
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)tableViewDidLoadModel:(UITableView*)tableView {
	FavoriteModel* aModel  = (FavoriteModel*)self.model;
	NSString *author;
	NSUInteger offset = [[self.items lastObject] isKindOfClass:[TTTableMoreButton class]]?[self.items count]-1:[self.items count];
	
	for (int i = offset; i < [aModel.books count]; i++) {
		Book *book = [aModel.books objectAtIndex:i];

		if ([book.authors count] > 0) {
			author = [book.authors objectAtIndex:0];
		} else {
			author = @"";
		}
		
		NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
		[dateFormatter setDateFormat:@"yyyy-MM-dd"];
		[dateFormatter setLocale:[NSLocale currentLocale]];
		NSString* dateStr = [dateFormatter stringFromDate:book.pubdate];
		
	
		if ([self.items count] > 0 && [[self.items lastObject] isKindOfClass:[TTTableMoreButton class]]) {
			[self.items removeLastObject];
		}
		
		[self.items addObject:[SimpleBookItem itemWithText:book.bookName 
												   caption:[NSString stringWithFormat:author&&dateStr?@"%@/%@":@"%@%@",
															author?[NSString stringWithFormat:@"%@",author]:@"",
															dateStr?[NSString stringWithFormat:@"%@",dateStr]:@""]
													   URL:[NSString stringWithFormat:@"tt://book/%@",book.oid]]];
		
		if (aModel.count != NSNotFound && aModel.count > [self.items count] ) {
			[self.items addObject:[TTTableMoreButton itemWithText:BCLocalizedString(@"load more", @"load more")]];
		} 
	}
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (UITableViewCell*)tableView:(UITableView *)tableView
		cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell *cell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
	TTView *backgroundView = [[[TTView alloc] initWithFrame:cell.bounds] autorelease];
	backgroundView.style = TTSTYLE(favoriteTableCellStyle);
	cell.backgroundView = backgroundView;

	// the clear color don't make effect , but cell may be redrawed so it was brought to front .fix the problem that the background view was covered
	if ([cell isKindOfClass:[TTTableMoreButtonCell class]]) {
		[[cell textLabel] setBackgroundColor:[UIColor clearColor]];
	}
	return cell;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (id<TTModel>)model {
	return _favoriteModel;
}





@end
