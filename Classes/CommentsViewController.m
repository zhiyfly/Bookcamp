//
//  CommentViewController.m
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
#import "CommentsViewController.h"
#import "BCTableViewDelegate.h"
#import "ParticularRowTableViewDelegate.h"
#import "Three20UI/private/TTTabBarInternal.h"
#import "StripTabBar.h"
@implementation CommentsViewController

@synthesize oid = _oid;


@synthesize stripTabBar=_stripTabBar;


-(id)initWithBookID:(NSString*)oid{
	if (self = [super initWithNibName:nil bundle:nil]) {
				[self.backBtn setStylesWithSelector:@"backBtnCloseStyle:"];

		
		self.oid = [NSNumber numberWithInt:[oid intValue]];
		self.variableHeightRows = YES;
		NSMutableArray *items = [NSMutableArray array];
		TTTabItem *item = nil;
		NSArray *commentStripBars = commentStripBarItems();
		NSUInteger i, count = [commentStripBars count];
		for (i = 0; i < count; i++) {
			NSString *itemName = [commentStripBars objectAtIndex:i];
			item = [[[TTTabItem alloc] initWithTitle:BCLocalizedString(itemName,@"the name of every strip tab")] autorelease];
			[items addObject:item];
		}
		self.stripTabBar.tabItems = (NSArray*)items;
		
	}
	return self;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (id<UITableViewDelegate>)createDelegate {

	return [[[ParticularRowTableViewDelegate alloc] initWithController:self] autorelease];
		
}


-(void)createModel{
	self.model = self.commentsModel;
}

-(CommentsModel*)commentsModel{
	if (!_commentsModel) {
		_commentsModel = [[CommentsModel alloc] initWithBookID:self.oid];
	}
	return _commentsModel;
}

-(void)didSelectObject:(id)object atIndexPath:(NSIndexPath *)indexPath{
	[super didSelectObject:object atIndexPath:indexPath];
	
}



-(BOOL)shouldLoadMore{
	if ([[self.commentsModel allComments] lastObject]  ) {
		if ([[[self.commentsModel allComments] lastObject] isKindOfClass:[TTTableMoreButton class]]) {
			return YES;
		}
		else {
			return NO;
		}
	}
	return NO;
}


-(void)didLoadModel:(BOOL)firstTime{
	[super didLoadModel:firstTime];
	BookListDataSource *bookListDataSource;
	switch (self.stripTabBar.selectedTabIndex) {
		case AllComment:
			bookListDataSource = (BookListDataSource*)[BookListDataSource  dataSourceWithItems:[self.commentsModel allComments]];
			bookListDataSource.model = self.commentsModel;
			self.dataSource  = bookListDataSource;
			break;
		case GoodComment:
			bookListDataSource = (BookListDataSource*)[BookListDataSource  dataSourceWithItems:[self.commentsModel goodComments]];
			bookListDataSource.model = self.commentsModel;
			self.dataSource  = bookListDataSource;
			break;
		case BadComment:
			bookListDataSource = (BookListDataSource*)[BookListDataSource  dataSourceWithItems:[self.commentsModel badComments]];
			bookListDataSource.model = self.commentsModel;
			self.dataSource  = bookListDataSource;
			break;
		default:
			break;
	}
}

-(void)viewWillAppear:(BOOL)animated{
	[super viewWillAppear:NO];
	// add backgroundView first;
	
	 
	_backgroundView = [[[TTView alloc] initWithFrame:CGRectMake(0, BKNavigatorBarHeight,
																	   CGRectGetWidth(BKScreenBoundsWithoutBar()),
																	   CGRectGetHeight(BKScreenBoundsWithoutBar()) - BKNavigatorBarHeight )] autorelease];
	//backgroundView.backgroundColor = [UIColor clearColor];
	_backgroundView.style = TTSTYLE(popupViewStyle);
	[self.view addSubview:_backgroundView];
	[self.view sendSubviewToBack:_backgroundView];
	
	[self.view addSubview:self.stripTabBar];
	if (self.backBtn.superview != self.navigatorBar) {
		[self.navigatorBar addToNavigatorView:self.backBtn align:NavigationViewAlignLeft];
		
	}
	[self.view addSubview:self.navigatorBar];
}

-(void)viewDidAppear:(BOOL)animated{
	[super viewWillAppear:NO];
}

-(void)viewWillDisappear:(BOOL)animated{
	[super viewWillDisappear:NO];
}

-(void)viewDidDisappear:(BOOL)animated{
	[super viewWillDisappear:NO];
}
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark TTTabBarDelegate
- (void)tabBar:(TTTabBar*)tabBar tabSelected:(NSInteger)selectedIndex{
	if (tabBar == self.stripTabBar) {
		[self refresh];
	}
}

-(NSDictionary*)configTest{
	return [NSDictionary dictionaryWithObjectsAndKeys:SelectTabIndex,[NSNumber numberWithInt:(int)DefaultSelectTabIndex],nil];
}

-(NSString*)createTableViewName:(CommentType)type{
	NSArray *commentStripBars = commentStripBarItems();
	NSString *commentTableViewTxt = [commentStripBars objectAtIndex:(int)type] ;
	commentTableViewTxt = [commentTableViewTxt stringByReplacingCharactersInRange:NSMakeRange(0,1) withString:[[commentTableViewTxt substringToIndex:1] lowercaseString]];
	return commentTableViewTxt;
}


-(void)start{
	
	NSDictionary *config = [self configTest];
	NSMutableArray *items = [NSMutableArray array];
	TTTabItem *item = nil;
	NSArray *commentStripBars = commentStripBarItems();
	NSUInteger i, count = [commentStripBars count];
	for (i = 0; i < count; i++) {
		NSString *itemName = [commentStripBars objectAtIndex:i];
		item = [[[TTTabItem alloc] initWithTitle:BCLocalizedString(itemName,@"the name of every strip tab")] autorelease];
		[items addObject:item];
	}
	self.stripTabBar.tabItems = (NSArray*)items;
	[self.view addSubview:self.stripTabBar];
	CommentType type = [[config objectForKey:SelectTabIndex] intValue];
	NSString *tableViewName =[self createTableViewName:type];

	TTTableView *selectedTableView =  [self performSelector:NSSelectorFromString([tableViewName stringByAppendingString:TableViewSuffix])];
	selectedTableView.dataSource = [self performSelector:NSSelectorFromString([tableViewName stringByAppendingString:TableViewDataSourceSuffix])];
	selectedTableView.delegate = [[[BCTableViewDelegate alloc] initWithController:self] autorelease];
	[self.view addSubview:selectedTableView];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (UITableView*)tableView {
	UITableView *table = [super tableView];
	table.frame = CGRectMake(BKContentLargeMargin,   BKNavigatorBarHeight+StripBarHeight+BKContentHugeMargin, 	 
							 CGRectGetWidth(self.view.frame) - 2 * BKContentLargeMargin, 
							 CGRectGetHeight(self.view.frame)-BKNavigatorBarHeight-StripBarHeight -BKContentHugeMargin - BKContentLargeMargin);
	table.backgroundColor = [UIColor clearColor];
	return table;
}




-(void)dealloc{

	TT_RELEASE_SAFELY(_oid);
	TT_RELEASE_SAFELY(_stripTabBar);
	TT_RELEASE_SAFELY(_commentsModel);
	[super dealloc];
}



-(TTTabStrip*)stripTabBar{
	if (!_stripTabBar) {
		kTabMargin = BKContentLargeMargin;
		_stripTabBar = [[StripTabBar alloc] initWithFrame:StripBarFrame];
		_stripTabBar.backgroundColor = [UIColor clearColor];
		
		
		_stripTabBar.style = nil;//TTSTYLE(segmentBar);
		_stripTabBar.delegate = self;
		
		_stripTabBar.selectedTabIndex = 0;
		
		
	}
	return _stripTabBar;
}



@end
