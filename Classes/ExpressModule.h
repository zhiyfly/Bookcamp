//
//  ExpressModule.h
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
