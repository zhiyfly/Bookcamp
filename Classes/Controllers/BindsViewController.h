//
//  BindsViewController.h
//  BengXin
//
//  Created by lin waiwai on 1/22/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTableViewController.h"
#import "BXTableSubtitleItem.h"

#define connectedSite [NSArray arrayWithObjects:@"kaixin",@"renren",@"sina",@"douban",nil]

#define SnsCount 1
const NSString * connectedSiteStr[] = {@"开心网",@"人人网",@"新浪微博",@"豆瓣网"};

@interface BindsViewController : BaseTableViewController <UIActionSheetDelegate>{
	NSInteger siteBindStatus[1];
	BOOL inReBinding;
}



@end
