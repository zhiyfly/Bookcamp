//
//  BookCommentTableCell.h
//  bookcamp
//
//  Created by waiwai on 12/19/10.
//  Copyright 2010 __iwaiwai__. All rights reserved.
//
// UI
#import "Three20UI/TTTableLinkedItemCell.h"
#import "TableCommentItem.h"

@class TTImageView;
@class RatingView;

@interface TableCommentItemCell : TTTableLinkedItemCell {
	UILabel*		_titleLabel;
	UILabel*		_timestampLabel;
	TTImageView*	_imageView2;
	RatingView*		_ratingView;
}

@property (nonatomic, readonly, retain) UILabel*      titleLabel;
@property (nonatomic, readonly, retain)         UILabel*      captionLabel;
@property (nonatomic, readonly, retain) UILabel*      timestampLabel;
@property (nonatomic, readonly, retain) TTImageView*  imageView2;
@property (nonatomic, readonly, retain) RatingView*		ratingView;

@end

