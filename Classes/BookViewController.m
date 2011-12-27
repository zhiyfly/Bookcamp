//
//  BookViewController.m
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

#import "BookViewController.h"
#import "Book.h"

@implementation BookViewController
@synthesize book = _book;

@synthesize bookHeadView = _bookHeadView;
@synthesize bookInfoTableViewDataSource = _bookInfoTableViewDataSource;

@synthesize managedObjectContext = _managedObjectContext;
@synthesize scanFlag = _scanFlag;
@synthesize scrollView = _scrollView;

///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma Start AD
///////////////////////////////////////////////////////////////////////////////////////////////////

#ifndef NO_AD

- (void)adView:(GADBannerView *)bannerView
	didFailToReceiveAdWithError:(GADRequestError *)error {
	BCNSLog(@"adView:didFailToReceiveAdWithError:%@", [error localizedDescription]);
}

- (void)adViewDidReceiveAd:(GADBannerView *)bannerView {
	[self.scrollView addSubview:bannerView_];
	UIScrollView *scrollView = self.scrollView;
	bannerView.frame = CGRectMake(0.0,-bannerView.frame.size.height,
								  bannerView.frame.size.width,
								  bannerView.frame.size.height);
	[UIView beginAnimations:@"BannerSlide" context:nil];
	
	scrollView.contentOffset = CGPointMake(0, -bannerView.frame.size.height) ;
	[UIView commitAnimations];
}


- (void)adViewWillPresentScreen:(GADBannerView *)bannerView{
	
}

#endif

///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma END AD
///////////////////////////////////////////////////////////////////////////////////////////////////


///////////////////////////////////////////////////////////////////////////////////////////////////
-(void)importManagedBook:(Book*)managedBook{
	self.book.isbn13 = managedBook.isbn13;
	_book.isbn10 = managedBook.isbn10;
	_book.oid = managedBook.oid;
	_book.thumbURL = managedBook.thumbURL;
	_book.averageRate = managedBook.averageRate;
	_book.bookName = managedBook.bookName;
	_book.summary = managedBook.summary;
	_book.authors = managedBook.authors;
	_book.authorIntro = managedBook.authorIntro;
	_book.price = managedBook.price;
	_book.publisher = managedBook.publisher;
	_book.pubdate = managedBook.pubdate;
	_book.numRaters = managedBook.numRaters;
	_book.pages = managedBook.pages;
	_book.bookStatus = Finish;
}

-(Book*)createManagedBookUsingCurrentContext{
	Book *newBook = [NSEntityDescription insertNewObjectForEntityForName:@"Book" inManagedObjectContext:[self managedObjectContext]];
	newBook.oid = self.book.oid;
	newBook.authorIntro = _book.authorIntro;
	newBook.authors  = _book.authors;
	newBook.averageRate = _book.averageRate;
	newBook.bookName  = _book.bookName;
	newBook.isbn10 = _book.isbn10;
	newBook.isbn13 = _book.isbn13;
	newBook.numRaters = _book.numRaters;
	newBook.pages = _book.pages;
	newBook.price = _book.price;
	newBook.pubdate = _book.pubdate;
	newBook.publisher = _book.publisher;
	newBook.summary = _book.summary;
	newBook.thumbURL = _book.thumbURL;
	newBook.savedDate = [NSDate date];
	newBook.favorited = [NSNumber numberWithBool: NO];
	newBook.historied = [NSNumber numberWithBool:YES];
	return newBook;
}

-(void)historiedBookContextDidSave:(NSNotification*)aNotification{
	NSNotificationCenter *dnc = [NSNotificationCenter defaultCenter];
	if (aNotification.object ==  self.managedObjectContext) {
		[dnc removeObserver:self name:NSManagedObjectContextDidSaveNotification object:self.managedObjectContext];
		NSNotification *notification = [NSNotification notificationWithName:HistoriedObjectContextDidSaveNotification object:nil
																   userInfo:aNotification.userInfo];
		[dnc postNotification:notification];
	}
}

