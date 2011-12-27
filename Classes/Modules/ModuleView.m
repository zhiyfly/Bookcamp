//
//  ModuleView.m
//  bookcamp
//
//  Created by lin waiwai on 1/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ModuleView.h"


@implementation ModuleView
@synthesize contentView = _contentView;
@synthesize navigatorBarHidden = _navigatorBarHidden;
@synthesize navigatorBar = _navigatorBar;

-(id)initWithFrame:(CGRect)frame{
	if (self = [super initWithFrame:frame]) {
		_navigatorBarHidden = NO;
	}
	return self;
}

-(TTView*)contentView{
	if (!_contentView) {
		_contentView = [[TTView alloc] init];
		_contentView.frame = _navigatorBarHidden ? CGRectMake(0, 0,
													 CGRectGetWidth(self.contentView.frame), 
													 CGRectGetHeight(self.contentView.frame)+BKNavigatorBarHeight)
		:CGRectMake(0, BKNavigatorBarHeight, 
					CGRectGetWidth(self.bounds),
					CGRectGetHeight(self.bounds)-BKNavigatorBarHeight);
		[self addSubview:_contentView];
	}
	return _contentView;
}

-(CGRect)rectForNavigator{
	return BKNavigatorBarFrame();
}

-(NavigatorBar*)navigatorBar{
	if (!_navigatorBar){
		_navigatorBar = [[NavigatorBar alloc] initWithFrame:[self rectForNavigator]];
		_navigatorBar.leftPadding = 10;
		_navigatorBar.rightPadding = 10;
		_navigatorBar.itemGap = 5;
		_navigatorBar.backgroundColor = [UIColor whiteColor];
		[self setNavigatorBarHidden:NO];
		[self addSubview:_navigatorBar];
		
	}
	return _navigatorBar;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (BOOL)shouldOpenURL:(NSString*)URL {
	return YES;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)didBeginDragging {
	[self hideMenu:YES];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)didEndDragging {
}



-(void)setNavigatorBarHidden:(BOOL)hidden{
	if (_navigatorBarHidden == hidden ) {
		return ;
	}
	self.contentView.frame = hidden ? CGRectMake(0, 0,
												CGRectGetWidth(self.contentView.frame), 
												CGRectGetHeight(self.contentView.frame)+BKNavigatorBarHeight)
									:CGRectMake(0, BKNavigatorBarHeight, 
												CGRectGetWidth(self.contentView.frame),
												CGRectGetHeight(self.contentView.frame)-BKNavigatorBarHeight);

}



-(void)dealloc{
	TT_RELEASE_SAFELY (_navigatorBar);
	TT_RELEASE_SAFELY (_contentView);
	[super dealloc];
}


@end
