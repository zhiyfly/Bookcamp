//
//  FavoriteModel.h
//  bookcamp
//
//  Created by lin waiwai on 3/13/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FavoriteModel : TTModel {
	NSMutableArray *_books;
	NSDate* _loadedTime;
	NSManagedObjectContext *_managedObjectContext;
	NSUInteger offset;
	NSUInteger count;
}

@property (nonatomic) NSUInteger count;
@property (nonatomic, retain) NSDate*   loadedTime;
@property (nonatomic, retain, readonly) NSMutableArray *books;
@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;

@end