///////////////////////////////////////////////////////////////////////////////////////////////////
-(void)FavoritedBookContextDidSave:(NSNotification*)aNotification{
	NSNotificationCenter *dnc = [NSNotificationCenter defaultCenter];
	if (aNotification.object ==  self.managedObjectContext) {
		[dnc removeObserver:self name:NSManagedObjectContextDidSaveNotification object:self.managedObjectContext];
		NSNotification *notification = [NSNotification notificationWithName:FavoritedObjectContextDidSaveNotification object:nil
																   userInfo:aNotification.userInfo];
		[dnc postNotification:notification];
	}
}



-(void)saveToHisotry{
	NSAssert(self.book.oid,@"book is not ready");
	if (self.scanFlag) {
		NSNotificationCenter *dnc = [NSNotificationCenter defaultCenter];
		[dnc addObserver:self selector:@selector(historiedBookContextDidSave:) name:NSManagedObjectContextDidSaveNotification object:self.managedObjectContext];
		Book *managedBook = [self getBookFromCurrentContextUsingOid:self.book.oid];
		if (!managedBook) {
			[self createManagedBookUsingCurrentContext];
		}
		if (![managedBook.historied boolValue]) {
			managedBook.historied = [NSNumber numberWithBool:YES];
			NSError *error;
			if (![self.managedObjectContext save:&error]) {
				// Update to handle the error appropriately.
				BCNSLog(@"Unresolved error %@, %@", error, [error userInfo]);
				exit(-1);  // Fail
			}else {
				BCNSLog(@"done");
			}
		}
	}
}

///////////////////////////////////////////////////////////////////////////////////////////////////
-(Book*)getBookFromCurrentContextUsingOid:(NSNumber*)oid{
	NSManagedObjectContext *moc = [self managedObjectContext];
	NSFetchRequest *fetchRequest = [[[NSFetchRequest alloc] init] autorelease];
	[fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"oid = %@", oid]];
	NSEntityDescription *entity = [NSEntityDescription entityForName:@"Book" inManagedObjectContext:[self managedObjectContext]];
	[fetchRequest setEntity:entity];
	[fetchRequest setFetchLimit:1];
	NSError *error;
	NSArray *aBooks = [moc executeFetchRequest:fetchRequest error:&error];
	if (aBooks && !![aBooks count]) {
		return [aBooks objectAtIndex:0];
	}
	return nil;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
-(Book*)getBookFromCurrentContextUsingISBN13:(NSNumber*)isbn13{
	NSManagedObjectContext *moc = [self managedObjectContext];
	NSFetchRequest *fetchRequest = [[[NSFetchRequest alloc] init] autorelease];
	[fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"isbn13 = %@", isbn13]];
	NSEntityDescription *entity = [NSEntityDescription entityForName:@"Book" inManagedObjectContext:[self managedObjectContext]];
	[fetchRequest setEntity:entity];
	[fetchRequest setFetchLimit:1];
	NSError *error;
	NSArray *aBooks = [moc executeFetchRequest:fetchRequest error:&error];
	if (aBooks && !![aBooks count]) {
		return [aBooks objectAtIndex:0];
	}
	return nil;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
-(Book*)getBookFromCurrentContextUsingISBN10:(NSNumber*)isbn10{
	NSManagedObjectContext *moc = [self managedObjectContext];
	NSFetchRequest *fetchRequest = [[[NSFetchRequest alloc] init] autorelease];
	[fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"isbn10 = %@", isbn10]];
	NSEntityDescription *entity = [NSEntityDescription entityForName:@"Book" inManagedObjectContext:[self managedObjectContext]];
	[fetchRequest setEntity:entity];
	[fetchRequest setFetchLimit:1];
	NSError *error;
	NSArray *aBooks = [moc executeFetchRequest:fetchRequest error:&error];
	if (aBooks && !![aBooks count]) {
		return [aBooks objectAtIndex:0];
	}
	return nil;
}




