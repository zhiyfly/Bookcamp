//
//  CommentContentView.m
//  bookcamp
//
//  Created by waiwai on 12/27/10.
//  Copyright 2010 __iwaiwai__. All rights reserved.
//

#import "CommentContentView.h"

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

@implementation CommentContentView
@synthesize descLabel = _descLabel;
@synthesize styledContentLabel = _styledContentLabel;
@synthesize scrollView = _scrollView;

static const NSInteger  descLineCount       = 1;
@synthesize ratingView = _ratingView;
///////////////////////////////////////////////////////////////////////////////////////////////////
- (RatingView*)ratingView {
	if (!_ratingView) {
		_ratingView = [[RatingView alloc] initWithFrame:CGRectMake(0, 0, 105, 20)];
		[self.scrollView addSubview:_ratingView];
	}
	return _ratingView;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
-(UIScrollView*)scrollView{
	if (!_scrollView) {
		_scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
		[self addSubview:_scrollView];
	}
	return _scrollView;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
-(UILabel*)descLabel{
	if (!_descLabel) {
		_descLabel = [[UILabel alloc] init];
		[self.scrollView addSubview:_descLabel];
	}
	return _descLabel;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
-(TTStyledTextLabel*)styledContentLabel{
	if (!_styledContentLabel) {
		_styledContentLabel = [[TTStyledTextLabel alloc] init];
		_styledContentLabel.contentMode = UIViewContentModeLeft;
		_styledContentLabel.backgroundColor = [UIColor clearColor];
		[self.scrollView addSubview:_styledContentLabel];
	}
	return _styledContentLabel;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)dealloc {
	TT_RELEASE_SAFELY(_item);
	TT_RELEASE_SAFELY(_descLabel);
	TT_RELEASE_SAFELY(_scrollView);
	TT_RELEASE_SAFELY(_styledContentLabel);
	TT_RELEASE_SAFELY(_ratingView);
    [super dealloc];
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
		CommentContentItem* item = object;
		if (item.date||(item.profitIt&&item.count)) {
			NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
			[dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
			[dateFormatter setLocale:[NSLocale currentLocale]];
			NSString* dateStr = [dateFormatter stringFromDate:item.date];
			
			self.descLabel.text = [NSString stringWithFormat:BKContentDescFormat, dateStr, item.profitIt, item.count];
		}
		if (item.styledContent) {
			
			self.styledContentLabel.text = item.styledContent;
		}
		if (item.rating) {
			[self.ratingView setRating:item.rating ];
		}
	}
}

///////////////////////////////////////////////////////////////////////////////////////////////////
-(void)layoutSubviews{
	[super layoutSubviews];
	
	CGFloat left = BKContentMargin;
	CGFloat top = BKContentSmallMargin;
	
	CGFloat width = self.width-BKContentMargin*2;
	
	if (_descLabel.text.length) {
		_descLabel.frame = CGRectMake(left, top, width, _descLabel.font.ttLineHeight);
		[_descLabel sizeToFit];
		
	} else {
		_descLabel.frame = CGRectZero;
	}
	
	if ((int)[_ratingView rating]!=RatingHidden) {
		[_ratingView setFrame:CGRectMake( left+_descLabel.width+BKContentMargin, top, RatingViewWidth, RatingViewHeight)];

	}else {
		[_ratingView setFrame:CGRectZero];
	}
	
	top += _descLabel.height+BKContentLargeMargin;
	
	if (_styledContentLabel.text) {
		_styledContentLabel.text.width = width;
		_styledContentLabel.frame = CGRectMake(left, top, width, _styledContentLabel.text.height);
		top += _styledContentLabel.height;
	} else {
		_styledContentLabel.frame = CGRectZero;
	}
	

	

	
	[self.scrollView setContentSize:CGSizeMake(width, top)];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        // Initialization code
		self.descLabel.font = [UIFont systemFontOfSize:11];
		self.descLabel.textColor = TTSTYLEVAR(tableSubTextColor);
		self.descLabel.highlightedTextColor = TTSTYLEVAR(highlightedTextColor);
		self.descLabel.textAlignment = UITextAlignmentLeft;
		self.descLabel.contentMode = UIViewContentModeTop;
		self.descLabel.lineBreakMode = UILineBreakModeTailTruncation;
		self.descLabel.numberOfLines = descLineCount;
		self.descLabel.contentMode = UIViewContentModeLeft;
		self.descLabel.backgroundColor = [UIColor clearColor];
		
		self.styledContentLabel.font = TTSTYLEVAR(font);
		
		
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/




@end
