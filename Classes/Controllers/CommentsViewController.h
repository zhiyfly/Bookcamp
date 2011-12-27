//
//  CommentViewController.h
//  bookcamp
//
//  Created by waiwai on 12/19/10.
//  Copyright 2010 __iwaiwai__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseTableViewController.h"
#import "CommentsModel.h"
@interface CommentsViewController : BaseTableViewController <TTTabDelegate>{
	NSNumber *_oid;
	CommentsModel *_commentsModel;
	


	TTTabStrip *_stripTabBar;

}
@property (nonatomic, retain, readonly) CommentsModel *commentsModel;
@property (nonatomic, retain)NSNumber *oid;



@property (nonatomic, retain) TTTabStrip *stripTabBar;

- (void)tabBar:(TTTabBar*)tabBar tabSelected:(NSInteger)selectedIndex;

@end
