//
//  PeriodicalInfoItem.m
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

#import "HeadlineItem.h"

// Core
#import "Three20Core/TTCorePreprocessorMacros.h"

@implementation HeadlineItem

@synthesize thumbnailURL = _thumbnailURL;
@synthesize summary = _summary;
@synthesize title = _title;


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)dealloc {
	TT_RELEASE_SAFELY(_thumbnailURL);
	TT_RELEASE_SAFELY(_summary);
	TT_RELEASE_SAFELY(_title);
	[super dealloc];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
+ (id)itemWithTitle:(NSString*)title summary:(NSString*)summary thumbnailURL:(NSString*)thumbnailURL  {
	HeadlineItem* item = [[[self alloc] init] autorelease];
	item.title = title;
	item.summary = summary;
	item.thumbnailURL = thumbnailURL;
	return item;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark NSCoding

///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithCoder:(NSCoder*)decoder {
	if (self = [super initWithCoder:decoder]) {
		self.thumbnailURL = [decoder decodeObjectForKey:@"thumbnailURL"];
		self.title = [decoder decodeObjectForKey:@"title"];
		self.summary = [decoder decodeObjectForKey:@"summary"];
		
	}
	return self;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)encodeWithCoder:(NSCoder*)encoder {
	[super encodeWithCoder:encoder];
	if (self.thumbnailURL) {
		[encoder encodeObject:self.thumbnailURL forKey:@"thumbnailURL"];
	}
	if (self.title) {
		[encoder encodeObject:self.title forKey:@"title"];
	}
	if (self.summary) {
		[encoder encodeObject:self.summary forKey:@"summary"];
	}
	
}

@end
