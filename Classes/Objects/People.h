//
//  People.h
//  bookcamp
//
//  Created by lin waiwai on 2/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface People : NSObject  <TTURLRequestDelegate>{
	NSNumber *_uid;
	ObjectStatusFlag _peopleStatus;
	NSString *_signature;
	NSString *_avatar;
	NSString *_name;
}

@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *signature;
@property (nonatomic, retain) NSString *avatar;
@property(nonatomic)ObjectStatusFlag peopleStatus;
@property(nonatomic, retain) NSNumber *uid;

-(id)initWithID:(NSNumber*)uid;
-(void)sync;
@end
