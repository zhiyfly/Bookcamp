//
//  Contants.h
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
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Test
//#define BCDebug 1
#define enableUmeng

#error fill the admob id
#define MY_BANNER_UNIT_ID @""

#ifdef BCDebug
#define BCNSLog(...) NSLog(__VA_ARGS__)
#else
#define BCNSLog(...) 
#endif

extern const int BKNavigatorBarHeight;
extern const int BKNavigatorBarHeightTwo;
extern const int BKNavigatorBarHeightThree;
extern const int StripBarHeight;
typedef enum {
	Express = 0,
	History ,
	Scan ,
	Favorite ,
	More ,
} rootModule;

NSString* moduleNameForTab(int moduleIndex) ;
CGRect BKNavigatorBarFrame();
CGRect BKNavigatorBarFrameTwo();
CGRect BKNavigatorBarFrameThree();
CGRect BKScreenBounds ();
CGRect BKScreenBoundsWithoutBar();
#define TabBarHeight 40
#define upcaseFirstLetter(__STR) [__STR stringByReplacingCharactersInRange:NSMakeRange(0,1) withString:[[__STR substringToIndex:1] uppercaseString]]

#define RootModuleFrame CGRectMake(0, BKNavigatorBarHeight, CGRectGetWidth(BKScreenBounds()), CGRectGetHeight(BKScreenBounds())-BKNavigatorBarHeight)
#define RootModuleBounds CGRectMake(0, 0, CGRectGetWidth(BKScreenBoundsWithoutBar()), CGRectGetHeight(BKScreenBoundsWithoutBar())-BKNavigatorBarHeight)
#define RootModuleWidth CGRectGetWidth(BKScreenBounds())
#define StripBarFrame CGRectMake(0, BKNavigatorBarHeight + BKContentMargin, CGRectGetWidth(BKScreenBounds()), StripBarHeight)
#define ModuleContentFrame CGRectMake(0, StripBarHeight, CGRectGetWidth(BKScreenBounds()), CGRectGetHeight(BKScreenBoundsWithoutBar())-BKNavigatorBarHeight-StripBarHeight)

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark CommentViewController

typedef enum{
	AllComment = 0,
	GoodComment,
	BadComment,
} CommentType;

#define commentStripBarItems() [NSArray arrayWithObjects:@"AllComment",@"GoodComment",@"BadComment",nil];

#define SelectTabIndex @"selectTabIndex"
#define DefaultSelectTabIndex AllComment
#define TableViewSuffix @"TableView"
#define TableViewDataSourceSuffix @"TableViewDataSource"

extern const int	RatingViewWidth ;
extern const int	RatingViewHeight;
#define MAX_RATING 10

extern const int	CommentAuthorInfoBarHeight;

#define RatingHidden -1

#define BKAuthorThumbWidth 50
#define BKAuthorThumbHeight 50

extern const int	BKContentSmallMargin;


extern const int	BKContentSmallMargin ;
extern const int	BKContentSpacing    ;
extern const int	BKContentLargeMargin;
extern const int	BKContentHugeMargin;
extern const int	BKContentMargin     ;
extern const int	BKContentHPadding   ;
extern const int	BKContentVPadding   ;

extern NSString * const FavoritedObjectContextDidSaveNotification ;
extern NSString * const HistoriedObjectContextDidSaveNotification ;

#define BKContentDescFormat [@"%@ %@/%@ " stringByAppendingString:BCLocalizedString(@"Useful",@"the suffix string of comment content 's desc")]


/*  Book Thumb  */
#define BKDefaultBookThumbWidth  120
#define BKDefaultBookThumbHeight  167

/* Link Button */
#define BKDefaultLinkButtonWidth  80
#define BKDefaultLinkButtonHeight  30

#define BKCommentViewControllerURL @"tt://comment"
#define BKParityViewControllerURL @"tt://parity"

/* BookView */
#pragma mark BookHeadView

#define BKBookHeadViewHeight 168
#define TogglePullDown @"bundle://TogglePullDown.png"


#pragma mark BookInfoView

#define BKToggleIconStyle @"toggleIconStyle:"

#define BookSummary @"BookSummary"
#define BookAuthor @"BookAuthor"
#define BookPrice @"BookPrice"
#define BookPageCount @"BookPageCount"
#define BookPublisher @"BookPublisher"

#define BookInfo [NSArray arrayWithObjects:BookSummary,BookAuthor, \
						BookPrice,BookPageCount,BookPublisher,nil]


#define ModuleSuffix @"Module"



#define BCContentSmallMargin 6


typedef enum {
	Initing,
	Finish,
	Loading,
	Fail,
} ObjectStatusFlag;

#define GoldenRatio 0.618

#define kOAuthConsumerKey				@"1908874965"		//REPLACE ME
#define kOAuthConsumerSecret			@"565f11da0861333fa3961af2f67c38d0"		//REPLACE ME


#define QQAppKey @"801058898"
#define QQAppSecret @"e9d1fac7cd6391a7e2e8a1997e67be76"

