//
//  NewTopicView.m
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

#import "LoopScrollView.h"

@interface LoopScrollView () <UIScrollViewDelegate>

@property (nonatomic, retain) NSMutableArray *pageViews;
@property (nonatomic, retain) UIScrollView *scrollView;
@property (nonatomic, readonly) NSUInteger currentPageIndex;
@property (nonatomic) NSUInteger physicalPageIndex;

- (NSUInteger)physicalPageForPage:(NSUInteger)page;
- (NSUInteger)pageForPhysicalPage:(NSUInteger)physicalPage;

@end

@implementation LoopScrollView

@synthesize pageViews=_pageViews, scrollView=_scrollView, currentPageIndex=_currentPageIndex ,delegate;
@synthesize previewEnabled  = _previewEnabled ;

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        // Initialization code
		[self init];
    }
    return self;
}

- (NSUInteger)numberOfPages {
	NSAssert(delegate,@"no delegae");
	NSAssert([delegate conformsToProtocol:@protocol(LoopScrollViewDataSource)],@"doesn't implement the datasource");
	return	[delegate numberOfPages];
}

-(void)startLayout{
	// view did load

	//self.backgroundColor = [UIColor darkTextColor];
	self.pageViews = [NSMutableArray array];
	// to save time and memory, we won't load the page views immediately
	NSUInteger numberOfPhysicalPages = (_pageLoopEnabled ? 3 * [self numberOfPages] : [self numberOfPages]);
	for (NSUInteger i = 0; i < numberOfPhysicalPages; ++i)
		[self.pageViews addObject:[NSNull null]];
	
	// view will appear
	[self layoutPages];
	[self currentPageIndexDidChange];
	[self setPhysicalPageIndex:[self physicalPageForPage:_currentPageIndex]];
}


-(void)setDelegate:(id<LoopScrollViewDataSource>)aDelegate{
	if (aDelegate) {
		delegate = aDelegate;
		[self startLayout];
	} else {
		self.pageViews = [NSMutableArray array];
		[self.scrollView removeAllSubviews];
	}

	
}

- (UIView *)loadViewForPage:(NSUInteger)pageIndex{
	return [delegate loadViewForPage:pageIndex scrollView:self.scrollView];
}

-(id)initWithFrame:(CGRect)frame pageSize:(CGSize)pageSize{
	if (self = [super initWithFrame:frame]) {
		[self init];
		[self setPageSize:pageSize];
	}
	return self;
}

-(void)init{
	// load Scroll View
	
	_pageLoopEnabled = YES;
	_previewEnabled = NO;
	_pageSize = CGSizeMake(CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds));
	
	self.scrollView = [[[TapDetectingScrollView alloc] initWithFrame:self.bounds] autorelease];
	self.scrollView.delegate = self;
	self.scrollView.pagingEnabled = YES;
	self.scrollView.showsHorizontalScrollIndicator = NO;
	self.scrollView.showsVerticalScrollIndicator = NO;
	self.scrollView.directionalLockEnabled = YES;

	[self addSubview:self.scrollView];
}

-(void)setPageSize:(CGSize)aSize{
	_pageSize = aSize;
}



-(void)setPreviewEnabled:(BOOL)enabled {
	_previewEnabled = enabled;
	if (enabled) {
		self.scrollView.clipsToBounds = NO;
	} else {
		self.scrollView.clipsToBounds = YES;
	}
	self.scrollView.frame = CGRectMake((CGRectGetWidth(self.bounds) - _pageSize.width) / 2,
									   (CGRectGetHeight(self.bounds) - _pageSize.height) / 2, _pageSize.width, _pageSize.height);

}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
	// If the point is not inside the scrollview, ie, in the preview areas we need to return
	// the scrollview here for interaction to work

	if (!CGRectContainsPoint(self.scrollView.frame, point) && point.y > 0 && self.previewEnabled) {
		return self.scrollView;
	}
	
	// If the point is inside the scrollview there's no reason to mess with the event.
	// This allows interaction to be handled by the active subview just like any scrollview
	return [super hitTest:point	withEvent:event];
}

