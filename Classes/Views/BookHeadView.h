//
//  BookHeadView.h
//  bookcamp
//
//  Created by lin waiwai on 12/28/10.
//  Copyright 2010 __iwaiwai__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BookHeadItem.h"


#import "OAuthEngine.h"
#import "WeiboClient.h"
#import "OAuthController.h"
#import "Draft.h"


@interface BookHeadView : TTView <UITextViewDelegate> {
	BookObject *_item;
	
	TTThumbView *_bookThumb;
	TTStyledTextLabel *_info;
	UILabel *_ratingLabel;
	RatingView *_ratingView;
	
	OAuthEngine	*_engine;
	WeiboClient *_weiboClient;
	MBProgressHUD *_HUD;

}

@property (nonatomic, retain, readonly) 	MBProgressHUD *HUD;
@property (nonatomic, retain, readonly) OAuthEngine *engine;
@property (nonatomic, retain, readonly) WeiboClient *weiboClient;

@property (nonatomic, retain) RatingView *ratingView;
@property (nonatomic, retain) BookObject *item;
@property (nonatomic, retain) UILabel *ratingLabel;

@property (nonatomic, retain) TTThumbView *bookThumb;
@property (nonatomic, retain) TTStyledTextLabel *info;

@end
