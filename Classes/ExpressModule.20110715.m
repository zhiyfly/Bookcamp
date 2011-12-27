//
//  ExpressModule.m
//  ;
//
//  Created by waiwai on 12/19/10.
//  Copyright 2010 __iwaiwai__. All rights reserved.
//

#import "ExpressModule.h"
#import "CSVerticalLayout.h"
#import "BCTableViewDelegate.h"
#import "BookObject.h"
@implementation ExpressModule_backup

@synthesize categorySegmentedBar = _categorySegmentedBar;
@synthesize subCategoryBar = _subCategoryBar;
@synthesize bookTableView = _bookTableView;
@synthesize tableViewVarHeightDelegate = _tableViewVarHeightDelegate;

//model
@synthesize fictionExpressModel = _fictionExpressModel;
@synthesize nofictionExpressModel = _nofictionExpressModel;
@synthesize fictionRankingModel = _fictionRankingModel;
@synthesize nofictionRankingModel = _nofictionRankingModel;

//datasourc
@synthesize latestFictionBookTableViewDataSource = _latestFictionBookTableViewDataSource;
@synthesize latestNonfictionBookTableViewDataSource = _latestNonfictionBookTableViewDataSource;
@synthesize rankingFictionBookTableViewDataSource = _rankingFictionBookTableViewDataSource;
@synthesize rankingNonfictionBookTableViewDataSource = _rankingNonfictionBookTableViewDataSource;


