//
//  BookCellItem.m
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

#import "BookCellItem.h"
// Core
#import "Three20Core/TTCorePreprocessorMacros.h"

@implementation BookCellItem

@synthesize title = _title;
@synthesize caption = _caption;
@synthesize rating = _rating;
@synthesize imageURL = _imageURL;

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)dealloc {
	TT_RELEASE_SAFELY(_title);
	TT_RELEASE_SAFELY(_caption);
	TT_RELEASE_SAFELY(_imageURL);
	TT_RELEASE_SAFELY(_rating);
	[super dealloc];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Class public

///////////////////////////////////////////////////////////////////////////////////////////////////
+ (id)itemWithTitle:(NSString *)title caption:(NSString *)caption rating:(NSNumber*)rating imageURL:(NSString*)imageURL  URL:(NSString *)URL{
	BookCellItem* item = [[[self alloc] init] autorelease];
	item.title = title;
	item.caption = caption;
	item.imageURL = imageURL;
	item.rating = rating;
	item.URL = URL;
	return item;
}



///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark NSCoding


///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithCoder:(NSCoder*)decoder {
	if (self = [super initWithCoder:decoder]) {
		self.title = [decoder decodeObjectForKey:@"title"];
		self.caption = [decoder decodeObjectForKey:@"caption"];
		self.imageURL = [decoder decodeObjectForKey:@"imageURL"];
		self.rating = [decoder decodeObjectForKey:@"rating"];
	}
	return self;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)encodeWithCoder:(NSCoder*)encoder {
	[super encodeWithCoder:encoder];
	if (self.title) {
		[encoder encodeObject:self.title forKey:@"title"];
	}
	if (self.caption) {
		[encoder encodeObject:self.caption forKey:@"caption"];
	}
	if (self.imageURL) {
		[encoder encodeObject:self.imageURL forKey:@"imageURL"];
	}
	if (self.rating) {
		[encoder encodeObject:self.rating forKey:@"rating"];		 
	}
}

@end

