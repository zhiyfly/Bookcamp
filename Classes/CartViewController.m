//
//  CartViewController.m
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

#import "CartViewController.h"
#import "ParityModel.h"

#define CartHeaderViewHeight 40
#define CartFooterViewHeight CartHeaderViewHeight

@implementation CartViewController
@synthesize parityModel = _parityModel;
@synthesize oid = _oid;
@synthesize bookPriceLabel = _bookPriceLabel;
@synthesize headerView = _headerView;
@synthesize book = _book;

///////////////////////////////////////////////////////////////////////////////////////////////////
-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
	if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {

	}	
	return self;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
-(void)dealloc{
	TT_RELEASE_SAFELY(_book);
	TT_RELEASE_SAFELY(_parityModel);
	[super dealloc];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)observeValueForKeyPath:(NSString *)keyPath
					  ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context
{
    if ([keyPath isEqual:@"bookStatus"]) {
  		ObjectStatusFlag bookStatus =  (ObjectStatusFlag)[[change objectForKey:NSKeyValueChangeNewKey] intValue];
		if ( bookStatus == Finish ){
			self.oid = self.book.oid;
			if (self.oid){
				self.model = self.parityModel;
			}
			[object removeObserver:self
							  forKeyPath:@"bookStatus"];
		}
    }
}

///////////////////////////////////////////////////////////////////////////////////////////////////
-(id)initWithBookID:(NSString*)oid{
	if (self = [super initWithNibName:nil bundle:nil]) {
		// add backgroundView first;
				[self.backBtn setStylesWithSelector:@"backBtnCloseStyle:"];
		TTView *backgroundView = [[[TTView alloc] initWithFrame:CGRectMake(0, BKNavigatorBarHeight,
																		   CGRectGetWidth(BKScreenBoundsWithoutBar()),
																		   CGRectGetHeight(BKScreenBoundsWithoutBar()) - BKNavigatorBarHeight )] autorelease];
		//backgroundView.backgroundColor = [UIColor clearColor];
		backgroundView.style = TTSTYLE(popupViewStyle);
		[self.view addSubview:backgroundView];
		[self.view sendSubviewToBack:backgroundView];
		
		
		self.oid = [NSNumber numberWithInt: [oid intValue]];
		[self.navigatorBar addToNavigatorView:self.backBtn align:NavigationViewAlignLeft];
	}
	return self;
}



///////////////////////////////////////////////////////////////////////////////////////////////////
-(id)initWithISBN10:(NSString*)isbnNum{
	if (self = [super initWithNibName:nil bundle:nil]) {
				[self.backBtn setStylesWithSelector:@"backBtnCloseStyle:"];
		_book =  [[BookObject alloc] initWithISBN10:[NSNumber numberWithLongLong:[isbnNum longLongValue]]];
		[self.book addObserver:self  forKeyPath:@"bookStatus"
				  options:(NSKeyValueObservingOptionNew |
						   NSKeyValueObservingOptionOld)
				  context:NULL];
		[self.book sync];
		[self.navigatorBar addToNavigatorView:self.backBtn align:NavigationViewAlignLeft];
	}
	return self;
}




-(id)initWithISBN13:(NSString*)isbnNum{
	if (self = [super initWithNibName:nil bundle:nil]) {
				[self.backBtn setStylesWithSelector:@"backBtnCloseStyle:"];
		_book =  [[BookObject alloc] initWithISBN13:[NSNumber numberWithLongLong:[isbnNum longLongValue]]] ;
		[self.book addObserver:self forKeyPath:@"bookStatus"
				  options:(NSKeyValueObservingOptionNew |
						   NSKeyValueObservingOptionOld)
				  context:NULL];
		[self.book sync];
		[self.navigatorBar addToNavigatorView:self.backBtn align:NavigationViewAlignLeft];
	}
	return self;

}

///////////////////////////////////////////////////////////////////////////////////////////////////
-(void)createModel{
	if (self.oid){
		self.model = self.parityModel;
	}
}

