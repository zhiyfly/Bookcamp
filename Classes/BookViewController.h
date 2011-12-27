//
//  BookViewController.h
//
// Created by lin waiwai(jiansihun@foxmail.com) on 1/19/11.
// Copyright 2011 __waiwai__. All rights reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//

#import <UIKit/UIKit.h>
#import "BaseTableViewController.h"
#import "BookHeadItem.h"
#import "BookHeadView.h"
#import "MBProgressHUD.h"



@interface BookViewController : BaseViewController <MBProgressHUDDelegate,GADBannerViewDelegate> {
	BookHeadView *_bookHeadView;
	BookListDataSource *_bookInfoTableViewDataSource;
	BookObject *_book;

	NavigatorBar *_toolBar;
	
	NSManagedObjectContext *_managedObjectContext;
	BOOL _scanFlag;
	
	UIScrollView *_scrollView;
	
 	TTButton * favoriteBtn;
#ifndef NO_AD
		GADBannerView *bannerView_;
#endif

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

