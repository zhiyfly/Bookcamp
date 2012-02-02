//
//  NewTopicView.h
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

#import <UIKit/UIKit.h>
#import "TapDetectingScrollView.h"

#define pageViewTag 3

typedef enum  {
	LEFT,
	RIGHT,
} DIRECTION;

@protocol LoopScrollViewDataSource

- (NSUInteger)numberOfPages ;
- (UIView *)loadViewForPage:(NSUInteger)pageIndex scrollView:(UIScrollView*)scrollView;
- (void)pageDidChanger:(NSUInteger)pageIndex;

@end


@interface LoopScrollView : TTView{
	id <LoopScrollViewDataSource> delegate;
	NSMutableArray *_pageViews;
	TapDetectingScrollView *_scrollView;
	NSUInteger _currentPageIndex;
	NSUInteger _currentPhysicalPageIndex;
	BOOL _pageLoopEnabled;
	BOOL _rotationInProgress;
	BOOL _previewEnabled ;
	CGSize _pageSize;
}

@property (nonatomic) BOOL previewEnabled ;
@property (nonatomic, retain) id <LoopScrollViewDataSource> delegate;

@end
