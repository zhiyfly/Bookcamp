//
//  ExpandableCellItem.m
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

#import "ExpandableItem.h"


@implementation ExpandableItem

@synthesize keyText = _keyText;
@synthesize valueText = _valueText;
@synthesize descText = _descText;
@synthesize selected = _selected;
@synthesize expandHeight = _expandHeight;
@synthesize collapseHeight = _collapseHeight;


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)dealloc {
	TT_RELEASE_SAFELY(_keyText);
	TT_RELEASE_SAFELY(_valueText);
	TT_RELEASE_SAFELY(_descText);
	TT_RELEASE_SAFELY(_descStyledText);
	[super dealloc];
}



///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Class public


///////////////////////////////////////////////////////////////////////////////////////////////////
+ (id)itemWithKey:(NSString*)keyText value:(NSString*)valueText descText:(NSString*)descText {
	ExpandableItem* item = [[[self alloc] init] autorelease];
	item.keyText = keyText;
	item.valueText = valueText;
	item.descText = descText;
	item.selected = NO;
	return item;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
-(TTStyledText*)descStyledText{
	if (!_descStyledText&& self.descText) {
		_descStyledText = [[TTStyledText textFromXHTML:self.descText lineBreaks:YES URLs:YES] retain];
	}
	return _descStyledText;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
-(BOOL)expandable{
	if (self.descText) {
		return YES;
	}
	return NO;
}




///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark NSCoding


///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithCoder:(NSCoder*)decoder {
	if (self = [super initWithCoder:decoder]) {
		self.keyText = [decoder decodeObjectForKey:@"keyText"];
		self.valueText = [decoder decodeObjectForKey:@"valueText"];
		self.descText = [decoder decodeObjectForKey:@"descText"];
	}
	return self;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)encodeWithCoder:(NSCoder*)encoder {
	[super encodeWithCoder:encoder];
	
	if (self.keyText) {
		[encoder encodeObject:self.keyText forKey:@"keyText"];
	}
	if (self.valueText) {
		[encoder encodeObject:self.valueText forKey:@"valueText"];
	}
	if (self.descText) {
		[encoder encodeObject:self.descText forKey:@"descText"];
	}
}


@end
