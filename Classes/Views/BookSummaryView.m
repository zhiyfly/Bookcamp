//
//  BookInfoView.m
//  bookcamp
//
//  Created by lin waiwai on 7/17/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "BookSummaryView.h"
#import "CSFlowLayout.h"
#import "Three20UI/UIViewAdditions.h"


CGFloat BookSummaryViewMargin  =25;

@implementation BookSummaryView

@synthesize titleLabel = _titleLabel;;
@synthesize authorLabel = _authorLabel;
@synthesize timelineLabel = _timelineLabel;
@synthesize ratingView = _ratingView;
@synthesize averageRateLabel = _averageRateLabel;


-(id)initWithFrame:(CGRect)frame{
	if (self = [super initWithFrame:frame]) {
		CSFlowLayout* flowLayout = [[[CSFlowLayout alloc] init] autorelease];
		flowLayout.HSpace = 5;
		flowLayout.VSpace = 5;
		flowLayout.padding = UIEdgeInsetsMake(BookSummaryViewMargin+5, BookSummaryViewMargin , 0, 0);
		self.layout = flowLayout;
	}
	return self;
}

-(id)object{
	return _item;
}

//	for (BookObject*book in books) {	
//		NSString *caption = [book.authors objectAtIndex:0];
//		if ([book.authors count] > 1) {
//			caption = [caption stringByAppendingString:BCLocalizedString(@"etc", @"etc")];
//		}
//		NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
//		[dateFormatter setDateFormat:@"yyyy-MM"];
//		[dateFormatter setLocale:[NSLocale currentLocale]];
//		NSString* dateStr = [dateFormatter stringFromDate:book.pubdate];
//		
//		caption = [NSString stringWithFormat:@"%@/%@/%@", caption, book.publisher, dateStr];
//		[bookItems addObject:[BookCellItem itemWithTitle:book.bookName caption:caption
//												  rating:book.averageRate imageURL:book.thumbURL  
//													 URL:[@"tt://book/" stringByAppendingString:[book.oid stringValue]]]];
//	}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setObject:(id)object {
	if (_item != object) {
		BookObject* item = object;
		if (item.bookName.length) {
			self.titleLabel.text = item.bookName;
			[self.titleLabel sizeToFit];
			self.titleLabel.frame = CGRectMake(0, 0, self.width - 2 * BookSummaryViewMargin, self.titleLabel.height);
		}
		
		if ([item.authors count] > 0) {
			NSString *caption = [item.authors objectAtIndex:0];
			if ([item.authors count] > 1) {
				caption = [caption stringByAppendingString:BCLocalizedString(@"etc", @"etc")];
			}
			if(caption.length){
				self.authorLabel.text = caption;
				[self.authorLabel sizeToFit];
				self.authorLabel.frame = CGRectMake(0, 0, self.width - 2 * BookSummaryViewMargin, self.authorLabel.height);
			}

		
		} else {
			self.authorLabel.text = nil;
			[self.authorLabel sizeToFit];
			self.authorLabel.frame = CGRectMake(0, 0, self.width - 2 * BookSummaryViewMargin, self.authorLabel.height);
		}

		
		NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
		[dateFormatter setDateFormat:@"yyyy-MM"];
		[dateFormatter setLocale:[NSLocale currentLocale]];
		NSString* dateStr = [dateFormatter stringFromDate:item.pubdate];
		
		if (dateStr.length) {
			self.timelineLabel.text = dateStr;
			self.timelineLabel.font = [UIFont systemFontOfSize:14];
			[self.timelineLabel sizeToFit];
			self.timelineLabel.frame = CGRectMake(0, 0, self.width - 2 * BookSummaryViewMargin, self.timelineLabel.height);
		}
		
		if (item.averageRate) {
			[self.ratingView setRating: item.averageRate];
			self.averageRateLabel.text = [NSString stringWithFormat:BCLocalizedString(@"rating format", @"rating format"),item.averageRate]; 
			[self.averageRateLabel sizeToFit];
			self.averageRateLabel.frame = CGRectMake(0, 0, self.averageRateLabel.width
													 , self.averageRateLabel.height);
		}
		[self setNeedsLayout];
		[self layoutIfNeeded];
	}
}


///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Public


///////////////////////////////////////////////////////////////////////////////////////////////////
- (TTLabel*)titleLabel {
	if (!_titleLabel) {
		_titleLabel = [[TTLabel alloc] initWithFrame:CGRectMake(0, 0, self.width - 2 * BookSummaryViewMargin, 0)];
		_titleLabel.style = TTSTYLE(bookSummaryTitleStyle);
		_titleLabel.backgroundColor = [UIColor clearColor];
		[self addSubview:_titleLabel];
	}
	return _titleLabel;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (TTLabel*)authorLabel {
	if (!_authorLabel) {
		self.titleLabel;
		_authorLabel = [[TTLabel alloc] initWithFrame:CGRectMake(0, 0, self.width - 2 * BookSummaryViewMargin, 0)];
		_authorLabel.style = TTSTYLE(bookSummaryAuthorStyle);
		_authorLabel.backgroundColor = [UIColor clearColor];
		[self addSubview:_authorLabel];
	}
	return _authorLabel;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (TTLabel*)timelineLabel {
	if (!_timelineLabel) {
		self.authorLabel;
		_timelineLabel = [[TTLabel alloc] initWithFrame:CGRectMake(0, 0, self.width - 2 * BookSummaryViewMargin, 0)];
		_timelineLabel.style = TTSTYLE(bookSummaryTimelineStyle);
		_timelineLabel.backgroundColor = [UIColor clearColor];
		[self addSubview:_timelineLabel];
	}
	return _timelineLabel;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (RatingView*)ratingView {
	if (!_ratingView) {
		self.timelineLabel;
		_ratingView = [[RatingView alloc] initWithFrame:CGRectMake(0, 0, 105, 20)];
		[self addSubview:_ratingView];
	}
	return _ratingView;
}



///////////////////////////////////////////////////////////////////////////////////////////////////
- (TTLabel*)averageRateLabel {
	if (!_averageRateLabel) {
		self.ratingView;
		_averageRateLabel = [[TTLabel alloc] init];
		_averageRateLabel.backgroundColor = [UIColor clearColor];
		_averageRateLabel.style = TTSTYLE(bookSummaryRateStyle);
		[self addSubview:_averageRateLabel];
	}
	return _averageRateLabel;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)layoutSubviews {
	[super layoutSubviews];
}





@end
