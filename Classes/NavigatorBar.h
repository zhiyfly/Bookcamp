//
//  DetailToolbar.h
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


typedef enum {
    NavigationViewAlignLeft,
    NavigationViewAlignCenter,
    NavigationViewAlignRight,
} NavigationViewAlignment;


@interface NavigatorBar : TTView {
	
	NSMutableArray *_navigatorLeftViews;
	NSMutableArray *_navigatorRightViews;
	NSMutableArray *_navigatorCenterViews;
	int leftPadding ;
	int rightPadding ;
	int itemGap;
}

@property (nonatomic) int leftPadding ;
@property (nonatomic) int rightPadding ;
@property (nonatomic) int itemGap;
@property (nonatomic, retain, readonly) NSMutableArray *navigatorLeftViews;
@property (nonatomic, retain, readonly) NSMutableArray *navigatorRightViews;
@property (nonatomic, retain, readonly) NSMutableArray *navigatorCenterViews;

-(void)addToNavigatorView:(UIView*)aView align:(NavigationViewAlignment)align;


@end
