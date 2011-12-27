//
//  BookCellItemCell.m
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

#import "BookCellItemCell.h"

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

static const NSInteger  kMessageTextLineCount       = 2;
static const CGFloat    kDefaultMessageImageWidth   = 60;
static const CGFloat    kDefaultMessageImageHeight  = 80;

@implementation BookCellItemCell


///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString*)identifier {
	if (self = [super initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:identifier]) {
		self.titleLabel.font =TTSTYLEVAR(titleFont);
		self.titleLabel.textColor = TTSTYLEVAR(textColor);
		self.titleLabel.highlightedTextColor = TTSTYLEVAR(highlightedTextColor);
		self.titleLabel.textAlignment = UITextAlignmentLeft;
		self.titleLabel.lineBreakMode = UILineBreakModeTailTruncation;
		self.titleLabel.adjustsFontSizeToFitWidth = YES;
		self.titleLabel.contentMode = UIViewContentModeLeft;
		
		self.captionLabel.font = TTSTYLEVAR(summaryFont);
		self.captionLabel.textColor = TTSTYLEVAR(captionColor);
		self.captionLabel.highlightedTextColor = TTSTYLEVAR(highlightedTextColor);
		self.captionLabel.textAlignment = UITextAlignmentLeft;
		self.captionLabel.lineBreakMode = UILineBreakModeTailTruncation;
		//self.captionLabel.adjustsFontSizeToFitWidth = YES;
		self.captionLabel.numberOfLines = 3;
		self.captionLabel.contentMode = UIViewContentModeLeft;
		
		self.averageRateLabel.font = TTSTYLEVAR(font);
		self.averageRateLabel.textColor = TTSTYLEVAR(tableSubTextColor);
		self.averageRateLabel.highlightedTextColor = TTSTYLEVAR(highlightedTextColor);
		self.averageRateLabel.textAlignment = UITextAlignmentLeft;
		self.averageRateLabel.contentMode = UIViewContentModeTop;
		self.averageRateLabel.lineBreakMode = UILineBreakModeTailTruncation;
		self.averageRateLabel.numberOfLines = kMessageTextLineCount;
		self.averageRateLabel.contentMode = UIViewContentModeLeft;
	}
	
	return self;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)dealloc {
	TT_RELEASE_SAFELY(_titleLabel);
	TT_RELEASE_SAFELY(_averageRateLabel);
	TT_RELEASE_SAFELY(_imageView2);
	
	[super dealloc];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark TTTableViewCell class public


///////////////////////////////////////////////////////////////////////////////////////////////////
+ (CGFloat)tableView:(UITableView*)tableView rowHeightForObject:(id)object {
	// XXXjoe Compute height based on font sizes
	return 90.f;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark UIView


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)prepareForReuse {
	[super prepareForReuse];
	[_imageView2 unsetImage];
	_titleLabel.text = nil;
	self.textLabel.text = nil;
	_averageRateLabel.text = nil;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)layoutSubviews {
	[super layoutSubviews];
	
	CGFloat left = BKContentMargin;
	if (_imageView2) {
		_imageView2.frame = CGRectMake(left, kTableCellSmallMargin,
									   kDefaultMessageImageWidth, kDefaultMessageImageHeight);
		left += BKContentMargin + kDefaultMessageImageWidth + kTableCellSmallMargin;
	} else {
		left = kTableCellMargin;
	}
	
	CGFloat width = self.contentView.width - left;
	CGFloat top = kTableCellSmallMargin;
	
	if (_titleLabel.text.length) {
		_titleLabel.frame = CGRectMake(left, top, width, self.titleLabel.font.ttLineHeight);
		top += _titleLabel.height;
	} else {
		_titleLabel.frame = CGRectZero;
	}
	
	if (self.captionLabel.text.length) {
		self.captionLabel.frame = CGRectMake(left, top, width, self.captionLabel.font.ttLineHeight*2);
		top += self.captionLabel.height;
	} else {
		self.captionLabel.frame = CGRectZero;
	}
	
	if ((int)[_ratingView rating] != RatingHidden) {
		[self.ratingView setFrame:CGRectMake( left, top, RatingViewWidth, RatingViewHeight)];
		left += RatingViewWidth + kTableCellSmallMargin;
	}else {
		[self.ratingView setFrame:CGRectZero];
	}

	if (_averageRateLabel.text.length) {
		//here crash but after nslog is added ,the crash gone.
		BCNSLog(@"need to fix this crash");
		_averageRateLabel.frame = CGRectMake(left, top, self.width - CGRectGetMaxX([_ratingView frame]) ,self.averageRateLabel.font.ttLineHeight);
		
	}else {
		_averageRateLabel.frame = CGRectZero;
	}

	
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)didMoveToSuperview {
	[super didMoveToSuperview];
	
	if (self.superview) {
		_imageView2.backgroundColor = self.backgroundColor;
		_titleLabel.backgroundColor = self.backgroundColor;
		self.textLabel.backgroundColor = self.backgroundColor;
		_averageRateLabel.backgroundColor = self.backgroundColor;
	}
}

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark TTTableViewCell


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setObject:(id)object {
	if (_item != object) {
		[super setObject:object];
		
		BookCellItem* item = object;
		if (item.title.length) {
			self.titleLabel.text = item.title;
		}
		if (item.caption.length) {
			self.captionLabel.text = item.caption;
		}
		if (item.imageURL) {
			self.imageView2.urlPath = item.imageURL;
		}
		if (item.rating) {
			[self.ratingView setRating: item.rating];
			self.averageRateLabel.text = [NSString stringWithFormat:@"%@",item.rating]; 
		}
	}
}


///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Public


///////////////////////////////////////////////////////////////////////////////////////////////////
- (UILabel*)titleLabel {
	if (!_titleLabel) {
		_titleLabel = [[UILabel alloc] init];
		[self.contentView addSubview:_titleLabel];
	}
	return _titleLabel;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (UILabel*)averageRateLabel {
	if (!_averageRateLabel) {
		_averageRateLabel = [[UILabel alloc] init];
		[self.contentView addSubview:_averageRateLabel];
	}
	return _averageRateLabel;
}



///////////////////////////////////////////////////////////////////////////////////////////////////
- (UILabel*)captionLabel {
	return self.textLabel;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (RatingView*)ratingView {
	if (!_ratingView) {
		_ratingView = [[RatingView alloc] init];
		[self.contentView addSubview:_ratingView];
	}
	return _ratingView;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (TTImageView*)imageView2 {
	if (!_imageView2) {
		_imageView2 = [[TTImageView alloc] init];
		//    _imageView2.defaultImage = TTSTYLEVAR(personImageSmall);
		//    _imageView2.style = TTSTYLE(threadActorIcon);
		[self.contentView addSubview:_imageView2];
	}
	return _imageView2;
}




@end
