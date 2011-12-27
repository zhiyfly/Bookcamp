//
//  CommentDetailView.h
//  bookcamp
//
//  Created by waiwai on 12/22/10.
//  Copyright 2010 __iwaiwai__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface CommentDetailView : NSObject <NSCoding>{
	NSString	*_name;
	NSString	*_signature;
	NSNumber	*_rating;
	NSString	*_avatarURL;
}

@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *signature;
@property (nonatomic, retain) NSNumber *rating;
@property (nonatomic, retain) NSString *avatarURL;

@end
