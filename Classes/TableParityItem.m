//
//  TableParityItem.m
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

#import "TableParityItem.h"


@implementation TableParityItem
@synthesize price = _price, saveon=_saveon;



///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)dealloc {
	TT_RELEASE_SAFELY(_price);
	TT_RELEASE_SAFELY(_saveon);
	//TT_RELEASE_SAFELY(_styledText);
	[super dealloc];
}



///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Class public


///////////////////////////////////////////////////////////////////////////////////////////////////
+ (id)itemWithText:(NSString*)text price:(NSNumber*)price saveon:(NSNumber*)saveon {
	TableParityItem* item = [[[self alloc] init] autorelease];
	item.text = [TTStyledText textFromXHTML:text lineBreaks:YES URLs:YES];
	item.price = price;
	item.saveon = saveon;
	return item;
}



//-(TTStyledText*)styledText{
//	if (!_styledText) {
//		_styledText = [[TTStyledText textFromXHTML:self.text lineBreaks:YES URLs:YES] retain];
//	}
//	return _styledText;
//}



///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark NSCoding


///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithCoder:(NSCoder*)decoder {
	if (self = [super initWithCoder:decoder]) {
		self.price = [decoder decodeObjectForKey:@"price"];
		self.saveon	= [decoder decodeObjectForKey:@"saveon"];
	}
	return self;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)encodeWithCoder:(NSCoder*)encoder {
	[super encodeWithCoder:encoder];

	if (self.price) {
		[encoder encodeObject:self.price forKey:@"price"];
	}
	if (self.saveon) {
		[encoder encodeObject:self.saveon forKey:@"saveon"];
	}
}

@end




