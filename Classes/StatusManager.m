//
//  StatusManager.m
//
// Created by lin waiwai(jiansihun@foxmail.com) on 1/19/11.
// Copyright 2011 __waiwai__. All rights reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
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
