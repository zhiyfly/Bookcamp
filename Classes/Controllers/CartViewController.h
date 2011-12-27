//
//  CartViewController.h
//  bookcamp
//
//  Created by waiwai on 12/22/10.
//  Copyright 2010 __iwaiwai__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ParityModel.h"
#import "BaseTableViewController.h"

@interface CartViewController : BaseTableViewController {
	ParityModel *_parityModel;
	NSNumber *_oid;
	TTView *_headerView;
	TTLabel *_bookPriceLabel;
	TTView *_footerView;
	BookObject *_book;
}
@property (nonatomic, retain, readonly) BookObject *book;
@property (nonatomic, retain, readonly) TTView *footerView;
@property (nonatomic, retain, readonly) TTLabel *bookPriceLabel;
@property (nonatomic, retain, readonly) TTView *headerView;
@property (nonatomic, retain) NSNumber *oid;
@property (nonatomic, retain, readonly) ParityModel *parityModel;


@end
