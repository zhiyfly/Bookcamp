//
//  CommentAuthorInfoItem.h
//  bookcamp
//
//  Created by waiwai on 12/26/10.
//  Copyright 2010 __iwaiwai__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CommentAuthorInfoItem : NSObject {
	NSString *_avatarURL;
	NSString *_name;
	NSString *_signature;

}

@property (nonatomic, copy)		NSString* name;
@property (nonatomic, copy)		NSString* signature;
@property (nonatomic, copy)		NSString* avatarURL;

+ (id)itemWithName:(NSString*)name signature:(NSString*)signature 
		 avatarURL:(NSString*)avatarURL ;

@end
