//
//  ExpressModule.h
//  bookcamp
//
//  Created by waiwai on 12/19/10.
//  Copyright 2010 __iwaiwai__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Module.h"
#import "BCTableViewVarHeightDelegate.h"
#import "FictionExpressModel.h"
#import "NofictionExpressModel.h"
#import "FictionRankingModel.h"
#import "NofictionRankingModel.h"
@interface ExpressModule_backup : Module <TTTabDelegate> {
	BCSegment *_categorySegmentedBar;
	BCSegment *_subCategoryBar;
	TTTableView *_bookTableView;
	
	//data source
	BookListDataSource *_latestFictionBookTableViewDataSource;
	BookListDataSource *_latestNonfictionBookTableViewDataSource;
	BookListDataSource *_rankingFictionBookTableViewDataSource;
	BookListDataSource *_rankingNonfictionBookTableViewDataSource;
	
	BCTableViewVarHeightDelegate *_tableViewVarHeightDelegate;
	
	// model
	FictionExpressModel *_fictionExpressModel;
	NofictionExpressModel *_nofictionExpressModel;
	FictionRankingModel *_fictionRankingModel;
	NofictionRankingModel *_nofictionRankingModel;
	
}

@property (nonatomic, retain) BookListDataSource *latestFictionBookTableViewDataSource;
@property (nonatomic, retain) BookListDataSource *latestNonfictionBookTableViewDataSource;
@property (nonatomic, retain) BookListDataSource *rankingFictionBookTableViewDataSource;
@property (nonatomic, retain) BookListDataSource *rankingNonfictionBookTableViewDataSource;

// model
@property (nonatomic, retain, readonly) FictionExpressModel *fictionExpressModel;
@property (nonatomic, retain, readonly) NofictionExpressModel *nofictionExpressModel;
@property (nonatomic, retain, readonly) FictionRankingModel *fictionRankingModel;
@property (nonatomic, retain, readonly) NofictionRankingModel *nofictionRankingModel;

@property (nonatomic, retain, readonly) BCTableViewVarHeightDelegate *tableViewVarHeightDelegate;
@property (nonatomic, retain, readonly) TTTableView *bookTableView;
@property (nonatomic, retain, readonly) BCSegment *subCategoryBar;
@property (nonatomic, retain, readonly) BCSegment *categorySegmentedBar;

@end
