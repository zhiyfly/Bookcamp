//
//  ExpandableCellItemCell.m
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

#import "ExpandableItemCell.h"

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

@implementation ExpandableItemCell
@synthesize keyLabel = _keyLabel;
@synthesize valueLabel = _valueLabel;
@synthesize descStyledLabel = _descStyledLabel;

static const CGFloat    kDefaultKeyLabelWidth  = 150;
static const CGFloat    kDefaultValueLabelWidth  = 140;
static const CGFloat	kDefaultToggleIconWidth = 16;
static const CGFloat	kDefaultToggleIconHeight = 14;
static const CGFloat	kDefaultExpandableCellHeight = 30;

#define ToggleIconStyle BKToggleIconStyle


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)dealloc {
	TT_RELEASE_SAFELY(_keyLabel);
	TT_RELEASE_SAFELY(_valueLabel);
	TT_RELEASE_SAFELY(_descStyledLabel);
	TT_RELEASE_SAFELY(_toggleIcon);
	[super dealloc];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString*)identifier {
	if (self = [super initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:identifier]) {
		self.keyLabel.font = [UIFont systemFontOfSize:16];
		self.keyLabel.textColor = TTSTYLEVAR(textColor);
		self.keyLabel.highlightedTextColor = TTSTYLEVAR(highlightedTextColor);
		self.keyLabel.textAlignment = UITextAlignmentLeft;
		self.keyLabel.lineBreakMode = UILineBreakModeTailTruncation;
		self.keyLabel.contentMode = UIViewContentModeLeft;
		self.keyLabel.numberOfLines = 1;
		
		self.valueLabel.font = TTSTYLEVAR(font);
		self.valueLabel.textColor = TTSTYLEVAR(textColor);
		self.valueLabel.highlightedTextColor = TTSTYLEVAR(highlightedTextColor);
		self.valueLabel.textAlignment = UITextAlignmentLeft;
		self.valueLabel.lineBreakMode = UILineBreakModeTailTruncation;
		//self.valueLabel.adjustsFontSizeToFitWidth = YES;
		self.valueLabel.contentMode = UIViewContentModeLeft;

	}
	
	return self;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setObject:(id)object {
	if (_item != object) {
		[_item release];
		_item = [object retain];
		
		ExpandableItem* item = object;
		if (item.keyText.length) {
			self.keyLabel.text = item.keyText;
		}
		if (item.valueText.length) {
			self.valueLabel.text = item.valueText;
		}
		if (item.descStyledText) {
			item.descStyledText.width = self.contentView.width - kTableCellSmallMargin * 2;
			self.descStyledLabel.text = item.descStyledText;
			_item.collapseHeight = kTableCellSmallMargin*2 + MAX(MAX(_keyLabel.font.ttLineHeight,_valueLabel.font.ttLineHeight),kDefaultToggleIconHeight);
			_item.expandHeight = item.descStyledText.height + kTableCellSmallMargin*2 + _item.collapseHeight;		
		}
		else {
			_item.collapseHeight = _item.expandHeight =  kTableCellSmallMargin*2 + MAX(MAX(_keyLabel.font.ttLineHeight,_valueLabel.font.ttLineHeight),kDefaultToggleIconHeight); 
			
		}

	}
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)prepareForReuse {
	[super prepareForReuse];
	_valueLabel.text = nil;
	_keyLabel.text = nil;
	_descStyledLabel.text = nil;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)didMoveToSuperview {
	[super didMoveToSuperview];
	
	if (self.superview) {
		_valueLabel.backgroundColor = self.backgroundColor;
		_keyLabel.backgroundColor = self.backgroundColor;
		_descStyledLabel.backgroundColor = self.backgroundColor;
	}
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (UILabel*)keyLabel {
	if (!_keyLabel) {
		_keyLabel = [[UILabel alloc] init];
		_keyLabel.textColor = [UIColor blackColor];
		_keyLabel.highlightedTextColor = [UIColor whiteColor];
		_keyLabel.font = TTSTYLEVAR(tableFont);
		_keyLabel.contentMode = UIViewContentModeLeft;
		[self.contentView addSubview:_keyLabel];
	}
	return _keyLabel;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (UILabel*)valueLabel {
	if (!_valueLabel) {
		_valueLabel = [[UILabel alloc] init];
		_valueLabel.textColor = [UIColor blackColor];
		_valueLabel.highlightedTextColor = [UIColor whiteColor];
		_valueLabel.font = TTSTYLEVAR(tableFont);
		_valueLabel.contentMode = UIViewContentModeLeft;
		[self.contentView addSubview:_valueLabel];
	}
	return _valueLabel;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
-(TTButton*)toggleIcon{
	if (!_toggleIcon) {
		_toggleIcon = [[TTButton alloc] init];
		[_toggleIcon setStylesWithSelector:ToggleIconStyle];
		[_toggleIcon setTitle:@"toggle" forState:UIControlStateNormal];
		_toggleIcon.selected = NO;
		[self.contentView addSubview:_toggleIcon];
	}
	return _toggleIcon;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
-(TTStyledTextLabel*)descStyledLabel{
	if (!_descStyledLabel) {
		_descStyledLabel = [[TTStyledTextLabel alloc] init];
		_descStyledLabel.contentMode = UIViewContentModeLeft;
		_descStyledLabel.hidden = YES;
		[self.contentView addSubview:_descStyledLabel];
		
	}
	return _descStyledLabel;
}  


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)layoutSubviews {
	[super layoutSubviews];
	
	CGFloat left = kTableCellSmallMargin;
	
	CGFloat width = self.width - left;
	CGFloat top = kTableCellSmallMargin;
	
	if (_keyLabel.text.length) {
		_keyLabel.frame = CGRectMake(left, top, kDefaultKeyLabelWidth, _keyLabel.font.ttLineHeight);
		left += kDefaultKeyLabelWidth;
	} else {
		_keyLabel.frame = CGRectZero;
	}
	
	if (_valueLabel.text.length) {
		_valueLabel.frame = CGRectMake(left, top, kDefaultValueLabelWidth, _valueLabel.font.ttLineHeight);
		left += kDefaultValueLabelWidth;
	} else {
		_valueLabel.frame = CGRectZero;
	}
	
	if (_descStyledLabel.text) {
		_toggleIcon.frame = CGRectMake(width-kTableCellSmallMargin-kDefaultToggleIconWidth, top, kDefaultToggleIconWidth, kDefaultToggleIconHeight);
		top += kTableCellSmallMargin + MAX(MAX(_keyLabel.font.ttLineHeight,_valueLabel.font.ttLineHeight),kDefaultToggleIconHeight);
		_collapseHeight = top;
		top += kTableCellSmallMargin;
		_descStyledLabel.frame = CGRectMake(kTableCellSmallMargin, top ,_descStyledLabel.text.width ,_descStyledLabel.text.height);
	} else {
		
		_descStyledLabel.frame = CGRectZero;
		_toggleIcon.frame = CGRectZero;
	}
	
}

///////////////////////////////////////////////////////////////////////////////////////////////////
+ (CGFloat)tableView:(UITableView*)tableView rowHeightForObject:(id)object {
	// XXXjoe Compute height based on font sizes
	ExpandableItem *item = object;
	item.descStyledText.width = CGRectGetWidth(tableView.frame)-kTableCellSmallMargin;
	if (item.descStyledText) {		
		item.collapseHeight = kTableCellSmallMargin*2 + MAX(MAX(TTSTYLEVAR(font).ttLineHeight,TTSTYLEVAR(font).ttLineHeight),kDefaultToggleIconHeight);
		item.expandHeight = item.descStyledText.height + kTableCellSmallMargin*2 + item.collapseHeight;		
	}
	else {
		item.collapseHeight = item.expandHeight =  kTableCellSmallMargin*2 + MAX(MAX(TTSTYLEVAR(font).ttLineHeight,TTSTYLEVAR(font).ttLineHeight),kDefaultToggleIconHeight); 
	}
	if (item.expandable) {
		if (item.selected) {
			return item.expandHeight;
		} else {
			return MAX(item.collapseHeight,kDefaultExpandableCellHeight);
		}
	}
	return MAX(item.collapseHeight,kDefaultExpandableCellHeight);
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated{
	[super setHighlighted:highlighted animated:animated];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated{
//	TODO:addAnimation	

//	[UIView beginAnimations:@"DescStyledLabeleExpandAnimation" context:nil];
	if (_item.expandable && _item.selected) {
		_descStyledLabel.hidden = NO;
	}else {
		_descStyledLabel.hidden = YES;
	}
//	[UIView commitAnimations];

}





@end
