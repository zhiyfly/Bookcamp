//
//  HeadlineItem.h
//  chinasource
//
//  Created by lin waiwai on 1/13/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeadlineItem.h"

@interface HeadlineView : UIView {
	HeadlineItem *_item;
	
	TTImageView *_thumbnail;
	UILabel *_summaryLabel;
	UILabel *_titleLabel;
}

@property (nonatomic, retain) id object;

@property (nonatomic, retain, readonly)	TTImageView *thumbnail;
@property (nonatomic, retain, readonly) UILabel *summaryLabel;
@property (nonatomic, retain, readonly) UILabel *titleLabel;


@end




