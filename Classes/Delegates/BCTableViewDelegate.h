//
//  BCTableViewDelegate.h
//  bookcamp
//
//  Created by lin waiwai on 1/30/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BCTableViewControllerDelegate

- (BOOL)shouldOpenURL:(NSString*)URL ;
- (id<TTModel>)model ;
- (void)didSelectObject:(id)object atIndexPath:(NSIndexPath*)indexPath;
- (void)didBeginDragging;
- (void)didEndDragging ;
- (void)hideMenu:(BOOL)animated;

@optional

- (UIView*)menuView;

@end



@interface BCTableViewDelegate : NSObject <UITableViewDelegate>  {
	id<BCTableViewControllerDelegate>  _controller;
	NSMutableDictionary*    _headers;
}

- (id)initWithController:(id<BCTableViewControllerDelegate>)controller;

@property (nonatomic, readonly) id<BCTableViewControllerDelegate> controller;


@end
