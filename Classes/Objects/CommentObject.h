//
//  CommentObject.h
//  bookcamp
//
//  Created by lin waiwai on 2/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "People.h"
@interface CommentObject : NSObject  <TTURLRequestDelegate>{
	NSNumber *_cid;
	NSString *_title;
	NSString *_content;
	NSNumber *_rating;
	NSDate	*_updated;
	NSNumber *_votes;
	NSNumber *_unvotes;
	People *_author;
	ObjectStatusFlag _commentStatus;
	
}
-(void)sync;
@property (nonatomic, retain) NSNumber *unvotes;
@property (nonatomic, retain) NSNumber *cid;
@property (nonatomic, retain) People *author;
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *content;
@property (nonatomic, retain) NSNumber *rating;
@property (nonatomic, retain) NSDate *updated;
@property (nonatomic, retain) NSNumber *votes;
@property (nonatomic) ObjectStatusFlag commentStatus;

@end
