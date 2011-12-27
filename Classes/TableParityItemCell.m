//
//  TableParityItemCell.m
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

#import "TableParityItemCell.h"

// UI
#import "Three20UI/TTImageView.h"
#import "Three20UI/TTTableMessageItem.h"
#import "Three20UI/UIViewAdditions.h"
#import "Three20Style/UIFontAdditions.h"

// Style
#import "Three20Style/TTGlobalStyle.h"
#import "Three20Style/TTDefaultStyleSheet.h"

// Core
#import "Three20Core/TTCorePreprocessorMacros.h"
#import "Three20Core/NSDateAdditions.h"


@implementation TableParityItemCell

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)dealloc {
	TT_RELEASE_SAFELY(_item);
	
	TT_RELEASE_SAFELY(_priceLabel);
	TT_RELEASE_SAFELY(_saveonLabel);
	
	[super dealloc];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString*)identifier {
	if (self = [super initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:identifier]) {
		self.priceLabel.font = TTSTYLEVAR(font);
		self.priceLabel.textColor = TTSTYLEVAR(textColor);
		self.priceLabel.highlightedTextColor = TTSTYLEVAR(highlightedTextColor);
		self.priceLabel.textAlignment = UITextAlignmentLeft;
		self.priceLabel.lineBreakMode = UILineBreakModeTailTruncation;
		self.priceLabel.adjustsFontSizeToFitWidth = YES;
		self.priceLabel.contentMode = UIViewContentModeLeft;
		
		self.saveonLabel.font = TTSTYLEVAR(font);
		self.saveonLabel.textColor = TTSTYLEVAR(tableSubTextColor);
		self.saveonLabel.highlightedTextColor = TTSTYLEVAR(highlightedTextColor);
		self.saveonLabel.textAlignment = UITextAlignmentRight;
		self.saveonLabel.lineBreakMode = UILineBreakModeTailTruncation;
		self.saveonLabel.adjustsFontSizeToFitWidth = YES;
		self.saveonLabel.contentMode = UIViewContentModeRight;
	}
	
	return self;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark UIView


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)prepareForReuse {
	[super prepareForReuse];
	_priceLabel.text = nil;
	_saveonLabel.text = nil;
}

- (void)layoutSubviews {
	[super layoutSubviews];

	//[self.object text].height;
	_label.frame = CGRectMake(kTableCellMargin, kTableCellVPadding, 
							  ShopNameLabelWidth , [(TTStyledText*)[self.object text] height]);
	_priceLabel.frame = CGRectMake( self.contentView.width - (PriceLabelWidth + kTableCellHPadding), 
								   kTableCellVPadding, 
								   PriceLabelWidth, 
								   _priceLabel.font.ttLineHeight);
	_saveonLabel.frame = CGRectMake(self.width - SaveonLabelWidth - BKContentMargin, 
									kTableCellVPadding, 
									SaveonLabelWidth, 
									_saveonLabel.font.ttLineHeight);
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)didMoveToSuperview {
	[super didMoveToSuperview];
	
	if (self.superview) {
		_priceLabel.backgroundColor = self.backgroundColor;
		_saveonLabel.backgroundColor = self.backgroundColor;
	}
}

///////////////////////////////////////////////////////////////////////////////////////////////////
+ (CGFloat)tableView:(UITableView*)tableView rowHeightForObject:(id)object {
	// XXXjoe Compute height based on font sizes
	TableParityItem *item = object;
	item.text.width = ShopNameLabelWidth; 
	item.text.font = TTSTYLEVAR(font);
	return item.text.height + kTableCellVPadding*2;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (UILabel*)priceLabel {
	if (!_priceLabel) {
		_priceLabel = [[UILabel alloc] init];
		_priceLabel.textColor = [UIColor blackColor];
		_priceLabel.highlightedTextColor = [UIColor whiteColor];
		_priceLabel.font = TTSTYLEVAR(tableFont);
		_priceLabel.contentMode = UIViewContentModeLeft;
		[self.contentView addSubview:_priceLabel];
	}
	return _priceLabel;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (UILabel*)saveonLabel {
	if (!_saveonLabel) {
		_saveonLabel = [[UILabel alloc] init];
		_saveonLabel.textColor = [UIColor blackColor];
		_saveonLabel.highlightedTextColor = [UIColor whiteColor];
		_saveonLabel.font = TTSTYLEVAR(tableFont);
		_saveonLabel.contentMode = UIViewContentModeLeft;
		[self.contentView addSubview:_saveonLabel];
	}
	return _saveonLabel;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)object {
	return _item;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setObject:(id)object {
	if (self.object != object) {
		[_item release];
		_item = [object retain];
		
		TableParityItem* item = object;
		if (item.text) {
			item.text.width = ShopNameLabelWidth;
			self.label.text = item.text;
		}
		if (item.price) {
			self.priceLabel.text = [NSString stringWithFormat:@"¥%@",item.price];
		}
		if (item.saveon) {
			self.saveonLabel.text = [NSString stringWithFormat:@"¥%@",item.saveon];
		}
	}
}



@end
