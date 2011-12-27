//
//  BookCellItemCell.h
//  bookcamp
//
//  Created by lin waiwai on 2/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

// UI
#import "Three20UI/TTTableLinkedItemCell.h"
#import "BookCellItem.h"

@class TTImageView;
@class RatingView;

@interface BookCellItemCell : TTTableLinkedItemCell {
	
	TTImageView*	_imageView2;
	UILabel *_titleLabel;
	UILabel *_averageRateLabel;
	RatingView *_ratingView;
	
}

@property (nonatomic, retain, readonly) TTImageView *imageView2;
@property (nonatomic, retain, readonly) UILabel *titleLabel;
@property (nonatomic, retain, readonly) UILabel *captionLabel;
@property (nonatomic, retain, readonly) UILabel *averageRateLabel;
@property (nonatomic, retain, readonly) RatingView	*ratingView;



@end
