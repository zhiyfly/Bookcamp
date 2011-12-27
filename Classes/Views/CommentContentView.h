//
//  CommentContentView.h
//  bookcamp
//
//  Created by waiwai on 12/27/10.
//  Copyright 2010 __iwaiwai__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommentContentItem.h"

@interface CommentContentView : TTView {
	CommentContentItem *_item;
	
	UILabel* _descLabel;
	TTStyledTextLabel *_styledContentLabel;
	UIScrollView *_scrollView;
	RatingView *_ratingView;
}
@property (nonatomic, retain) id object;

@property (nonatomic, retain) UILabel *descLabel;
@property (nonatomic, retain) TTStyledTextLabel *styledContentLabel;
@property (nonatomic, retain , readonly) UIScrollView *scrollView;
@property (nonatomic, retain, readonly) RatingView *ratingView;

@end
