//
//  CommentAuthorInfoView.h
//  bookcamp
//
//  Created by waiwai on 12/26/10.
//  Copyright 2010 __iwaiwai__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommentAuthorInfoItem.h"

@interface CommentAuthorInfoView : TTView {
	CommentAuthorInfoItem *_item;
	
	TTThumbView *_avatar;

	UILabel *_signatureLabel;
	UILabel *_nameLabel;
	
}

@property (nonatomic, retain) id object;

@property (nonatomic, retain)			TTThumbView *avatar;

@property (nonatomic, retain, readonly) UILabel *signatureLabel;
@property (nonatomic, retain, readonly) UILabel *nameLabel;


@end
