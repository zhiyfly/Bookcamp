//
//  CSFlowLayout.m
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
#import "CSFlowLayout.h"


///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
@implementation CSFlowLayout

@synthesize padding = _padding;

@synthesize HSpace = _HSpace;
@synthesize VSpace = _VSpace;


///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Public

///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGSize)layoutSubviews:(NSArray*)subviews forView:(UIView*)view {
	CGFloat x = _padding.left, y = _padding.top;
	CGFloat maxX = 0, lastHeight = 0;
	CGFloat maxWidth = view.frame.size.width - _padding.left - _padding.right;
	UIView *lastSubview;
	for (UIView* subview in subviews) {
		if (x + subview.frame.size.width > maxWidth) {
			x = _padding.left;
			NSAssert(lastSubview, @"the container can't tolerence it");
			y += lastSubview.frame.size.height + _VSpace;
		}
		
		subview.frame = CGRectMake(x, y, subview.frame.size.width, subview.frame.size.height);
		x += subview.frame.size.width + _HSpace;
		if (x > maxX) {
			maxX = x;
		}
		lastHeight = subview.frame.size.height;
		lastSubview = subview;
	}
	
	return CGSizeMake(maxX+_padding.right, y+lastHeight+_padding.bottom);
}




@end