///////////////////////////////////////////////////////////////////////////////////////////////////
-(id)initWithISBN13:(NSString*)isbn13 fromScan:(NSString*)aFlag{
	if (self = [super initWithNibName:nil bundle:nil]){
		Book *managedBook = [self getBookFromCurrentContextUsingISBN13:[NSNumber numberWithDouble:[isbn13 doubleValue]]];
		if (managedBook) {
			[self importManagedBook:managedBook];
			[self saveToHisotry];
			[self handleCurrentBook];
		} else {
			self.book = [[BookObject alloc] initWithISBN13:[NSNumber numberWithDouble:[isbn13 doubleValue]]];
			if ([aFlag isEqualToString:@"YES"]) {
				self.scanFlag =  YES;
			} else {
				self.scanFlag = NO;
			}
			[_book addObserver:self
				forKeyPath:@"bookStatus"
				   options:(NSKeyValueObservingOptionNew |
							NSKeyValueObservingOptionOld)
				   context:NULL];
			[_book sync];

		}
		[self.scrollView addSubview:self.bookHeadView];

	}
	return self;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma Init entry Start
///////////////////////////////////////////////////////////////////////////////////////////////////

-(id)initWithBookID:(NSString*)oid{
	if (self = [super initWithNibName:nil bundle:nil]){
		self.book = [[BookObject alloc] initWithBookID:[NSNumber numberWithInt:[oid intValue]]];
		self.scanFlag =  NO;
		[_book addObserver:self
				forKeyPath:@"bookStatus"
				   options:(NSKeyValueObservingOptionNew |
							NSKeyValueObservingOptionOld)
				   context:NULL];
		[_book sync];
		[self.scrollView addSubview:self.bookHeadView];
		

	}	
	return self;
}




///////////////////////////////////////////////////////////////////////////////////////////////////
-(id)initWithISBN10:(NSString*)isbn10 fromScan:(NSString*)aFlag{
	if (self = [super initWithNibName:nil bundle:nil]){
		Book *managedBook = [self getBookFromCurrentContextUsingISBN10:[NSNumber numberWithDouble:[isbn10 doubleValue]]];
		if (managedBook) {
			[self importManagedBook:managedBook];
			[self saveToHisotry];
			[self handleCurrentBook];
		} else {
			self.book = [[BookObject alloc] initWithISBN10:[NSNumber numberWithDouble:[isbn10 doubleValue]]];
			if ([aFlag isEqualToString:@"YES"]) {
				self.scanFlag =  YES;
			} else {
				self.scanFlag = NO;
			}
			[_book addObserver:self
				forKeyPath:@"bookStatus"
				   options:(NSKeyValueObservingOptionNew |
							NSKeyValueObservingOptionOld)
				   context:NULL];
			[_book sync];
		
		}
		[self.scrollView addSubview:self.bookHeadView];
		[self.navigatorBar addToNavigatorView:self.backBtn align:NavigationViewAlignLeft];
	}
	return self;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma Init entry Start
///////////////////////////////////////////////////////////////////////////////////////////////////

-(NavigatorBar*)navigatorBar{
	super.navigatorBar.style = TTSTYLE(navigatorBarStyleTwo);
	return [super navigatorBar];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
-(void)handleCurrentBook{
	[self.bookHeadView setObject:_book];
	
	NSString *summary =  [[_book.summary copy] autorelease];
	if (summary) {
		
		while ( [summary rangeOfString:@"\n\n"].location != NSNotFound) {
			summary = [summary stringByReplacingOccurrencesOfString:@"\n\n" withString:@"\n"];
		}
		
		while ([summary rangeOfString:@"\n\r\n\r"].location != NSNotFound) {
			summary = [summary stringByReplacingOccurrencesOfString:@"\n\r\n\r" withString:@"\n\r"];
		}
		
		while ( [summary rangeOfString:@"　　"].location != NSNotFound) {
			summary = [summary stringByReplacingOccurrencesOfString:@"　　" withString:@"　"];
		}
		while ( [summary rangeOfString:@"  "].location != NSNotFound) {
			summary = [summary stringByReplacingOccurrencesOfString:@"  " withString:@" "];
		}
		
		
		summary = [summary stringByReplacingOccurrencesOfString:@"\n" withString:@"<br/><br/>"];
		summary = [summary stringByReplacingOccurrencesOfString:@"\n\r" withString:@"<br/><br/>"];
	}
	
	TTStyledText *styledText = [TTStyledText textFromXHTML:summary?[NSString stringWithFormat:@" <br/>%@<br/> ",summary]:@"" lineBreaks:YES URLs:NO];
	styledText.width = self.scrollView.width - BKContentMargin*2;
	styledText.font =[UIFont systemFontOfSize: 14.0];
	TTStyledTextLabel *summaryLabel = [[TTStyledTextLabel alloc] initWithFrame:CGRectMake(BKContentMargin,
																						  self.bookHeadView.height, self.scrollView.width-BKContentMargin*2, styledText.height)];
	summaryLabel.font = [UIFont systemFontOfSize: 14.0];
	summaryLabel.text = styledText;
	summaryLabel.backgroundColor = [UIColor clearColor];
	[summaryLabel sizeToFit];
	
	[self.scrollView addSubview:summaryLabel];
	[self.scrollView setContentSize:CGSizeMake(self.bookHeadView.width, summaryLabel.height+self.bookHeadView.height)];
	NSString *author;
	if ([_book.authors count]>0) {
		author = [_book.authors objectAtIndex:0];
	}
	
	if ([self.book.authors count] > 1) {
		author = [author stringByAppendingString:BCLocalizedString(@"etc", @"etc")];
	}
	
	
	//ad start
	
	// Create a view of the standard size at the bottom of the screen.
#ifndef NO_AD
    
	bannerView_ = [[GADBannerView alloc]
				   initWithFrame:CGRectMake(0.0,
											self.view.frame.size.height,
											GAD_SIZE_320x50.width,
											GAD_SIZE_320x50.height)];
	
	// Specify the ad's "unit identifier." This is your AdMob Publisher ID.
	
	bannerView_.adUnitID = MY_BANNER_UNIT_ID;
	
	// Let the runtime know which UIViewController to restore after taking
	// the user wherever the ad goes and add it to the view hierarchy.
	bannerView_.rootViewController = self;

	
	[bannerView_ setDelegate:self];
	// Initiate a generic request to load it with an ad.
	GADRequest *request =  [GADRequest request];
	
	//Server error processing the request
	//[request addKeyword:_book.summary];
	[request addKeyword:_book.bookName?_book.bookName:@""];
	[request addKeyword:_book.publisher?_book.publisher:@""];
	[request addKeyword:author && [author isKindOfClass:[NSString class]]?author:@""];
#ifdef BCDebug 
	request.testDevices = [NSArray arrayWithObjects:
						   GAD_SIMULATOR_ID,                               // Simulator
						   @"28ab37c3902621dd572509110745071f0101b124",    // Test iPhone 3G 3.0.1
						   @"8cf09e81ef3ec5418c3450f7954e0e95db8ab200",    // Test iPod 4.3.1
						   nil];
#endif	
	[bannerView_ loadRequest:request];
	
#endif
	
}


					 
///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)observeValueForKeyPath:(NSString *)keyPath
					  ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context
{
    if ([keyPath isEqual:@"bookStatus"]) {
  		ObjectStatusFlag bookStatus =  (ObjectStatusFlag)[[change objectForKey:NSKeyValueChangeNewKey] intValue];
		if ( bookStatus == Finish  ){
			[self saveToHisotry];
			[self handleCurrentBook];
			//add To history
			self.toolBar.userInteractionEnabled = YES;
			
			
				
		} else if (bookStatus == Fail) {
			self.toolBar.userInteractionEnabled = NO;
			
			//NSAssert(FALSE, @"should handle the book fail");
			id navigationController = [[[TTNavigator navigator] visibleViewController] navigationController];
			
			MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:[navigationController view]];
			HUD.style = TTSTYLE(progressHUDStyle);
			
			// The sample image is based on the work by www.pixelpressicons.com, http://creativecommons.org/licenses/by/2.5/ca/
			// Make the customViews 37 by 37 pixels for best results (those are the bounds of the build-in progress indicators)
			HUD.customView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"warning.png"]] autorelease];
			// Set custom view mode
			HUD.mode = MBProgressHUDModeCustomView;
			HUD.minShowTime = 2;
			// Add HUD to screen
			[[navigationController view] addSubview:HUD];
			
			// Regisete for HUD callbacks so we can remove it from the window at the right time
			HUD.delegate = [[UIApplication sharedApplication] delegate];
			
			HUD.labelText = BCLocalizedString(@"unable connect", @"unable connect") ;
			
			[HUD show:YES];
			[HUD hide:YES];
		}
    }
}

