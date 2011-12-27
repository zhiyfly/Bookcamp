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
@implementation ExpressModule

@synthesize categorySegmentedBar = _categorySegmentedBar;
@synthesize subCategoryBar = _subCategoryBar;
@synthesize tableViewVarHeightDelegate = _tableViewVarHeightDelegate;

//model
@synthesize fictionExpressModel = _fictionExpressModel;
@synthesize nofictionExpressModel = _nofictionExpressModel;
@synthesize fictionRankingModel = _fictionRankingModel;
@synthesize nofictionRankingModel = _nofictionRankingModel;



@synthesize scrollView = _scrollView;
@synthesize data = _data;
@synthesize infoView = _infoView;


///////////////////////////////////////////////////////////////////////////////////////////////////
-(void)dealloc{
	TT_RELEASE_SAFELY(_data);
	TT_RELEASE_SAFELY(_scrollView);
	TT_RELEASE_SAFELY(_infoView);
	TT_RELEASE_SAFELY(_categorySegmentedBar);
	TT_RELEASE_SAFELY(_subCategoryBar);
	TT_RELEASE_SAFELY(_tableViewVarHeightDelegate);
	
	//model
	TT_RELEASE_SAFELY(_fictionExpressModel);
	TT_RELEASE_SAFELY(_nofictionExpressModel);
	TT_RELEASE_SAFELY(_fictionRankingModel);
	TT_RELEASE_SAFELY(_nofictionRankingModel);
	[super dealloc];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}

-(NSString*)typeToString:(BookType)aType{
	NSArray *objects = [NSArray arrayWithObjects:@"FictionExpress",@"NofictionExpress",@"FictionRanking",@"NofictionRanking",nil];
	if (aType < [objects count]) {
		return [objects objectAtIndex:aType];
	}
	return nil;
}


- (void)pageDidChanger:(NSUInteger)pageIndex{
	NSInteger index = pageIndex % [self numberOfPages];
	NSArray *items = [self.data objectForKey:[self typeToString:type]];
	BookObject *book =  [items objectAtIndex:index];
	[self.infoView setObject:book];
	
}



-(NSMutableDictionary*)data{
	if (!_data) {
		_data  = [[NSMutableDictionary alloc] init];
	}
	return _data;
}



-(void)didLoadModel:(BOOL)firstTime{
	if ([self.data objectForKey:[self typeToString:type]]) {
		self.scrollView.delegate = self;
	}	
}

-(void)coverDidSelected:(TTButton*)btn{
	NSInteger index = (NSInteger)[self.scrollView currentPageIndex] % [self numberOfPages];
	NSArray *items = [self.data objectForKey:[self typeToString:type]];
	BookObject *book = (BookObject*)[items objectAtIndex:index] ;
	TTOpenURL([@"tt://book/" stringByAppendingString:[book.oid stringValue]]);
}

- (CGPathRef)renderTestCurl:(UIView*)imgView {
	CGFloat _blur = 10;
	CGFloat w = CGRectGetWidth(imgView.frame);
	CGFloat h = CGRectGetHeight(imgView.frame);
	
	UIBezierPath*    aPath = [UIBezierPath bezierPath];
	
	
	// Set the starting point of the shape.
	[aPath moveToPoint:CGPointMake(_blur/2, 0.0)];	
	// Draw the lines
	[aPath addLineToPoint:CGPointMake(0, h - _blur)];
	[aPath addLineToPoint:CGPointMake(_blur/2, h )];
	[aPath addLineToPoint:CGPointMake(w - _blur/2 , h)];
	[aPath addLineToPoint:CGPointMake(w  , h - _blur)];	
	[aPath addLineToPoint:CGPointMake(w - _blur/2, 0)];
	
	[aPath closePath];
	return aPath.CGPath;
}

- (NSUInteger)numberOfPages {
	NSUInteger count = 0;
	count = [[self.data objectForKey:[self typeToString:type]] count];
	return count;
}

