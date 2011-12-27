//
//  CommentAuthorInfoItem.m
//  bookcamp
//
//  Created by waiwai on 12/26/10.
//  Copyright 2010 __iwaiwai__. All rights reserved.
//

#import "CommentAuthorInfoItem.h"

// Core
#import "Three20Core/TTCorePreprocessorMacros.h"

@implementation CommentAuthorInfoItem

@synthesize avatarURL = _avatarURL;
@synthesize name = _name;
@synthesize signature = _signature;


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)dealloc {
	TT_RELEASE_SAFELY(_avatarURL);
	TT_RELEASE_SAFELY(_name);
	TT_RELEASE_SAFELY(_signature);

	[super dealloc];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
+ (id)itemWithName:(NSString*)name signature:(NSString*)signature  
		 avatarURL:(NSString*)avatarURL {
	CommentAuthorInfoItem* item = [[[self alloc] init] autorelease];
	item.name = name;
	item.signature = signature;
	item.avatarURL = avatarURL;
	return item;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark NSCoding

///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithCoder:(NSCoder*)decoder {
	if (self = [super initWithCoder:decoder]) {
		self.avatarURL = [decoder decodeObjectForKey:@"avatarURL"];
		self.name = [decoder decodeObjectForKey:@"name"];
		self.signature = [decoder decodeObjectForKey:@"signature"];

	}
	return self;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)encodeWithCoder:(NSCoder*)encoder {
	[super encodeWithCoder:encoder];
	if (self.avatarURL) {
		[encoder encodeObject:self.avatarURL forKey:@"avatarURL"];
	}
	if (self.name) {
		[encoder encodeObject:self.name forKey:@"name"];
	}
	if (self.signature) {
		[encoder encodeObject:self.signature forKey:@"signature"];
	}

}

@end
