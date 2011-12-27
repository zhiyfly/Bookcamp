//
//  ModuleView.h
//  bookcamp
//
//  Created by lin waiwai on 1/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ModuleView : TTView {
	BOOL _navigatorBarHidden;
	TTView *_contentView;
	NavigatorBar *_navigatorBar;
}

@property (nonatomic, retain, readonly ) NavigatorBar *navigatorBar;
@property (nonatomic, assign) BOOL navigatorBarHidden;
@property (nonatomic, retain) TTView * contentView;
@end
