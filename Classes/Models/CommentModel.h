//
//  CommentModel.h
//  bookcamp
//
//  Created by lin waiwai on 2/13/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommentObject.h"
#import "MBProgressHUD.h"

@interface CommentModel : TTURLRequestModel {
	NSNumber *_cid;
	CommentObject *_comment;
	TTURLRequest *_request;
}

@property(nonatomic, retain) NSNumber *cid;
@property (nonatomic, retain, readonly)CommentObject *comment;
@end