///////////////////////////////////////////////////////////////////////////////////////////////////
-(void)viewWillAppear:(BOOL)animated{
	[super viewWillAppear:animated];

	[self.view addSubview:self.navigatorBar];
	if (self.backBtn.superview != self.navigatorBar) {
		[self.navigatorBar addToNavigatorView:self.backBtn align:NavigationViewAlignLeft];

	}
		
	
	[self.view addSubview:self.scrollView];
	[self.view addSubview:self.toolBar];
}

- (NSManagedObjectContext *) managedObjectContext {
    if (!_managedObjectContext ) {
		ModelLocator *locator = [ModelLocator sharedInstance];
		NSPersistentStoreCoordinator *coordinator = [locator persistentStoreCoordinator];
		if (coordinator != nil) {
			_managedObjectContext = [[NSManagedObjectContext alloc] init];
			[_managedObjectContext setPersistentStoreCoordinator: coordinator];
		}
    }

    return _managedObjectContext;
}

-(Book*)getBook:(NSNumber*)oid{
	NSManagedObjectContext *moc = [self managedObjectContext];
	NSFetchRequest *fetchRequest = [[[NSFetchRequest alloc] init] autorelease];
	[fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"oid = %@", oid]];
	NSEntityDescription *entity = [NSEntityDescription entityForName:@"Book" inManagedObjectContext:[self managedObjectContext]];
	[fetchRequest setEntity:entity];
	[fetchRequest setFetchLimit:1];
	NSError *error;
	NSArray *aBooks = [moc executeFetchRequest:fetchRequest error:&error];
	if (aBooks && !![aBooks count]) {
		return [aBooks objectAtIndex:0];
	}
	return nil;
}





