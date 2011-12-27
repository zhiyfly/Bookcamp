//
//  BookInfoView.h
//  bookcamp
//
//  Created by lin waiwai on 7/17/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



extern CGFloat BookSummaryViewMargin;
@interface BookSummaryView : TTView {
	BookObject *_item;
	TTLabel *_titleLabel;;
	TTLabel *_authorLabel;
	TTLabel *_timelineLabel;
	RatingView *_ratingView;
	TTLabel *_averageRateLabel;
	
}

@property (nonatomic, retain) id object;
@property (nonatomic, retain) TTLabel *titleLabel;
@property (nonatomic, retain) TTLabel *authorLabel;
@property (nonatomic, retain) TTLabel *timelineLabel;
@property (nonatomic, retain) RatingView *ratingView;
@property (nonatomic, retain) TTLabel *averageRateLabel;


@end
