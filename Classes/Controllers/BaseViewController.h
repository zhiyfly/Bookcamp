//
//  BaseViewController.h
//  bookcamp
//
//  Created by lin waiwai on 1/29/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface BaseViewController : TTModelViewController {
	NavigatorBar *_navigatorBar;
	TTButton *_backBtn;
}
@property (nonatomic, retain, readonly) TTButton* backBtn;
@property (nonatomic, retain, readonly ) NavigatorBar *navigatorBar;
@end