///////////////////////////////////////////////////////////////////////////////////////////////////
-(void)favorite:(TTButton*)btn{

		NSError *error;
#ifndef BCDebug

	Book *aBook = [self getBook:self.book.oid];
	if (aBook) {
		if (![aBook.favorited boolValue] ) {
			aBook.favorited = [NSNumber numberWithBool:YES];
			if (![self.managedObjectContext save:&error]) {
				// Update to handle the error appropriately.
				BCNSLog(@"Unresolved error %@, %@", error, [error userInfo]);
				exit(-1);  // Fail
			}else {
				BCNSLog(@"done");
			}
		}
		return;
	}
#endif;
	NSNotificationCenter *dnc = [NSNotificationCenter defaultCenter];
	[dnc addObserver:self selector:@selector(FavoritedBookContextDidSave:) name:NSManagedObjectContextDidSaveNotification object:self.managedObjectContext];
	Book *newBook = [NSEntityDescription insertNewObjectForEntityForName:@"Book" inManagedObjectContext:[self managedObjectContext]];
	newBook.oid = self.book.oid;
	newBook.authorIntro = self.book.authorIntro;
	newBook.authors  = self.book.authors;
	newBook.averageRate = self.book.averageRate;
	newBook.bookName  = self.book.bookName;
	newBook.isbn10 = self.book.isbn10;
	newBook.isbn13 = self.book.isbn13;
	newBook.numRaters = self.book.numRaters;
	newBook.pages = self.book.pages;
	newBook.price = self.book.price;
	newBook.pubdate = self.book.pubdate;
	newBook.publisher = self.book.publisher;
	newBook.summary = self.book.summary;
	newBook.thumbURL = self.book.thumbURL;
	newBook.savedDate = [NSDate date];
	newBook.favorited = [NSNumber numberWithBool: YES];
	newBook.historied = [NSNumber numberWithBool:NO];


	if (![self.managedObjectContext save:&error]) {
		// Update to handle the error appropriately.
		BCNSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		
		
		exit(-1);  // Fail
	}else {
		BCNSLog(@"done");
	
		btn.selected = YES;	
	}
}

