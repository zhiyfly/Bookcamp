//
//  StatusManager.m
//  bookcamp
//
//  Created by waiwai on 12/15/10.
//  Copyright 2010 __iwaiwai__. All rights reserved.
//

#import "StatusManager.h"
static StatusManager *sharedInstance = nil;

@implementation StatusManager
@synthesize tipLabel = _tipLabel;
@synthesize wrapper = _wrapper;
@synthesize window = _window;

+ (StatusManager*)sharedInstance
{
    @synchronized(self)
    {
        if (sharedInstance == nil)
			sharedInstance = [[self alloc] init];
	}
    return sharedInstance;
}

-(void)setWindow:(UIWindow *)aWindow{
	if (!_wrapper) {
		
	}
}

 

-(UIView*)wrapper{
	if (!_wrapper) {
		_wrapper = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.window.frame), 20)];
	}
	return _wrapper;
}



-(UILabel*)tipLabel{
	if (!_tipLabel) {
		_tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 20)];
	}
	
	return _tipLabel;
}

-(UIWindow*)window{
	if (!_window) {
		_window = [[UIApplication sharedApplication] window];
	}
	return _window;
}

-(void)addHelpTip:(NSString*)tip{
	tipQueue =  dispatch_queue_create ("com.waiwai.statustips",NULL);
	dispatch_time_t delay = dispatch_time(DISPATCH_TIME_NOW, 2 * NSEC_PER_SEC);
	dispatch_after(delay, tipQueue, ^{
		self.tipLabel.text = tip;
    });
}

- (void)showUsingAnimation:(BOOL)animated {

    if (animated) {

    }
    

    // Fade in
	
}





@end
