//
//  AuthorViewController.h
//  bookcamp
//
//  Created by lin waiwai on 7/23/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface AuthorViewController : BaseViewController {
	BookObject *_book;
	TTView *_wrapper;
}
@property (nonatomic, retain) TTView *wrapper;
@property (nonatomic, retain) BookObject *book;
@end
