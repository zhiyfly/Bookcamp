//
//  NewTopicView.h
//  ireader
//
//  Created by lin waiwai on 10/15/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
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
