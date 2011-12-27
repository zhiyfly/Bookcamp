//
//  Contants.m
//  bookcamp
//
//  Created by waiwai on 12/19/10.
//  Copyright 2010 __iwaiwai__. All rights reserved.
//

#import "Contants.h"

#ifdef BCDebug 

#else

#endif
const int StripBarHeight = 31;

const int BKNavigatorBarHeight = 40;
const int BKNavigatorBarHeightThree = 40;
const int BKNavigatorBarHeightTwo = 30;

static NSString *modules[] = {@"Express",@"History",@"Scan",@"Favorite",@"More"};
NSString* moduleNameForTab(int moduleIndex){
	return modules[moduleIndex];
}

CGRect BKNavigatorBarFrame(){
	return CGRectMake(0, 0, CGRectGetWidth(BKScreenBounds()), BKNavigatorBarHeight);
}

CGRect BKNavigatorBarFrameTwo(){
	return CGRectMake(0, 0, CGRectGetWidth(BKScreenBounds()), BKNavigatorBarHeightTwo);
}

CGRect BKNavigatorBarFrameThree(){
	return CGRectMake(0, 0, CGRectGetWidth(BKScreenBounds()), BKNavigatorBarHeightThree);
}


CGRect BKScreenBounds (){
	return [UIScreen mainScreen].bounds;
}

CGRect BKScreenBoundsWithoutBar(){
	return TTRectContract(BKScreenBounds(), 0, 20);
}

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark CommentViewController
const int RatingViewWidth = 105;
const int RatingViewHeight = 20;




const int CommentAuthorInfoBarHeight = 60;

const int	BKContentSmallMargin = 6;
const int   BKContentSpacing     = 8;
const int   BKContentMargin      = 10;
const int	BKContentLargeMargin = 14;
const int	BKContentHugeMargin = 18;
const int   BKContentHPadding    = 10;
const int   BKContentVPadding    = 10;


typedef enum {
	ITEMALIGNLEFT,
	ITEMALIGNRIGHT,
	ITEMALIGNCENTER,
} ITEMALIGNMENT;


NSString * const FavoritedObjectContextDidSaveNotification = @"FavoritedObjectContextDidSaveNotification";
NSString * const HistoriedObjectContextDidSaveNotification = @"HistoriedObjectContextDidSaveNotification";













