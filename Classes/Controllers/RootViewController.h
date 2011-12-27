//
//  RootViewController.h
//  bookcamp
//
//  Created by waiwai on 12/11/10.
//  Copyright 2010 __iwaiwai__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BKTabBar.h"
@interface RootViewController : TTViewController <TTTabDelegate>{
	BKTabBar			*_tabBar;
	NSMutableArray		*_tabURLs;
	NSMutableDictionary *_modules;
}
@property (nonatomic, retain, readonly) NSMutableDictionary *modules;
@property (nonatomic, retain) BKTabBar *tabBar;
@property (nonatomic, retain) NSMutableArray * tabURLs;
-(void)selectedTab:(NSString*)tab;
@end