///////////////////////////////////////////////////////////////////////////////////////////////////
-(void)createToolBar{
		
	self.toolBar.leftPadding = 0;
	self.toolBar.rightPadding = 0;
	self.toolBar.itemGap = 0;
	CGFloat w = self.toolBar.width/4;
	CGFloat h = self.toolBar.height;
	
	TTNavigator* navigator = [TTNavigator navigator];
	TTURLMap* map = navigator.URLMap;
	[map setObject:self.book forURL:[@"tt://bookObject/" stringByAppendingFormat:@"%@",self.book.oid]];
	

	
	TTButton *favoriteBtn = [TTButton buttonWithStyle:@"toolbarFavoriteButton:" title:BCLocalizedString(@"favorite", @"favorite")];
	favoriteBtn.frame = CGRectMake(0, 0, w, h);
	[favoriteBtn addTarget:self action:@selector(favorite:) forControlEvents:UIControlEventTouchUpInside];
	[self.toolBar addToNavigatorView:favoriteBtn align:NavigationViewAlignRight];
	
	Book *local = [self getBookFromLocalById:self.book.oid];
	
	
	//NSLog(@"%@",local.favorited);
	if (local && local.favorited ) {
		favoriteBtn.selected = YES;
	}

		
	BKLink *parityLink = [[[BKLink alloc] initWithFrame:CGRectMake(0, 0, w, h)] autorelease];
	[parityLink setTitle:BCLocalizedString(@"ParityLink",@"the link button text of ParityLink") forState:UIControlStateNormal];
	[parityLink setStylesWithSelector:@"toolbarParityButton:"];
	[self.toolBar addToNavigatorView:parityLink align:NavigationViewAlignRight];
	parityLink.URL = [self.book URLValueWithName:@"cart"];
	
	
	BKLink *bookCommentLink = [[[BKLink alloc] initWithFrame:CGRectMake(0, 0, w, h)] autorelease];
	[bookCommentLink setStylesWithSelector:@"toolbarCommentButton:"]; 
	[bookCommentLink setTitle:BCLocalizedString(@"BookCommentLink",@"the link button text of BookComment") forState:UIControlStateNormal];
	[self.toolBar addToNavigatorView:bookCommentLink align:NavigationViewAlignRight];
	bookCommentLink.URL = [self.book URLValueWithName:@"comments"];
	
	
	BKLink *aboutAuthorLink = [[[BKLink alloc] initWithFrame:CGRectMake(0, 0, w, h)] autorelease];
	[aboutAuthorLink setStylesWithSelector:@"toolbarAuthorButton:"];
	[aboutAuthorLink setTitle:BCLocalizedString(@"AboutAuthorLink",@"the link button text of BookComment") forState:UIControlStateNormal];
	[self.toolBar addToNavigatorView:aboutAuthorLink align:NavigationViewAlignLeft];
 	aboutAuthorLink.URL = [self.book URLValueWithName:@"author"];
	
}

