//
//  ParityModel.h
//  bookcamp
//
//  Created by lin waiwai on 2/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface ParityModel : TTURLRequestModel <MBProgressHUDDelegate>{
	NSNumber *_oid;
	NSMutableArray	*_parityItems;
	NSString *_priceLabelText;
}

@property (nonatomic, retain) NSString* priceLabelText;
@property (nonatomic, retain) NSMutableArray *parityItems;
@property (nonatomic, retain) NSNumber *oid;

@end
