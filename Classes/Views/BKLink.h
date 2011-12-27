//
//  BKLink.h
//  bookcamp
//
//  Created by waiwai on 12/29/10.
//  Copyright 2010 __iwaiwai__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface BKLink : TTButton {
	TTURLAction*  _URLAction;
}
/**
 * The URL that will be loaded when the control is touched. This is a wrapper around URLAction;
 * setting this property is equivalent to setting a URLAction with animated set to YES.
 */
@property (nonatomic, copy) id URL;

/**
 * The TTURLAction that will be opened.
 */
@property (nonatomic, retain) TTURLAction* URLAction;

@end
