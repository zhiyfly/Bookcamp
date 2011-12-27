//
//  BookObject.h
//  bookcamp
//
//  Created by lin waiwai on 2/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MBProgressHUD.h"

@interface BookObject :NSObject  <TTURLRequestDelegate>{
	NSNumber *_isbn13;
	NSNumber *_isbn10;
	NSNumber *_oid;
	NSString *_thumbURL;
	NSNumber *_averageRate;
	NSString *_bookName;
	NSString *_summary;
	NSMutableArray *_authors;
	NSString *_authorIntro;
	NSNumber *_price;
	NSString *_publisher;
	NSDate *_pubdate;
	NSNumber *_numRaters;
	NSNumber *_pages;
	
	ObjectStatusFlag _bookStatus;
}

@property (nonatomic, retain) NSNumber *isbn13;
@property (nonatomic, retain) NSNumber *isbn10;
@property (nonatomic, retain) NSNumber *pages;
@property (nonatomic, retain) NSNumber *numRaters;
@property (nonatomic, retain) NSDate *pubdate;
@property (nonatomic)ObjectStatusFlag bookStatus;
@property (nonatomic, retain) NSNumber *oid;
@property (nonatomic, retain) NSString *thumbURL;
@property (nonatomic, retain) NSNumber *averageRate;
@property (nonatomic, retain) NSString *bookName;
@property (nonatomic, retain) NSString *summary;
@property (nonatomic, retain) NSMutableArray *authors;
@property (nonatomic, retain) NSString  *authorIntro;
@property (nonatomic, retain) NSNumber *price;
@property (nonatomic, retain) NSString *publisher;


-(id)initWithBookID:(NSNumber*)bookID;
-(void)sync;

@end
