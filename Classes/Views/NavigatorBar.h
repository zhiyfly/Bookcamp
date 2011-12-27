//
//  DetailToolbar.h
//  ireader
//
//  Created by lin waiwai on 6/14/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
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