-(Book*)getBookFromLocalById:(NSNumber*)oid{
	ModelLocator *locator = [ModelLocator sharedInstance];
	NSPersistentStoreCoordinator *coordinator = [locator persistentStoreCoordinator];
	
	NSManagedObjectContext *moc = [[[NSManagedObjectContext alloc] init] autorelease];
	[moc setPersistentStoreCoordinator: coordinator];
	
	NSFetchRequest *fetchRequest = [[[NSFetchRequest alloc] init] autorelease];
	NSEntityDescription *entity = [NSEntityDescription entityForName:@"Book" inManagedObjectContext:moc];
	[fetchRequest setEntity:entity];
	[fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"oid = %@",  oid]];
	
	NSSortDescriptor *savedDateDescriptor = [[[NSSortDescriptor alloc] initWithKey:@"savedDate" ascending:YES] autorelease];
	NSArray *sortDescriptors = [[[NSArray alloc] initWithObjects:savedDateDescriptor, nil] autorelease];
	[fetchRequest setSortDescriptors:sortDescriptors];
	[fetchRequest setFetchLimit:1];
	NSError *error;
	NSArray *aBooks = [moc executeFetchRequest:fetchRequest error:&error];
	
	if ([aBooks count] > 0) {
		return [aBooks objectAtIndex:0];
	}
	return nil;
	
}



#define ToolBarHeight 40
///////////////////////////////////////////////////////////////////////////////////////////////////
-(NavigatorBar*)toolBar{
	if (!_toolBar) {
		_toolBar = [[NavigatorBar alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(BKScreenBoundsWithoutBar()) - ToolBarHeight, CGRectGetWidth(self.view.frame), ToolBarHeight)];
		_toolBar.backgroundColor = [UIColor whiteColor];
		[self createToolBar];
		self.toolBar.userInteractionEnabled = YES;
		[self.view addSubview:_toolBar];
	}
	return  _toolBar;
}

-(void)didReceiveMemoryWarning{
	[super didReceiveMemoryWarning];
 
}



-(UIImage*)imageFromCurrentBook{
	return [[ScreenCapture capture] captureView:self.scrollView];
	
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (id<UITableViewDelegate>)createDelegate {
	return [[[BKTableViewExpandableHeightDelegate alloc] initWithController:self] autorelease];
}

-(CGRect)rectForNavigator{
	return BKNavigatorBarFrameTwo();
}

-(UIScrollView*)scrollView{
	if (!_scrollView) {
		self.view.backgroundColor = [UIColor clearColor];
		_scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, BKNavigatorBarHeightTwo,
																	RootModuleWidth, 
																	 CGRectGetHeight(BKScreenBoundsWithoutBar()) - ToolBarHeight- BKNavigatorBarHeightTwo)];
		_scrollView.backgroundColor = RGBCOLOR(242,242,242);

		[self.view addSubview:_scrollView];
	}
	return _scrollView;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark BookHeadView
-(BookHeadView*)bookHeadView{
	if (!_bookHeadView) {
		_bookHeadView = [[BookHeadView alloc] initWithFrame:CGRectMake(0, 0 , RootModuleWidth, BKBookHeadViewHeight)];
		_bookHeadView.style = TTSTYLE(infoBackground);
	}
	return _bookHeadView;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)dealloc {
	
	TT_RELEASE_SAFELY( _bookHeadView);
	TT_RELEASE_SAFELY( _bookInfoTableViewDataSource);
	
	TT_RELEASE_SAFELY( _managedObjectContext);

	TT_RELEASE_SAFELY(_scrollView);
#ifndef NO_AD
	TT_RELEASE_SAFELY(bannerView_);
#endif
    [_book removeObserver:self forKeyPath:@"bookStatus"];
	TT_RELEASE_SAFELY(_book);
    

    [super dealloc];
}


@end