- (UIView *)loadViewForPage:(NSUInteger)pageIndex scrollView:(UIScrollView*)scrollView{
	
	NSInteger index = pageIndex % [self numberOfPages];
	NSArray *items = [self.data objectForKey:[self typeToString:type]];
	UIView *container = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(scrollView.frame), CGRectGetHeight(scrollView.frame))] autorelease];
	TTThumbView *imageView = [[[TTThumbView alloc] initWithFrame:CGRectMake((container.width - BKDefaultBookThumbWidth) / 2, 
																			(container.height - BKDefaultBookThumbHeight) / 2, 
																			BKDefaultBookThumbWidth, 
																			BKDefaultBookThumbHeight)] autorelease];
	imageView.thumbURL = [(BookObject*)[items objectAtIndex:index] thumbURL];
	imageView.backgroundColor = [UIColor clearColor];
	[imageView setStylesWithSelector:@"bookThumbStyle:"];
	
	imageView.layer.shadowColor = [UIColor grayColor].CGColor;
	imageView.layer.shadowOpacity = 0.7f;
	imageView.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
	imageView.layer.shadowRadius = 2.f;
	imageView.layer.masksToBounds = NO;
	
	//imgView.layer.shadowPath = [self renderRect:imgView];
	imageView.layer.shadowPath = [self renderTestCurl:imageView];

	[imageView addTarget:self action:@selector(coverDidSelected:) forControlEvents:UIControlEventTouchUpInside];
	[container addSubview:imageView];
	return container;
	
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
	type = FictionExpress;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
