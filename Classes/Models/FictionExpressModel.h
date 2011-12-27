//
//  FictionExpressModel.h
//  bookcamp
//
//  Created by lin waiwai on 2/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface FictionExpressModel : TTURLRequestModel <MBProgressHUDDelegate> {
	
	NSMutableArray *_books;
}
@property (nonatomic, retain, readonly) NSMutableArray *books;

@end
