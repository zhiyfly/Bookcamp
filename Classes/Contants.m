//
//  Contants.m
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













