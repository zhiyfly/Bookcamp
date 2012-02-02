//
//  StatusManager.h
//  bookcamp
//
//  Created by waiwai on 12/15/10.
//  Copyright 2010 __iwaiwai__. All rights reserved.
//


#import <Foundation/Foundation.h>
typedef enum {
    /** Opacity animation */
    StatusBarAnimationPush,
} StatusBarAnimation;

@interface StatusManager : NSObject {
	//UIView container;
	dispatch_queue_t tipQueue;
	
	TTView *_wrapper;

	TTLabel *tipLabel;
	
	UIWindow *_window;
}

@property (nonatomic, retain) UIWindow *window;
@property (nonatomic, retain,readonly) TTView *wrapper;
@property (nonatomic,retain) TTLabel *tipLabel;

@end