///////////////////////////////////////////////////////////////////////////////////////////////////
-(TTView*)headerView {
	if (!_headerView) {
		_headerView = [[TTView alloc] initWithFrame:CGRectMake(0, 0, RootModuleWidth, CartHeaderViewHeight)];
	}
	return _headerView;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
-(TTView*)footerView{
	if (!_footerView) {
		_footerView = [[TTView alloc] initWithFrame:CGRectMake(0, 0, RootModuleWidth, CartFooterViewHeight)];
		TTLabel *footerLable = [[[TTLabel alloc] initWithFrame:CGRectMake(BCContentSmallMargin, BCContentSmallMargin, 0, 0)] autorelease];
		footerLable.text = BCLocalizedString(@"cart footer parity warning", @"cart footer parity warning");
		footerLable.style =  TTSTYLE(priceLabelStyle);
		footerLable.backgroundColor = [UIColor clearColor];
		[footerLable sizeToFit];
		[_footerView addSubview:footerLable];
		_footerView.backgroundColor = [UIColor clearColor];
		self.tableView.tableFooterView = _footerView;
	}
	return _footerView;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
-(TTLabel*)bookPriceLabel{
	if (!_bookPriceLabel) {

		_bookPriceLabel = [[[TTLabel alloc] init] autorelease];
		_bookPriceLabel.style =  TTSTYLE(priceLabelStyle);
		_bookPriceLabel.backgroundColor = [UIColor clearColor];
		[_bookPriceLabel sizeToFit];
		[self.view addSubview:_bookPriceLabel];
	}
	return _bookPriceLabel;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
-(void)didLoadModel:(BOOL)firstTime{ 
	[super didLoadModel:firstTime];
	//self.tableView.tableHeaderView =
	if (self.parityModel.priceLabelText) {
		self.bookPriceLabel.text = [NSString stringWithFormat:@"%@", self.parityModel.priceLabelText];
		[_bookPriceLabel sizeToFit];
		self.bookPriceLabel.frame = CGRectMake((self.view.width - _bookPriceLabel.width - BKContentLargeMargin),
											   BKNavigatorBarHeight + BKContentSmallMargin,
											   _bookPriceLabel.width, _bookPriceLabel.height);
		//self.tableView.tableHeaderView = self.headerView;
	}
	if (self.parityModel.parityItems) {
		NSMutableArray *items = [NSMutableArray arrayWithCapacity:[self.parityModel.parityItems count]];
		//there cause some danger ,because of the data type
		//[items addObject:[TableParityItem itemWithText:BCLocalizedString(@"straightLink", @"straightLink") 
		//										 price:BCLocalizedString(@"discountPrice", @"discountPrice") 
		//										saveon:BCLocalizedString(@"saveon", @"saveon") ]];
		// find the lowest item
		NSUInteger i = 0;
		NSUInteger best = 0;
		for (NSDictionary *item in self.parityModel.parityItems) {
			CGFloat price = CGFLOAT_MAX;
			if ([[item objectForKey:@"price"] floatValue] > price) {
				price = [[item objectForKey:@"price"] floatValue];
				best = i;
			} 
			i++;
		}
		NSUInteger j = 0;
		for (NSDictionary *item in self.parityModel.parityItems) {
			NSString *lowestIcon = @"";
			NSString *format = @"<span>     <span><a href=\"%@\">%@</a>";
			if (j == best) {
				format = @"<img src=\"bundle://lowestPrice.png\"  width=\"20\" /><a href=\"%@\">%@</a>";
			}
			NSString *shop = [NSString stringWithFormat:format,
							  [[item objectForKey:@"href"] stringByReplacingOccurrencesOfString:@"&" withString:@"&amp;"],
							  [item objectForKey:@"shopname"]];
			[items addObject:[TableParityItem itemWithText:shop price:[item objectForKey:@"price"]
													saveon:[item objectForKey:@"saveon"]]];
			j++;
		}
		self.dataSource  = [BookListDataSource dataSourceWithItems:items];
		self.footerView;
	}
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

///////////////////////////////////////////////////////////////////////////////////////////////////
-(ParityModel*)parityModel{
	if (!_parityModel) {
		_parityModel = [[ParityModel alloc] initWithBookID:self.oid];
	}
	return _parityModel;
}





@end
