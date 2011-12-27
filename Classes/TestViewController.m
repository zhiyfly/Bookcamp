//
//  TestViewController.m
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

#import "TestViewController.h"

@interface TestView : UIView
{
	
}



@end

@implementation TestView

-(void)drawRect:(CGRect)rect{
	// Create an oval shape to draw.
	UIBezierPath*    aPath = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, 200, 200)];
//
//	// Get the CGPathRef and create a mutable version.
	CGPathRef cgPath = aPath.CGPath;
//	CGMutablePathRef  mutablePath = CGPathCreateMutableCopy(cgPath);
//	
//	// Modify the path and assign it back to the UIBezierPath object
//	CGPathAddEllipseInRect(mutablePath, NULL, CGRectMake(50, 50, 200, 200));
//	aPath.CGPath = mutablePath;
//	
//	// Release both the mutable copy of the path.
//	CGPathRelease(mutablePath);
//	
//    // Set the render colors
//    [[UIColor blackColor] setStroke];
//    [[UIColor redColor] setFill];
//	
//    CGContextRef aRef = UIGraphicsGetCurrentContext();
//	
//    // If you have content to draw after the shape,
//    // save the current state before changing the transform
//    //CGContextSaveGState(aRef);
//	
//    // Adjust the view's origin temporarily. The oval is
//    // now drawn relative to the new origin point.
//    //CGContextTranslateCTM(aRef, 50, 50);
//	
//    // Adjust the drawing options as needed.
//    aPath.lineWidth = 5;
//	
//    // Fill the path before stroking it so that the fill
//    // color does not obscure the stroked line.
//    [aPath fill];
//    [aPath stroke];
	
    // Restore the graphics state before drawing any other content.
    //CGContextRestoreGState(aRef);
	
	
	CGContextRef ctx = UIGraphicsGetCurrentContext();
	CGContextSaveGState(ctx);
	CGContextAddPath(ctx, cgPath);

	[[UIColor whiteColor] setFill];
	
	// Due to a bug in OS versions 3.2 and 4.0, the shadow appears upside-down. It pains me to
	// write this, but a lot of research has failed to turn up a way to detect the flipped shadow
	// programmatically

	
	CGContextSetShadowWithColor(ctx, CGSizeMake(1, 1), 29,
								RGBACOLOR(0,0,0,0.5).CGColor);
	CGContextEOFillPath(ctx);
	//CGContextRestoreGState(ctx);
}

@end




@implementation TestViewController


-(void)viewDidLoad{
	[super viewDidLoad];
//	TestView *testView = [[[TestView alloc] initWithFrame:CGRectMake(10, 10, 300, 300)] autorelease];
//	testView.backgroundColor = [UIColor whiteColor];
//	[self.view addSubview:testView];
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
	
	HUD.labelText = BCLocalizedString(@"unable connect", @"unable connect") ;
	
	[HUD show:YES];
}



@end
