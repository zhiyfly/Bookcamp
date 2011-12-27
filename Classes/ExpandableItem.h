//
//  ExpandableCellItem.h
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

#import <Foundation/Foundation.h>
// UI
#import "Three20UI/TTTableItem.h"

@interface ExpandableItem : TTTableTextItem {
	BOOL _expandable;
	BOOL _selected;
	NSString *_keyText;
	NSString *_valueText;
	NSString *_descText;
	TTStyledText *_descStyledText;
	
	CGFloat	_expandHeight;
	CGFloat	_collapseHeight;
	
}
@property (nonatomic, assign) BOOL  selected;
@property (nonatomic, assign ,readonly) BOOL expandable;
@property (nonatomic, copy) NSString *keyText;
@property (nonatomic, copy) NSString *valueText;
@property (nonatomic, copy) NSString *descText;
@property (nonatomic, retain, readonly) TTStyledText *descStyledText;
@property (nonatomic, assign) CGFloat expandHeight;
@property (nonatomic, assign) CGFloat collapseHeight;

+ (id)itemWithKey:(NSString*)keyText value:(NSString*)valueText descText:(NSString*)descText ;



@end
