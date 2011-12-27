//
//  BookViewController.h
//  bookcamp
//
//  Created by lin waiwai on 12/28/10.
//  Copyright 2010 __iwaiwai__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTableViewController.h"
#import "BookHeadItem.h"
#import "BookHeadView.h"
#import "MBProgressHUD.h"



@interface BookViewController : BaseViewController <MBProgressHUDDelegate> {
	BookHeadView *_bookHeadView;
	BookListDataSource *_bookInfoTableViewDataSource;
	BookObject *_book;

	NavigatorBar *_toolBar;
	
	NSManagedObjectContext *_managedObjectContext;
	BOOL _scanFlag;
	
	UIScrollView *_scrollView;
	
 	TTButton * favoriteBtn;
	

}


@property (nonatomic, retain) UIScrollView *scrollView;
@property (nonatomic) BOOL scanFlag;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NavigatorBar *toolBar;
@property (nonatomic, retain) BookObject *book;

@property (nonatomic, retain) BookHeadView *bookHeadView;
@property (nonatomic, retain) BookListDataSource *bookInfoTableViewDataSource;
-(id)initWithBookID:(NSString*)oid;
-(void)createToolBar;
-(UIImage*)imageFromCurrentBook;
@end

