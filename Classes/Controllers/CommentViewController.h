//
//  CommentViewController.h
//  bookcamp
//
//  Created by waiwai on 12/26/10.
//  Copyright 2010 __iwaiwai__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseViewController.h"
#import "CommentAuthorInfoView.h"
#import "CommentContentView.h"
#import "CommentModel.h"


#import "GADBannerView.h"


@interface CommentViewController : BaseViewController <GADBannerViewDelegate>{
	CommentAuthorInfoView *_commentAuthorInfoBar;
	CommentContentView *_commentContentView;
	NSNumber *_cid;
	CommentModel *_commentModel;
	
	GADBannerView *bannerView_;
	
	TTView *_wrapper;
}

@property (nonatomic, retain, readonly) TTView *wrapper;
@property (nonatomic, retain, readonly) CommentModel *commentModel;
@property (nonatomic, retain) NSNumber *cid;
@property (nonatomic, retain) CommentAuthorInfoView *commentAuthorInfoBar;
@property (nonatomic, retain)CommentContentView  *commentContentView;
@end
