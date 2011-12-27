//
//  Factory.m
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

#import "Factory.h"

static ModelLocator *sharedInstance = nil;

@implementation Factory

-(void)dealloc {
	[sharedInstance release];
	[super dealloc];
}

+ (Factory*)sharedInstance
{
    @synchronized(self)
    {
        if (sharedInstance == nil)
			sharedInstance = [[self alloc] init];
	}
    return sharedInstance;
}

-(NSString*) makeDoubanApiKey{
	NSUInteger count = [DoubanApiKeys count];
 	return [DoubanApiKeys objectAtIndex: (NSUInteger)(arc4random() % count)];
}

-(TTURLRequest*)createRequestWithURL:(NSString*)URL delegate:(id)delegate{
	
}




-(void *)triggerWarning:(NSString*)text{
	id navigationController = [[[TTNavigator navigator] visibleViewController] navigationController];
	MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:[navigationController view]];
	HUD.style = TTSTYLE(progressHUDStyle);
	
	// The sample image is based on the work by www.pixelpressicons.com, http://creativecommons.org/licenses/by/2.5/ca/
	// Make the customViews 37 by 37 pixels for best results (those are the bounds of the build-in progress indicators)
	HUD.customView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"warning.png"]] autorelease];
	
	// Set custom view mode
	HUD.mode = MBProgressHUDModeCustomView;
	
	HUD.minShowTime = 2;
    // Add HUD to screen
    [[navigationController view] addSubview:HUD];
	
    // Regisete for HUD callbacks so we can remove it from the window at the right time
    HUD.delegate = [[UIApplication sharedApplication] delegate];
	
	HUD.labelText = text;
	
	[HUD show:YES];
	[HUD hide:YES];
}


@end
