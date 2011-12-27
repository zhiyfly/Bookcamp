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
#import "LoopScrollView.h"
#import "BookSummaryView.h"

typedef enum {
	FictionExpress = 0,
	NofictionExpress,
	FictionRanking,
	NofictionRanking
} BookType;

@interface ExpressModule : Module <TTTabDelegate,LoopScrollViewDataSource> {
	UISlider *_categorySegmentedBar;
	BCSegment *_subCategoryBar;

	
	LoopScrollView *_scrollView;
	
	BookSummaryView *_infoView;
	NSMutableDictionary *_data;
	
	BookType type;
	
	BCTableViewVarHeightDelegate *_tableViewVarHeightDelegate;
	
	// model
	FictionExpressModel *_fictionExpressModel;
	NofictionExpressModel *_nofictionExpressModel;
	FictionRankingModel *_fictionRankingModel;
	NofictionRankingModel *_nofictionRankingModel;
	
	
	
}

@property (nonatomic, retain) LoopScrollView *scrollView;
@property (nonatomic, retain) TTView *infoView;
@property (nonatomic, retain) NSMutableDictionary *data;
// model
@property (nonatomic, retain, readonly) FictionExpressModel *fictionExpressModel;
@property (nonatomic, retain, readonly) NofictionExpressModel *nofictionExpressModel;
@property (nonatomic, retain, readonly) FictionRankingModel *fictionRankingModel;
@property (nonatomic, retain, readonly) NofictionRankingModel *nofictionRankingModel;

@property (nonatomic, retain, readonly) BCTableViewVarHeightDelegate *tableViewVarHeightDelegate;
@property (nonatomic, retain, readonly) TTTableView *bookTableView;
@property (nonatomic, retain, readonly) BCSegment *subCategoryBar;
@property (nonatomic, retain, readonly) UISlider *categorySegmentedBar;

@end
