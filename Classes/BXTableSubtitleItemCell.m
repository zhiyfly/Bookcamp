//
//  BXTTTableSubtitleItemCell.m
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

#import "BXTableSubtitleItemCell.h"

// UI
#import "Three20UI/TTImageView.h"
#import "Three20UI/TTTableSubtitleItem.h"
#import "Three20UI/UIViewAdditions.h"
#import "Three20Style/UIFontAdditions.h"

// Style
#import "Three20Style/TTGlobalStyle.h"
#import "Three20Style/TTDefaultStyleSheet.h"

// Core
#import "Three20Core/TTCorePreprocessorMacros.h"


@implementation BXTableSubtitleItemCell

#define imageWidth 40
///////////////////////////////////////////////////////////////////////////////////////////////////
+ (CGFloat)tableView:(UITableView*)tableView rowHeightForObject:(id)object {
	TTTableSubtitleItem* item = object;
	
	CGFloat height = TTSTYLEVAR(tableFont).ttLineHeight + kTableCellVPadding*2;
	if (item.subtitle) {
		height += TTSTYLEVAR(font).ttLineHeight;
	}
	
	return MAX( height , imageWidth+ 2* kTableCellVPadding);
}


-(void)setObject:(id)object{
	if (_item != object) {
		[super setObject:object];
		self.selectionStyle = TTSTYLEVAR(tableSelectionStyle);
	}
}

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark UIView


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)layoutSubviews {
	[super layoutSubviews];
	
	CGFloat height = self.contentView.height;
	CGFloat width = self.contentView.width - (height + kTableCellSmallMargin+kTableCellHPadding);
	CGFloat left = 0;
	
	if (_imageView2) {
		_imageView2.frame = CGRectMake(kTableCellHPadding, kTableCellVPadding, imageWidth, imageWidth);
		left = _imageView2.right + kTableCellSmallMargin;
	} else {
		left = kTableCellHPadding;
	}
	
	if (self.detailTextLabel.text.length) {
		CGFloat textHeight = self.textLabel.font.ttLineHeight;
		CGFloat subtitleHeight = self.detailTextLabel.font.ttLineHeight;
		CGFloat paddingY = floor((height - (textHeight + subtitleHeight))/2);
		
		self.textLabel.frame = CGRectMake(left, paddingY, width, textHeight);
		self.detailTextLabel.frame = CGRectMake(left, self.textLabel.bottom, width, subtitleHeight);
		
	} else {
		self.textLabel.frame = CGRectMake(_imageView2.right + kTableCellSmallMargin, 0, width, height);
		self.detailTextLabel.frame = CGRectZero;
	}
}



@end
