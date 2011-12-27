/*
//
//  BookShadowStyle.m
//  bookcamp
//
//  Created by lin waiwai on 8/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "BookShadowStyle.h"

// Style
#import "Three20Style/TTStyleContext.h"
#import "Three20Style/TTShape.h"

// Core
#import "Three20Core/NSStringAdditions.h"
#import "Three20Core/TTCorePreprocessorMacros.h"
#import "Three20Core/TTGlobalCoreRects.h"



@implementation BookShadowStyle

@synthesize color   = _color;
@synthesize blur    = _blur;


///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithNext:(TTStyle*)next {
	if (self = [super initWithNext:next]) {

	}
	
	return self;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)dealloc {
	TT_RELEASE_SAFELY(_color);
	
	[super dealloc];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Class public


///////////////////////////////////////////////////////////////////////////////////////////////////
+ (TTShadowStyle*)styleWithColor:(UIColor*)color blur:(CGFloat)blur 
                            next:(TTStyle*)next {
	TTShadowStyle* style = [[[self alloc] initWithNext:next] autorelease];
	style.color = color;
	style.blur = blur;
	return style;
}



-(CGImageRef)createMask:(UIImage*)temp
{
	CGImageRef ref=temp.CGImage;
	int mWidth=CGImageGetWidth(ref);
	int mHeight=CGImageGetHeight(ref);
	int count=mWidth*mHeight*4;
	void *bufferdata=malloc(count);
	
	CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
	CGBitmapInfo bitmapInfo = kCGBitmapByteOrderDefault;
	CGColorRenderingIntent renderingIntent = kCGRenderingIntentDefault;
	
	CGContextRef cgctx = CGBitmapContextCreate (bufferdata,mWidth,mHeight, 8,mWidth*4, colorSpaceRef, kCGImageAlphaPremultipliedFirst); 
	
	CGRect rect = {0,0,mWidth,mHeight};
	CGContextDrawImage(cgctx, rect, ref); 
	bufferdata = CGBitmapContextGetData (cgctx);
	
	CGDataProviderRef provider = CGDataProviderCreateWithData(NULL, bufferdata, mWidth*mHeight*4, NULL);
	CGImageRef savedimageref = CGImageCreate(mWidth,mHeight, 8, 32, mWidth*4, colorSpaceRef, bitmapInfo,provider , NULL, NO, renderingIntent);
	CFRelease(colorSpaceRef);
	return savedimageref;
}
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark TTStyle


/////////////////////////////////////////////////////////////////////////////////////////////////
//- (void)draw:(TTStyleContext*)context {
//	CGFloat blurSize = round(_blur / 2);
//	UIEdgeInsets inset = UIEdgeInsetsMake(blurSize/2, blurSize, blurSize/2, blurSize);
//	
//	
//	CGFloat w = CGRectGetWidth(context.frame);
//	CGFloat h = CGRectGetHeight(context.frame);
//	context.frame = TTRectInset(context.frame, inset);
//	context.contentFrame = TTRectInset(context.contentFrame, inset);
//	CGContextRef ctx = UIGraphicsGetCurrentContext();
//	CGContextSaveGState(ctx);
//	
//
//	UIGraphicsBeginImageContext(CGSizeMake(w, h) );
//	
//
//	
//	CGContextRef ctxTmp = UIGraphicsGetCurrentContext();	
//	
//	CGContextSetFillColorWithColor(ctxTmp, [[UIColor whiteColor] CGColor]);
//	CGContextFillRect(ctxTmp, CGRectMake(0, 0, w, h));
//	
//	UIBezierPath*    aPath = [UIBezierPath bezierPath];
//	
//	// Set the starting point of the shape.
//	[aPath moveToPoint:CGPointMake(_blur/2, 0.0)];	
//	// Draw the lines
//	[aPath addLineToPoint:CGPointMake(0, h - _blur)];
//	[aPath addLineToPoint:CGPointMake(_blur/2, h )];
//	[aPath addLineToPoint:CGPointMake(w - _blur/2 , h)];
//	[aPath addLineToPoint:CGPointMake(w  , h - _blur)];	
//	[aPath addLineToPoint:CGPointMake(w - _blur/2, 0)];
//	[aPath closePath];
//	
//	CGContextBeginPath(ctxTmp);
//	CGContextAddPath(ctxTmp,aPath.CGPath);	
//	CGContextClosePath(ctxTmp);
//	CGContextClip(ctxTmp);
//	
//	CGGradientRef myGradient;
//	CGColorSpaceRef myColorspace;
//	size_t num_locations = 2;
//	CGFloat locations[2] = { 0.0, 1.0 };
//	CGFloat components[8] = { .5, 0.5, 0.5, 1.0,  // Start color
//		0.6, 0.6, 0.6, 1.0 }; // End color
//	
//	myColorspace = CGColorSpaceCreateDeviceRGB();;
//	myGradient = CGGradientCreateWithColorComponents (myColorspace, components,
//													  locations, num_locations);
//    // Adjust the drawing options as needed.
//	CGPoint myStartPoint, myEndPoint;
//	CGFloat myStartRadius, myEndRadius;
//	myStartPoint.x = w/2;
//	myStartPoint.y = h/2;
//	
//	myEndPoint.x = w;
//	myEndPoint.y = h;
//	
//	myStartRadius = 0;
//	myEndRadius = 360;
//	
//	
//	CGContextDrawRadialGradient (ctxTmp, myGradient, myStartPoint,
//								 myStartRadius, myEndPoint, myEndRadius,
//								 kCGGradientDrawsAfterEndLocation);
//	
//	UIImage *image  =	UIGraphicsGetImageFromCurrentImageContext();
//	
//	
//	
//	UIGraphicsEndImageContext();
//
//	[context.shape addToPath:context.frame];
// 
//
//	CGImageRef ref1=[self createMask:[image gaussianBlur:2]];
//	const float colorMasking[6] = {0.0,0, 0.0, 0.0, 0.0, 0.0};
//	CGImageRef New=CGImageCreateWithMaskingColors(ref1, colorMasking);
//	UIImage *resultedimage=[UIImage imageWithCGImage:New];
//	
//	[[image gaussianBlur:3]  drawAtPoint:CGPointMake(0, 0)];
//	
//
//	CGColorSpaceRelease(myColorspace);
//	CGGradientRelease(myGradient);
//	
//	[self.next draw:context];
//	
//	CGContextRestoreGState(ctx);
//}

- (void)draw:(TTStyleContext*)context {
	CGFloat blurSize = round(_blur / 2);
	UIEdgeInsets inset = UIEdgeInsetsMake(blurSize/2, blurSize, blurSize/2, blurSize);
	
	
	CGFloat w = CGRectGetWidth(context.frame)/2;
	CGFloat h = CGRectGetHeight(context.frame);
	context.frame = TTRectInset(context.frame, inset);
	context.contentFrame = TTRectInset(context.contentFrame, inset);
	CGContextRef ctx = UIGraphicsGetCurrentContext();
	CGContextSaveGState(ctx);
	
	
	UIGraphicsBeginImageContext(CGSizeMake(w*2, h) );
	
	
	
	CGContextRef ctxTmp = UIGraphicsGetCurrentContext();	
	
//	CGContextSetFillColorWithColor(ctxTmp, [[UIColor whiteColor] CGColor]);
//	CGContextFillRect(ctxTmp, CGRectMake(0, 0, w, h));
	
	UIBezierPath*    aPath = [UIBezierPath bezierPath];
	
	// Set the starting point of the shape.
	[aPath moveToPoint:CGPointMake(_blur/2, 0.0)];	
	// Draw the lines
	[aPath addLineToPoint:CGPointMake(0, h - _blur)];
	[aPath addLineToPoint:CGPointMake(_blur/2, h )];
	[aPath addLineToPoint:CGPointMake(w - _blur/2 , h)];
	[aPath addLineToPoint:CGPointMake(w  , h - _blur)];	
	[aPath addLineToPoint:CGPointMake(w - _blur/2, 0)];
	[aPath closePath];
	
	CGContextBeginPath(ctxTmp);
	CGContextAddPath(ctxTmp,aPath.CGPath);	
	CGContextClosePath(ctxTmp);
	CGContextClip(ctxTmp);
	
	
	[[UIColor whiteColor] setFill];
//	CGContextSetShadowWithColor(ctxTmp, CGSizeMake(w, 0), 2,
//								[UIColor blackColor].CGColor);

	CGContextFillPath(ctxTmp);
	
	UIImage *image  =	UIGraphicsGetImageFromCurrentImageContext();
	
	
	
	UIGraphicsEndImageContext();
	
	[context.shape addToPath:context.frame];
	

	[image   drawAtPoint:CGPointMake(0, 0)];
	
	
	[self.next draw:context];
	
	CGContextRestoreGState(ctx);
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGSize)addToSize:(CGSize)size context:(TTStyleContext*)context {
	CGFloat blurSize = round(_blur / 2);
	size.width	+=  blurSize*2;
	size.height += blurSize*2;
	
	if (_next) {
		return [self.next addToSize:size context:context];
		
	} else {
		return size;
	}
}

@end
 */