- (CGRect)alignView:(UIView *)view forPage:(NSUInteger)pageIndex inRect:(CGRect)rect {
// have no need to resize webview
//	UIView *pageView = (UIView *)[view viewWithTag:pageViewTag];
//	CGSize pageSize = pageView.frame.size;
//	CGFloat ratioX = rect.size.width / pageSize.width, ratioY = rect.size.height / pageSize.height;
//	CGSize size = (ratioX < ratioY ?
//				   CGSizeMake(rect.size.width, ratioX * pageSize.height) :
//				   CGSizeMake(ratioY * pageSize.width, rect.size.height));
//	pageView.frame = CGRectMake((rect.size.width - size.width) / 2, (rect.size.height - size.height) / 2, size.width, size.height);	
//	
	return rect;
}

- (UIView *)viewForPhysicalPage:(NSUInteger)pageIndex {
	NSParameterAssert(pageIndex >= 0);
	NSParameterAssert(pageIndex < [self.pageViews count]);
	UIView *pageView = nil;
	if ([self.pageViews objectAtIndex:pageIndex] == [NSNull null]) {
		pageView = [self loadViewForPage:pageIndex];
		[self.pageViews replaceObjectAtIndex:pageIndex withObject:pageView];
		[self.scrollView addSubview:pageView];
	} else {
		pageView = [self.pageViews objectAtIndex:pageIndex];
	}
	return pageView;
}

- (CGSize)pageSize {
	return self.scrollView.frame.size;
}

- (BOOL)isPhysicalPageLoaded:(NSUInteger)pageIndex {
	return [self.pageViews objectAtIndex:pageIndex] != [NSNull null];
}

- (void)layoutPhysicalPage:(NSUInteger)pageIndex {
	UIView *pageView = [self viewForPhysicalPage:pageIndex];
	CGSize pageSize = [self pageSize];
	pageView.frame = [self alignView:pageView forPage:[self pageForPhysicalPage:pageIndex] inRect:CGRectMake(pageIndex * pageSize.width, 0, pageSize.width, pageSize.height)];
}

//当前图片索引
- (void)currentPageIndexDidChange {
	[self layoutPhysicalPage:_currentPhysicalPageIndex];
	if (_currentPhysicalPageIndex+1 < [self.pageViews count]){
		[self layoutPhysicalPage:_currentPhysicalPageIndex+1];
		
		
	}
	if (_currentPhysicalPageIndex > 0){
		[self layoutPhysicalPage:_currentPhysicalPageIndex-1];

	}
}

- (void)layoutPages {
	CGSize pageSize = [self pageSize];
	self.scrollView.contentSize = CGSizeMake([self.pageViews count] * pageSize.width, pageSize.height);
	// move all visible pages to their places, because otherwise they may overlap
	for (NSUInteger pageIndex = 0; pageIndex < [self.pageViews count]; ++pageIndex)
		if ([self isPhysicalPageLoaded:pageIndex])
			[self layoutPhysicalPage:pageIndex];
}


- (NSUInteger)physicalPageIndex {
	CGSize pageSize = [self pageSize];
	return (self.scrollView.contentOffset.x + pageSize.width / 2) / pageSize.width;
}

- (void)setPhysicalPageIndex:(NSUInteger)newIndex {
	self.scrollView.contentOffset = CGPointMake(newIndex * [self pageSize].width, 0);
}

- (NSUInteger)physicalPageForPage:(NSUInteger)page {
	//for loop notify
	NSAssert([delegate conformsToProtocol:@protocol(LoopScrollViewDataSource)],@"doesn't implement the datasource");
	if ([delegate respondsToSelector:@selector(pageDidChanger:)]) {
		[delegate pageDidChanger:(_pageLoopEnabled ? page + [self numberOfPages] : page)];
	}
	NSParameterAssert(page < [self numberOfPages]);
	return (_pageLoopEnabled ? page + [self numberOfPages] : page);
}

