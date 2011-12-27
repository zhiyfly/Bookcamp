//
//  HeadlineView.m
//  chinasource
//
//  Created by waiwai on 12/26/10.
//  Copyright 2010 __iwaiwai__. All rights reserved.
//

#import "HeadlineView.h"

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


static const NSInteger  titleLabelLineCount   = 2;
static const NSInteger summaryLabelLineCount = 0;
static const int HeadlineThumbWidth   = 40;
static const int  HeadlineThumbHeight  = 40;


@implementation HeadlineView
@synthesize titleLabel = _titleLabel, summaryLabel = _summaryLabel, thumbnail = _thumbnail; 



///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)dealloc {
	TT_RELEASE_SAFELY(_item);
	TT_RELEASE_SAFELY(_titleLabel);
	TT_RELEASE_SAFELY(_summaryLabel);
	TT_RELEASE_SAFELY(_thumbnail);
    [super dealloc];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        // Initialization code
		self.titleLabel.font = TTSTYLEVAR(font);
		self.titleLabel.textColor = TTSTYLEVAR(tableSubTextColor);
		self.titleLabel.highlightedTextColor = TTSTYLEVAR(highlightedTextColor);
		self.titleLabel.textAlignment = UITextAlignmentLeft;
		self.titleLabel.contentMode = UIViewContentModeTop;
		self.titleLabel.lineBreakMode = UILineBreakModeTailTruncation;
		self.titleLabel.numberOfLines = titleLabelLineCount;
		self.titleLabel.contentMode = UIViewContentModeLeft;
		
		self.summaryLabel.font = TTSTYLEVAR(font);
		self.summaryLabel.textColor = TTSTYLEVAR(tableSubTextColor);
		self.summaryLabel.highlightedTextColor = TTSTYLEVAR(highlightedTextColor);
		self.summaryLabel.textAlignment = UITextAlignmentLeft;
		self.summaryLabel.contentMode = UIViewContentModeTop;
		self.summaryLabel.lineBreakMode = UILineBreakModeTailTruncation;
		self.summaryLabel.numberOfLines = summaryLabelLineCount;
		self.summaryLabel.contentMode = UIViewContentModeLeft;
    }
    return self;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
-(id)object{
	return _item;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setObject:(id)object {	
	if (self.object != object) {
		[_item release];
		_item = [object retain];
		HeadlineItem* item = object;
		if (item.title.length) {
			self.titleLabel.text = item.title;
		}
		if (item.summary.length) {
			self.summaryLabel.text = item.summary;
		}
		if (item.thumbnailURL) {
			self.thumbnail.urlPath = item.thumbnailURL;
		}
		
	}
}


///////////////////////////////////////////////////////////////////////////////////////////////////
-(UILabel*) titleLabel{
	if (!_titleLabel) {
		_titleLabel = [[UILabel alloc] init];
		[self addSubview:_titleLabel];
	}
	return _titleLabel;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
-(UILabel*) summaryLabel{
	if (!_summaryLabel) {
		_summaryLabel = [[UILabel alloc] init];
		[self addSubview:_summaryLabel];
	}
	return _summaryLabel;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
-(TTImageView*) thumbnail{
	if (!_thumbnail) {
		_thumbnail = [[TTImageView alloc] init];
		[self addSubview:_thumbnail];
	}
	return _thumbnail;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
-(void)layoutSubviews{
	[super layoutSubviews];
	
	CGFloat left = 0;
	if (_thumbnail) {
		_thumbnail.frame = CGRectMake(BCContentSmallMargin, BCContentSmallMargin,
									  HeadlineThumbWidth, HeadlineThumbHeight);
		left += BCContentSmallMargin + HeadlineThumbWidth + BCContentSmallMargin;
	} else {
		left = BCContentSmallMargin;
	}
	
	CGFloat width = self.width - left;
	CGFloat top = BCContentSmallMargin;
	
	
	if (_titleLabel.text.length) {
		_titleLabel.frame = CGRectMake(left, top, width-BCContentSmallMargin, _titleLabel.font.ttLineHeight);
		top += _titleLabel.height;
	} else {
		_titleLabel.frame = CGRectZero;
	}
	
	//Todo:if the summary 's height exceed the thumb , to wrap the string
	if (_summaryLabel.text.length) {
		CGSize summarySize = [[self.object summary] sizeWithFont:TTSTYLEVAR(font) constrainedToSize:CGSizeMake(width-BCContentSmallMargin, NSIntegerMax) lineBreakMode:UILineBreakModeTailTruncation];
		_summaryLabel.frame = CGRectMake(left, top, summarySize.width, summarySize.height);
		top += _summaryLabel.height;
	} else {
		_summaryLabel.frame = CGRectZero;
	}

	
}



@end