///////////////////////////////////////////////////////////////////////////////////////////////////
-(void)dealloc{
	TT_RELEASE_SAFELY(_categorySegmentedBar);
	TT_RELEASE_SAFELY(_subCategoryBar);
	TT_RELEASE_SAFELY(_bookTableView);
	TT_RELEASE_SAFELY(_tableViewVarHeightDelegate);
	
	//model
	TT_RELEASE_SAFELY(_fictionExpressModel);
	TT_RELEASE_SAFELY(_nofictionExpressModel);
	TT_RELEASE_SAFELY(_fictionRankingModel);
	TT_RELEASE_SAFELY(_nofictionRankingModel);
	[super dealloc];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Model

///////////////////////////////////////////////////////////////////////////////////////////////////
-(FictionExpressModel*)fictionExpressModel{
	if (!_fictionExpressModel) {
		_fictionExpressModel = [[FictionExpressModel alloc] init];
	}
	return _fictionExpressModel;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
-(NofictionExpressModel*)nofictionExpressModel{
	if (!_nofictionExpressModel) {
		_nofictionExpressModel = [[NofictionExpressModel alloc] init];
	}
	return _nofictionExpressModel;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
-(FictionRankingModel*)fictionRankingModel{
	if (!_fictionRankingModel) {
		_fictionRankingModel = [[FictionRankingModel alloc] init];
	}
	return _fictionRankingModel;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
-(NofictionRankingModel*)nofictionRankingModel{
	if (!_nofictionRankingModel) {
		_nofictionRankingModel = [[NofictionRankingModel alloc] init];
	}
	return _nofictionRankingModel;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)createModel {
	self.model =  self.fictionExpressModel;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
-(id)initWithConfig:(NSDictionary*)config{
	if (self = [super initWithConfig:config]) {
		self.view.navigatorBarHidden = NO;
		
		[self.view.navigatorBar addToNavigatorView:self.categorySegmentedBar align:NavigationViewAlignCenter];
		[self.view.contentView addSubview:self.subCategoryBar];
		[self.view.contentView addSubview:self.bookTableView];
		
		ModelLocator *locator = [ModelLocator sharedInstance];
		[locator addObserver:self
				  forKeyPath:@"latestFictionBooks"
					 options:(NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld)
					 context:NULL];
		[locator addObserver:self
				  forKeyPath:@"latestNonfictionBooks"
					 options:(NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld)
					 context:NULL];
		[locator addObserver:self
				  forKeyPath:@"rankingFictionBooks"
					 options:(NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld)
					 context:NULL];
		[locator addObserver:self
				  forKeyPath:@"rankingNonfictionBooks"
					 options:(NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld)
					 context:NULL];
		
		[self layout];
	}
	return self;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)observeValueForKeyPath:(NSString *)keyPath
					  ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context
{
	NSArray *books =  (NSArray*)[change objectForKey:NSKeyValueChangeNewKey];
	NSMutableArray	*bookItems = [NSMutableArray arrayWithCapacity:[books count]];
	for (BookObject*book in books) {	
		NSString *caption = [book.authors objectAtIndex:0];
		if ([book.authors count] > 1) {
			caption = [caption stringByAppendingString:BCLocalizedString(@"etc", @"etc")];
		}
		NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
		[dateFormatter setDateFormat:@"yyyy-MM"];
		[dateFormatter setLocale:[NSLocale currentLocale]];
		NSString* dateStr = [dateFormatter stringFromDate:book.pubdate];
		
		caption = [NSString stringWithFormat:@"%@/%@/%@", caption, book.publisher, dateStr];
		[bookItems addObject:[BookCellItem itemWithTitle:book.bookName caption:caption
												  rating:book.averageRate imageURL:book.thumbURL  
													 URL:[@"tt://book/" stringByAppendingString:[book.oid stringValue]]]];
	}
	if ([keyPath isEqual:@"latestFictionBooks"]) {
		self.latestFictionBookTableViewDataSource = [[[BookListDataSource alloc] initWithItems:bookItems] autorelease];
		//the TTTableView doesn't retain the datasource . so the context must hold it itself;
		if (!self.bookTableView.dataSource ) {
			self.bookTableView.dataSource = _latestFictionBookTableViewDataSource;
			self.bookTableView.dataSource.model  = self.fictionExpressModel;
			//force the table view to reloadSource;
			[self.bookTableView reloadData];
		}
    } else if ([keyPath isEqual:@"latestNonfictionBooks"]) {
		self.latestNonfictionBookTableViewDataSource = [[[BookListDataSource alloc] initWithItems:bookItems] autorelease];
		if (!self.bookTableView.dataSource ) {
			self.bookTableView.dataSource = _latestNonfictionBookTableViewDataSource;
			self.bookTableView.dataSource.model = self.nofictionExpressModel;
			[self.bookTableView reloadData];
		}
	} else if ([keyPath isEqual:@"rankingFictionBooks"]) {
		self.rankingFictionBookTableViewDataSource = [[[BookListDataSource alloc] initWithItems:bookItems] autorelease];
		if (!self.bookTableView.dataSource) {
			self.bookTableView.dataSource = _rankingFictionBookTableViewDataSource;
			self.bookTableView.dataSource.model = self.fictionRankingModel;
			[self.bookTableView reloadData];
		}
		
	} else if ([keyPath isEqual:@"rankingNonfictionBooks"]) {
		self.rankingNonfictionBookTableViewDataSource = [[[BookListDataSource alloc] initWithItems:bookItems] autorelease];
		if (!self.bookTableView.dataSource) {
			self.bookTableView.dataSource = _rankingNonfictionBookTableViewDataSource;
			self.bookTableView.dataSource.model = self.nofictionRankingModel;
			[self.bookTableView reloadData];
		}
	}
	
}

//0101
static NSUInteger tabSelected = 5;
static BOOL changeFlag = NO;

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark TTTabDelegate
- (void)tabBar:(TTTabBar*)tabBar tabSelected:(NSInteger)selectedIndex{
	if ((tabBar == self.subCategoryBar) && !changeFlag) {
		NSUInteger f = 3 << (self.categorySegmentedBar.selectedTabIndex * 2);
		tabSelected = ((( ~ (f & tabSelected)) & f )| ( ~ f & tabSelected)) & 15;
	} if (tabBar == self.categorySegmentedBar) {
		NSUInteger d = (((tabSelected >> ( self.categorySegmentedBar.selectedTabIndex * 2)) & 3) - 1);
		//avoid the subbar to change
		changeFlag = YES;
		self.subCategoryBar.selectedTabIndex = d ;
		changeFlag = NO;
	} 
	if (!changeFlag) {
		switch (self.categorySegmentedBar.selectedTabIndex*2 + self.subCategoryBar.selectedTabIndex) {
			case 0:
				if (self.model != self.fictionExpressModel) {
					self.model = self.fictionExpressModel;
					if (_latestFictionBookTableViewDataSource) {
						self.bookTableView.dataSource = _latestFictionBookTableViewDataSource;
						self.bookTableView.dataSource.model = self.fictionExpressModel;
						[self.bookTableView reloadData];
					} else {
						[self refresh];
					}
				}
				break;
			case 1:
				if (self.model != self.nofictionExpressModel ) {
					self.model = self.nofictionExpressModel;
					if (_latestNonfictionBookTableViewDataSource) {
						self.bookTableView.dataSource = _latestNonfictionBookTableViewDataSource;
						self.bookTableView.dataSource.model  = self.nofictionExpressModel;
						[self.bookTableView reloadData];
					}else {
						[self refresh];
					}
					
				}
				break;
			case 2:
				if (self.model != self.fictionRankingModel) {
					self.model = self.fictionRankingModel;
					if (_rankingFictionBookTableViewDataSource) {
						self.bookTableView.dataSource = _rankingFictionBookTableViewDataSource;
						self.bookTableView.dataSource.model = self.fictionRankingModel;
						[self.bookTableView reloadData];
					}else {
						[self refresh];
					}
					
				}
				break;
			case 3:
				if (self.model != self.nofictionRankingModel) {
					self.model = self.nofictionRankingModel;
					if (_rankingNonfictionBookTableViewDataSource) {
						self.bookTableView.dataSource = _rankingNonfictionBookTableViewDataSource;
						self.bookTableView.dataSource.model = self.nofictionRankingModel;
						[self.bookTableView reloadData];
						
					}else {
						[self refresh];
					}
					
				}
				break;
			default:
				NSAssert(FALSE, @"shoule not be here");
				break;
		}
	}
	
}


///////////////////////////////////////////////////////////////////////////////////////////////////
-(void)layout{
	CSVerticalLayout* flowLayout = [[[CSVerticalLayout alloc] init] autorelease];
	flowLayout.indentSize = CGSizeMake(0, 0);
	flowLayout.padding = UIEdgeInsetsMake(0, 0, 0, 0) ;
	flowLayout.spacing = 0;
	//CGSize size = 
	[flowLayout layoutSubviews:self.view.contentView.subviews forView:self.view.contentView];
}

#define subCategoryBarHeight 30
///////////////////////////////////////////////////////////////////////////////////////////////////
-(BCSegment*)subCategoryBar{
	if (!_subCategoryBar) {
		_subCategoryBar = [[BCSegment alloc] initWithFrame:CGRectMake(0,0, CGRectGetWidth(self.view.frame), subCategoryBarHeight)];
		_subCategoryBar.backgroundColor = [UIColor whiteColor];
		_subCategoryBar.tabItems = [NSArray arrayWithObjects:
									[[[TTTabItem alloc] initWithTitle:BCLocalizedString(@"Fiction", @"Fiction")] autorelease],
									[[[TTTabItem alloc] initWithTitle:BCLocalizedString(@"NonFiction",@"NonFiction")] autorelease],
									nil];
		//_subCategoryBar.styleSuffix = @"subCategory";
		[_subCategoryBar sizeToFit];
		_subCategoryBar.delegate = self;
	}
	return _subCategoryBar;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
-(BCSegment*)categorySegmentedBar{
	if (!_categorySegmentedBar) {
		_categorySegmentedBar = [[BCSegment alloc] initWithFrame:CGRectMake(0, 0, 90, 20)];
		_categorySegmentedBar.backgroundColor = [UIColor whiteColor];
		_categorySegmentedBar.tabItems = [NSArray arrayWithObjects:
										  [[[TTTabItem alloc] initWithTitle:BCLocalizedString(@"BookExpress", @"BookExpress")] autorelease],
										  [[[TTTabItem alloc] initWithTitle:BCLocalizedString(@"Ranking",@"Ranking")] autorelease],
										  nil];
		[_categorySegmentedBar sizeToFit];
		_categorySegmentedBar.delegate = self;
	}
	return _categorySegmentedBar;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
-(BCTableViewVarHeightDelegate*)tableViewVarHeightDelegate{
	if (!_tableViewVarHeightDelegate) {
		_tableViewVarHeightDelegate = [[BCTableViewVarHeightDelegate alloc] initWithController:self];
	}
	return _tableViewVarHeightDelegate;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark tableView

///////////////////////////////////////////////////////////////////////////////////////////////////
-(TTTableView*)bookTableView{
	if (!_bookTableView) {
		_bookTableView = [[TTTableView alloc] initWithFrame:CGRectMake(0, 0,CGRectGetWidth(self.view.contentView.frame),
																	   CGRectGetHeight(self.view.contentView.frame)-subCategoryBarHeight)];
		
		_bookTableView.delegate = [self tableViewVarHeightDelegate];
	}
	return _bookTableView;
}

@end
