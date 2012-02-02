//
//  CSVerticalLayout.m
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
#import "CSVerticalLayout.h"


@implementation CSVerticalLayout
@synthesize padding = _padding;
@synthesize spacing = _spacing;
@synthesize indentSize = _indentSize;

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Public

///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGSize)layoutSubviews:(NSArray*)subviews forView:(UIView*)view {
	CGFloat x = _padding.left, y = _padding.top;
	CGFloat maxY = 0, lastWidth = 0;
	CGFloat maxHeight = view.bounds.size.height - _padding.bottom;
	for (UIView* subview in subviews) {
		if (y + subview.frame.size.height > maxHeight) {
			y = _padding.top;
			x += subview.frame.size.width + _spacing;
		}
		if (x < _indentSize.width && _indentSize.height > _padding.top && y==_padding.top) {
			y += _indentSize.height - _padding.top;
		}
		subview.frame = CGRectMake(x, y, subview.frame.size.width, subview.frame.size.height);
		y += subview.frame.size.height + _spacing;
		if (y > maxY) {
			maxY = y;
		}
		lastWidth = subview.frame.size.width;
	}
	return CGSizeMake(maxY+_padding.top + _padding.bottom+lastWidth, y+_padding.top+ _padding.bottom);
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (BOOL)addSubview:(UIView*)subview toView:(UIView*)view {
	UIView *lastView = [view.subviews lastObject];
	CGFloat x,y;
	
	CGFloat maxY = 0, lastWidth = 0;
	CGFloat maxWidth = view.bounds.size.width -  _padding.right;
	CGFloat maxHeight = view.bounds.size.height - _padding.bottom;
	
	if (lastView) {
		x = CGRectGetMinX(lastView.frame);
		y = CGRectGetMaxY(lastView.frame) + _spacing;
	}else {
		x = _padding.left;
		y = MAX(_padding.top, _indentSize.height);
	}
	if (y  + subview.frame.size.height > maxHeight && x +_spacing + subview.frame.size.width > maxWidth) {
		return NO;
	}
	if (y  + subview.frame.size.height > maxHeight && x + _spacing + subview.frame.size.width < maxWidth ) {
		//换行 
		y = _padding.top;
		if (lastView) {
			x = CGRectGetMaxX(lastView.frame)+ _spacing;
		}
	}
	subview.frame = CGRectMake(x, y, subview.frame.size.width, subview.frame.size.height);
	[view addSubview:subview];
	return  YES;
}




@end
