//
//  BookCommentTableCell.m
//  bookcamp
//
//  Created by waiwai on 12/19/10.
//  Copyright 2010 __iwaiwai__. All rights reserved.
//

#import "TableCommentItemCell.h"

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

static const NSInteger  kMessageTextLineCount       = 3;
static const CGFloat    kDefaultMessageImageWidth   = 34;
static const CGFloat    kDefaultMessageImageHeight  = 34;

@implementation TableCommentItemCell
///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString*)identifier {
	if (self = [super initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:identifier]) {
		self.backgroundColor = [UIColor clearColor];
		self.textLabel.font = [UIFont systemFontOfSize:16];
		self.textLabel.textColor = RGBCOLOR(62,62,62);
		self.textLabel.highlightedTextColor = TTSTYLEVAR(highlightedTextColor);
		self.textLabel.textAlignment = UITextAlignmentLeft;
		self.textLabel.lineBreakMode = UILineBreakModeTailTruncation;
		self.textLabel.adjustsFontSizeToFitWidth = YES;
		self.textLabel.contentMode = UIViewContentModeLeft;
		
		self.detailTextLabel.font = [UIFont systemFontOfSize:13];
		self.detailTextLabel.textColor = TTSTYLEVAR(tableSubTextColor);
		self.detailTextLabel.highlightedTextColor = TTSTYLEVAR(highlightedTextColor);
		self.detailTextLabel.textAlignment = UITextAlignmentLeft;
		self.detailTextLabel.contentMode = UIViewContentModeTop;
		self.detailTextLabel.lineBreakMode = UILineBreakModeTailTruncation;
		self.detailTextLabel.numberOfLines = kMessageTextLineCount;
		self.detailTextLabel.contentMode = UIViewContentModeLeft;

	}
	
	return self;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)dealloc {
	TT_RELEASE_SAFELY(_titleLabel);
	TT_RELEASE_SAFELY(_timestampLabel);
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

-(void)willBeDisplayed:(UITableView *)tableView{

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
	_timestampLabel.text = nil;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)layoutSubviews {
	[super layoutSubviews];
	
	CGFloat left = 0;
	if (_imageView2) {
		_imageView2.frame = CGRectMake(kTableCellSmallMargin, kTableCellSmallMargin,
									   kDefaultMessageImageWidth, kDefaultMessageImageHeight);
		left += kTableCellSmallMargin + kDefaultMessageImageHeight + kTableCellSmallMargin;
	} else {
		left = kTableCellMargin;
	}
	
	CGFloat width = self.contentView.width - left;
	CGFloat top = kTableCellSmallMargin;
	
	[self.ratingView setFrame:CGRectMake( self.contentView.width - RatingViewWidth - kTableCellSmallMargin, top, RatingViewWidth, RatingViewHeight)];
	
	if (_titleLabel.text.length) {
		_titleLabel.frame = CGRectMake(left, top, width - CGRectGetWidth([self.ratingView frame])-kTableCellSmallMargin, _titleLabel.font.ttLineHeight);
		top += _titleLabel.height;
	} else {
		_titleLabel.frame = CGRectZero;
	}
	
	if (self.captionLabel.text.length) {
		self.captionLabel.frame = CGRectMake(left, top, width, self.captionLabel.font.ttLineHeight);
		top += self.captionLabel.height;
	} else {
		self.captionLabel.frame = CGRectZero;
	}
	
	if (self.detailTextLabel.text.length) {
		CGFloat textHeight = self.detailTextLabel.font.ttLineHeight * kMessageTextLineCount;
		self.detailTextLabel.frame = CGRectMake(left, top, width, textHeight);
	} else {
		self.detailTextLabel.frame = CGRectZero;
	}
	
	if (_timestampLabel.text.length) {
		_timestampLabel.alpha = !self.showingDeleteConfirmation;
		[_timestampLabel sizeToFit];
		_timestampLabel.left = self.contentView.width - (_timestampLabel.width + kTableCellSmallMargin);
		_timestampLabel.top = _titleLabel.top;
		_titleLabel.width -= _timestampLabel.width + kTableCellSmallMargin*2;
	} else {
		//_titleLabel.frame = CGRectZero;
	}
	
//	if ([_ratingView rating]) {
		
//	}else {
//		[_ratingView setFrame:CGRectZero];
//	}

}



///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)didMoveToSuperview {
	[super didMoveToSuperview];

	if (self.superview) {
		_imageView2.backgroundColor = self.backgroundColor;
		_titleLabel.backgroundColor = self.backgroundColor;
		_timestampLabel.backgroundColor = self.backgroundColor;
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
		
		TableCommentItem* item = object;
		if (item.title.length) {
			self.titleLabel.text = item.title;
		}
		if (item.caption.length) {
			self.captionLabel.text = item.caption;
		}
		if (item.text.length) {
			self.detailTextLabel.text = item.text;
		}
		if (item.timestamp) {
			self.timestampLabel.text = [item.timestamp formatShortTime];
		}
		if (item.imageURL) {
			self.imageView2.urlPath = item.imageURL;
		}
		if (item.rating) {
			[self.ratingView setRating: item.rating];
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
		_titleLabel.textColor = [UIColor blackColor];
		_titleLabel.highlightedTextColor = [UIColor whiteColor];
		_titleLabel.font = TTSTYLEVAR(tableFont);
		_titleLabel.contentMode = UIViewContentModeLeft;
		[self.contentView addSubview:_titleLabel];
	}
	return _titleLabel;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (RatingView*)ratingView {
	if (!_ratingView) {
		_ratingView = [[RatingView alloc] initWithFrame:CGRectMake(0, 0, 105, 20)];
		[self.contentView addSubview:_ratingView];
	}
	return _ratingView;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (UILabel*)captionLabel {
	return self.textLabel;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (UILabel*)timestampLabel {
	if (!_timestampLabel) {
		_timestampLabel = [[UILabel alloc] init];
		_timestampLabel.font = TTSTYLEVAR(tableTimestampFont);
		_timestampLabel.textColor = TTSTYLEVAR(timestampTextColor);
		_timestampLabel.highlightedTextColor = [UIColor whiteColor];
		_timestampLabel.contentMode = UIViewContentModeLeft;
		[self.contentView addSubview:_timestampLabel];
	}
	return _timestampLabel;
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
