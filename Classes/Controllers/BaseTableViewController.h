//
//  BaseTableViewController.h
//  bookcamp
//
//  Created by lin waiwai on 2/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface BaseTableViewController : TTTableViewController {
	NavigatorBar *_navigatorBar;
	TTButton *_backBtn;
}
@property (nonatomic, retain, readonly) TTButton* backBtn;
@property (nonatomic, retain, readonly ) NavigatorBar *navigatorBar;
@end
