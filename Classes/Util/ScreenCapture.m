//
//  ScreenCapture.m
//  iFrame
//
//  Created by lin waiwai on 4/13/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ScreenCapture.h"

#import "UIImage+Resize.h"
//[[[UIDevice currentDevice] systemVersion] intValue] >= 4 && [[UIScreen mainScreen] scale] == 2.0 

@implementation ScreenCapture

+(ScreenCapture*)capture{
	return [[[ScreenCapture alloc] init] autorelease];
}

-(UIImage *)captureView:(UIView *)view inRect:(CGRect)rect{

    return 	[[self captureView:view] croppedImage:rect];
	

}





- (UIImage *)captureView:(UIView *)view {
	
	CGRect savedFrame ;
	if ([view isKindOfClass:[UIScrollView class]]) {
		savedFrame  = view.frame;
		CGSize aSize = [(UIScrollView*)view contentSize];
		view.frame =  CGRectMake(0, 0, aSize.width,aSize.height ) ;
	}
	CGRect screenRect = view.bounds;
	
	if (NULL != UIGraphicsBeginImageContextWithOptions)
        UIGraphicsBeginImageContextWithOptions(screenRect.size, NO, 2);
    else
        UIGraphicsBeginImageContext(screenRect.size);
	
	
    CGContextRef ctx = UIGraphicsGetCurrentContext();
	CGContextSaveGState(ctx);
	
    [[UIColor clearColor] set];
    CGContextFillRect(ctx, screenRect);
	
    [view.layer renderInContext:ctx];
	CGContextRestoreGState(ctx);
	
	//CGImageRef imageRef = CGImageCreateWithImageInRect([UIGraphicsGetImageFromCurrentImageContext() CGImage], rect);
	//   UIImage *newImage =  [UIImage imageWithCGImage:imageRef scale:2 orientation:UIImageOrientationUp];//
	
	//CGImageRelease(imageRef);
	UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();	
	
	
    UIGraphicsEndImageContext();
	if ([view isKindOfClass:[UIScrollView class]]) {
		view.frame = savedFrame;
		
	}
	return newImage;
	
 
}


@end