-(id)initWithConfig:(NSDictionary*)config{
	if (self = [super initWithConfig:config]) {
		[self.view.navigatorBar setStyle:TTSTYLE(navigatorBarStyle)];
		self.view.navigatorBarHidden = NO;
		
		[self.view.navigatorBar addToNavigatorView:self.categorySegmentedBar align:NavigationViewAlignRight];
		[self.view.contentView addSubview:self.subCategoryBar];
		[self.view.contentView addSubview:self.scrollView];
		[self.view.contentView addSubview:self.infoView];
		//[self.view.contentView addSubview:self.bookTableView];
		
		
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
//	for (BookObject*book in books) {	
//		NSString *caption = [book.authors objectAtIndex:0];
//		if ([book.authors count] > 1) {
//			caption = [caption stringByAppendingString:BCLocalizedString(@"etc", @"etc")];
//		}
//		NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
//		[dateFormatter setDateFormat:@"yyyy-MM"];
//		[dateFormatter setLocale:[NSLocale currentLocale]];
//		NSString* dateStr = [dateFormatter stringFromDate:book.pubdate];
//		
//		caption = [NSString stringWithFormat:@"%@/%@/%@", caption, book.publisher, dateStr];
//		[bookItems addObject:[BookCellItem itemWithTitle:book.bookName caption:caption
//												  rating:book.averageRate imageURL:book.thumbURL  
//													 URL:[@"tt://book/" stringByAppendingString:[book.oid stringValue]]]];
//	}
	
	if ([keyPath isEqual:@"latestFictionBooks"]) {
		type = FictionExpress;
	
    } else if ([keyPath isEqual:@"latestNonfictionBooks"]) {
		type = NofictionExpress;
	} else if ([keyPath isEqual:@"rankingFictionBooks"]) {
		type = FictionRanking;

	} else if ([keyPath isEqual:@"rankingNonfictionBooks"]) {
		type = NofictionRanking;

	}
	[self.data setObject:books forKey:[self typeToString:type]];
	self.scrollView.delegate = self;
}



//0101
static NSUInteger tabSelected = 5;
static BOOL changeFlag = NO;

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark TTTabDelegate
- (void)tabBar:(id*)tabBar tabSelected:(NSInteger)selectedIndex{
	if ((tabBar == self.subCategoryBar) && !changeFlag) {
		NSUInteger f = 3 << ((int)(1-self.categorySegmentedBar.value) * 2);
		tabSelected = ((( ~ (f & tabSelected)) & f )| ( ~ f & tabSelected)) & 15;
	} if (tabBar == self.categorySegmentedBar) {
		NSUInteger d = (((tabSelected >> ( (int)(1-self.categorySegmentedBar.value) * 2)) & 3) - 1);
		//avoid the subbar to change
		changeFlag = YES;
		self.subCategoryBar.selectedTabIndex = d ;
		changeFlag = NO;
	} 
 	type = (int)(1-self.categorySegmentedBar.value)*2 + self.subCategoryBar.selectedTabIndex ;
	if (!changeFlag) {
		switch (type) {
			case FictionExpress:
				if (self.model != self.fictionExpressModel) {
					self.model = self.fictionExpressModel;

				}
				break;
			case NofictionExpress:
				if (self.model != self.nofictionExpressModel ) {
					self.model = self.nofictionExpressModel;
				}
				break;
			case FictionRanking:
				if (self.model != self.fictionRankingModel) {
					self.model = self.fictionRankingModel;
					
				}
				break;
			case NofictionRanking:
				if (self.model != self.nofictionRankingModel) {
					self.model = self.nofictionRankingModel;
				}
				break;
			default:
				NSAssert(FALSE, @"shoule not be here");
				break;
		}
		if (![self.data objectForKey:[self typeToString:type]]) {
			self.scrollView.delegate = nil;
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
		
		_subCategoryBar = [[TTTabBar alloc] initWithFrame:CGRectMake(0, 
																	 0, CGRectGetWidth(self.view.frame), subCategoryBarHeight)];
		_subCategoryBar.backgroundColor = [UIColor whiteColor];
		

		_subCategoryBar.style = TTSTYLE(segmentBar);
		_subCategoryBar.tabStyle = @"segment:";
		_subCategoryBar.delegate = self;
		
		_subCategoryBar.tabItems = [NSArray arrayWithObjects:
										  [[[TTTabItem alloc] initWithTitle:BCLocalizedString(@"Fiction", @"Fiction")] autorelease],
										  [[[TTTabItem alloc] initWithTitle:BCLocalizedString(@"NonFiction",@"NonFiction")] autorelease],
										  nil];
		_subCategoryBar.selectedTabIndex = 0;
		//_subCategoryBar.styleSuffix = @"subCategory";
		//[_subCategoryBar sizeToFit];

	}
	return _subCategoryBar;
}


- (void) sliderAction: (UISlider *) sender
{
	if (sender.value < 0.5) {
		[sender setValue:0 animated: YES]; 
		[self tabBar:sender tabSelected:(1-sender.value)];
	} else {
		[sender setValue:1  animated: YES];
		[self tabBar:sender tabSelected:(1-sender.value)];
	}
}

///////////////////////////////////////////////////////////////////////////////////////////////////
-(UISlider*)categorySegmentedBar{
	if (!_categorySegmentedBar) {
		CGRect frame = CGRectMake(10.0, 50.0, 116, 28);
		CGRect thumb = CGRectMake(0.0, 0.0, 28, 28);
		_categorySegmentedBar = [[UISlider alloc] initWithFrame:frame];
		[_categorySegmentedBar addTarget:self action:@selector(sliderAction:) forControlEvents:UIControlEventTouchUpInside];
		// in case the parent view draws with a custom color or gradient, use a transparent color
		_categorySegmentedBar.backgroundColor = [UIColor clearColor];	
		[_categorySegmentedBar setThumbImage:TTSTYLEVAR(sliderSegmentThumbImage) forState:UIControlStateNormal];
		[_categorySegmentedBar setMinimumTrackImage:TTSTYLEVAR(sliderSegmentLeftImage) forState:UIControlStateNormal];
		[_categorySegmentedBar setMaximumTrackImage:TTSTYLEVAR(sliderSegmentRightImage) forState:UIControlStateNormal];
		[_categorySegmentedBar thumbRectForBounds: thumb trackRect: frame value: _categorySegmentedBar.value];
		_categorySegmentedBar.minimumValue = 0.0;
		_categorySegmentedBar.maximumValue = 1.0;
		_categorySegmentedBar.continuous = YES;
		_categorySegmentedBar.value = 1.0;

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

#define BooShelfHeight 195

-(LoopScrollView*)scrollView{
	if (!_scrollView) {
		//CGRectMake(0, 0,,
		//				CGRectGetHeight(self.view.contentView.frame)-subCategoryBarHeight)];
		_scrollView = [[LoopScrollView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.contentView.frame), 
																	   BooShelfHeight) 
												   pageSize:CGSizeMake(((CGRectGetWidth(self.view.contentView.frame) - BKDefaultBookThumbWidth * 2 / 3)  - BKDefaultBookThumbWidth) / 2 + BKDefaultBookThumbWidth, BooShelfHeight)];
		_scrollView.style = TTSTYLE(bookSelfStyle);
		_scrollView.previewEnabled = YES;
	}
	return _scrollView;
}


-(BookSummaryView*)infoView{
	if (!_infoView) {
		//CGRectMake(0, 0,,
		//				CGRectGetHeight(self.view.contentView.frame)-subCategoryBarHeight)];
		_infoView = [[BookSummaryView alloc] initWithFrame:CGRectMake(0,  BooShelfHeight, CGRectGetWidth(self.view.contentView.frame), 
															 (CGRectGetHeight(self.view.contentView.frame)-subCategoryBarHeight) - BooShelfHeight) ];
		_infoView.style = TTSTYLE(infoViewStyle);

	}
	return _infoView;
}




@end
