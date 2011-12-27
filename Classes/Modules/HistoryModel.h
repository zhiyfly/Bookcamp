//
//  HistoryModel.h
//  bookcamp
//
//  Created by lin waiwai on 3/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface HistoryModel : TTModel {
	NSMutableArray *_books;
	NSDate* _loadedTime;
	NSManagedObjectContext *_managedObjectContext;
}

@property (nonatomic, retain) NSDate*   loadedTime;
@property (nonatomic, retain, readonly) NSMutableArray *books;
@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@end
