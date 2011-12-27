//
//  CommentContentItem.m
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

#import "CommentContentItem.h"

// Core
#import "Three20Core/TTCorePreprocessorMacros.h"

@implementation CommentContentItem

@synthesize text = _text;
@synthesize	date = _date;
@synthesize	profitIt = _profitIt;
@synthesize	count = _count;
@synthesize rating = _rating;


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)dealloc {
	TT_RELEASE_SAFELY(_text);
	TT_RELEASE_SAFELY(_styledContent);
	TT_RELEASE_SAFELY(_date);
	TT_RELEASE_SAFELY(_profitIt);
	TT_RELEASE_SAFELY(_count);
	TT_RELEASE_SAFELY(_rating);
	[super dealloc];
}
															   

+ (id)itemWithContent:(NSString*)text date:(NSDate*)date  rating:(NSNumber*)rating  profitIt:(NSNumber*)profitIt count:(NSNumber*)count{
	CommentContentItem* item = [[[self alloc] init] autorelease];
	item.text = text;
	item.date = date;
	item.profitIt = profitIt;
	item.count = count;
	item.rating = rating;
	return item;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
-(TTStyledText*)styledContent{
	if (!_styledContent) {
		_styledContent = [[TTStyledText textFromXHTML:self.text lineBreaks:YES URLs:YES] retain];
	}
	return _styledContent;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark NSCoding

///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithCoder:(NSCoder*)decoder {
	if (self = [super initWithCoder:decoder]) {
		self.text = [decoder decodeObjectForKey:@"text"];
		self.date = [decoder decodeObjectForKey:@"date"];
		self.profitIt = [decoder decodeObjectForKey:@"profitIt"];
		self.count = [decoder decodeObjectForKey:@"count"];
		self.rating = [decoder decodeObjectForKey:@"rating"];
	}
	return self;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)encodeWithCoder:(NSCoder*)encoder {
	[super encodeWithCoder:encoder];
	if (self.text) {
		[encoder encodeObject:self.text forKey:@"text"];
	}
	if (self.date) {
		[encoder encodeObject:self.date forKey:@"date"];
	}
	if (self.profitIt) {
		[encoder encodeObject:self.profitIt forKey:@"profitIt"];
	}
	if (self.count) {
		[encoder encodeObject:self.count forKey:@"count"];		 
	}
	if (self.rating) {
		[encoder encodeObject:self.rating forKey:@"rating"];
	}
}




@end
