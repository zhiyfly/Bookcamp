//
//  BookHeadItem.m
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

#import "BookHeadItem.h"
// Core
#import "Three20Core/TTCorePreprocessorMacros.h"


@implementation BookHeadItem

@synthesize bookName = _bookName;
@synthesize bookThumbURL = _bookThumbURL;
@synthesize parityURL = _parityURL;
@synthesize bookCommentURL = _bookCommentURL;
@synthesize rating = _rating;
@synthesize evaluationNum = _evaluationNum;




///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)dealloc {
	TT_RELEASE_SAFELY(_bookName);
	TT_RELEASE_SAFELY(_bookThumbURL);
	TT_RELEASE_SAFELY(_parityURL);
	TT_RELEASE_SAFELY(_bookCommentURL);
	TT_RELEASE_SAFELY(_rating);
	TT_RELEASE_SAFELY(_evaluationNum);
	[super dealloc];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
+ (id)itemWithBook:(NSString*)name thumbURL:(NSString*)thumbURL parityURL:(NSString*)parityURL 
	bookCommentURL:(NSString*)commentURL rating:(NSNumber*)rating evaluationNum:(NSNumber*)evaluationNum{
	BookHeadItem* item = [[[self alloc] init] autorelease];
	item.bookName = name;
	item.bookThumbURL = thumbURL;
	item.parityURL = parityURL;
	item.bookCommentURL = commentURL;
	item.rating = rating;
	item.evaluationNum = evaluationNum;
	return item;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark NSCoding

///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithCoder:(NSCoder*)decoder {
	if (self = [super initWithCoder:decoder]) {
		self.bookName = [decoder decodeObjectForKey:@"bookName"];
		self.bookThumbURL = [decoder decodeObjectForKey:@"bookThumbURL"];
		self.parityURL = [decoder decodeObjectForKey:@"parityURL"];
		self.bookCommentURL = [decoder decodeObjectForKey:@"bookCommentURL"];
		self.rating = [decoder decodeObjectForKey:@"rating"];
		self.evaluationNum = [decoder decodeObjectForKey:@"evaluationNum"];
	}
	return self;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)encodeWithCoder:(NSCoder*)encoder {
	[super encodeWithCoder:encoder];
	if (self.bookName) {
		[encoder encodeObject:self.bookName forKey:@"bookName"];
	}
	if (self.bookThumbURL) {
		[encoder encodeObject:self.bookThumbURL forKey:@"bookThumbURL"];
	}
	if (self.parityURL) {
		[encoder encodeObject:self.parityURL forKey:@"parityURL"];
	}
	if (self.bookCommentURL) {
		[encoder encodeObject:self.bookCommentURL forKey:@"bookCommentURL"];		 
	}
	if (self.rating) {
		[encoder encodeObject:self.rating forKey:@"rating"];		 
	}
	if (self.evaluationNum) {
		[encoder encodeObject:self.evaluationNum forKey:@"evaluationNum"];
	}
}



@end