- (NSUInteger)pageForPhysicalPage:(NSUInteger)physicalPage {
	if (_pageLoopEnabled) {
		NSParameterAssert(physicalPage < 3 * [self numberOfPages]);
		return physicalPage % [self numberOfPages];
	} else {
		NSParameterAssert(physicalPage < [self numberOfPages]);
		return physicalPage;
	}
}

-(void)swiptTo:(DIRECTION)direction{
	CGSize pageSize = [self pageSize];
	_currentPhysicalPageIndex = direction == LEFT ? self.physicalPageIndex+1 : self.physicalPageIndex-1;
	_currentPageIndex = [self pageForPhysicalPage:_currentPhysicalPageIndex];
	[self currentPageIndexDidChange];
    CGRect f = 	CGRectMake(self.scrollView.contentOffset.x + pageSize.width * (direction == LEFT ? 1 : -1) , 0, pageSize.width, pageSize.height) ;
	[self.scrollView scrollRectToVisible:f animated:YES];
	[self scrollViewDidEndDecelerating:self.scrollView];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
	
	if (_rotationInProgress)
		return; // UIScrollView layoutSubviews code adjusts contentOffset, breaking our logic
	NSUInteger newPageIndex = self.physicalPageIndex;
	if (newPageIndex == _currentPhysicalPageIndex) return;
	_currentPhysicalPageIndex = newPageIndex;
	_currentPageIndex = [self pageForPhysicalPage:_currentPhysicalPageIndex];
	[self currentPageIndexDidChange];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
	NSUInteger physicalPage = self.physicalPageIndex;
	NSUInteger properPage = [self physicalPageForPage:[self pageForPhysicalPage:physicalPage]];
	if (physicalPage != properPage)
		self.physicalPageIndex = properPage;
}

/*
 * when orientation is changed ,the func below regarding orientation all should be invoked by controll
 */

/*
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;//(interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}
*/

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
	_rotationInProgress = YES;
	
	// hide other page views because they may overlap the current page during animation
	for (NSUInteger pageIndex = 0; pageIndex < [self.pageViews count]; ++pageIndex)
		if ([self isPhysicalPageLoaded:pageIndex])
			[self viewForPhysicalPage:pageIndex].hidden = (pageIndex != _currentPhysicalPageIndex);
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
	// resize and reposition the page view, but use the current contentOffset as page origin
	// (note that the scrollview has already been resized by the time this method is called)
	CGSize pageSize = [self pageSize];
	UIView *pageView = [self viewForPhysicalPage:_currentPhysicalPageIndex];
	pageView.frame = [self alignView:pageView forPage:_currentPageIndex inRect:CGRectMake(self.scrollView.contentOffset.x, 0, pageSize.width, pageSize.height)];
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
	// adjust frames according to the new page size - this does not cause any visible changes
	[self layoutPages];
	self.physicalPageIndex = _currentPhysicalPageIndex;
	
	// unhide
	for (NSUInteger pageIndex = 0; pageIndex < [self.pageViews count]; ++pageIndex)
		if ([self isPhysicalPageLoaded:pageIndex])
			[self viewForPhysicalPage:pageIndex].hidden = NO;
	
	_rotationInProgress = NO;
}

// orientation func end

// this should be called by controller when it did receive a memory warning
-(void)saveMemory{
	if (self.pageViews) {
		// unload non-visible pages in case the memory is scarse
		for (NSUInteger pageIndex = 0; pageIndex < [self.pageViews count]; ++pageIndex)
			if (pageIndex < _currentPhysicalPageIndex-1 || pageIndex > _currentPhysicalPageIndex+1)
				if ([self isPhysicalPageLoaded:pageIndex]) {
					UIView *pageView = [self.pageViews objectAtIndex:pageIndex];
					[self.pageViews replaceObjectAtIndex:pageIndex withObject:[NSNull null]];
					[pageView removeFromSuperview];

				}
	}
}



- (void)dealloc {
	self.pageViews = nil;
	self.scrollView = nil;
	//[self viewDidUnload];
    [super dealloc];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/



@end
