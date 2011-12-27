//
//  CommentAuthorInfoItem.m
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
