//
//  CommentsModel.h
//  bookcamp
//
//  Created by lin waiwai on 2/13/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface CommentsModel : TTURLRequestModel <MBProgressHUDDelegate>{
	NSMutableArray *_allComments;
	NSMutableArray *_goodComments;
	NSMutableArray *_badComments;
	NSNumber *_oid;
}

@property (nonatomic, retain) NSNumber *oid;
@property (nonatomic, retain)NSMutableArray*allComments;
@property (nonatomic, retain)NSMutableArray *goodComments;
@property (nonatomic, retain)NSMutableArray *badComments;

@end
