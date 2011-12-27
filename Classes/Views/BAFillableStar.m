//
//  BAFillableStar.m
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

#import "BAFillableStar.h"


@implementation BAFillableStar
@synthesize strokeColor,fillColor;
@synthesize lineWidth;
@synthesize fillPercent;

- (id)initWithFrame:(CGRect)frame {
	if (self = [super initWithFrame:frame]) {
		self.contentMode = UIViewContentModeRedraw;
		// a normalized star points array
		points[0] = CGPointMake(0.5,0.025);
		points[1] = CGPointMake(0.654,0.338);
		points[2] = CGPointMake(1,0.388);
		points[3] = CGPointMake(0.75,0.631);
		points[4] = CGPointMake(0.809,0.975);
		points[5] = CGPointMake(0.5,0.813);
		points[6] = CGPointMake(0.191,0.975);
		points[7] = CGPointMake(0.25,0.631);
		points[8] = CGPointMake(0,0.388);
		points[9] = CGPointMake(0.346,0.338);
	}
	lineWidth = 1.0;  //default line width
	
	self.strokeColor = [UIColor blackColor];
	
	//default colors
	self.fillColor = [UIColor yellowColor];
	//scale our normalized points to the dimensions of the rectangle
	for (int i=0; i<10; i++) {
		points[i].x = points[i].x * frame.size.width;
		points[i].y = points[i].y * frame.size.height;
	}
	return self;
	
}

-(void)setStrokeColor:(UIColor *)color{
	TT_RELEASE_SAFELY(strokeColor);
	strokeColor = [color retain];
	[self setNeedsDisplay];
}

-(void)setFillColor:(UIColor *)color{
	TT_RELEASE_SAFELY(fillColor);
	fillColor = [color retain];
	[self setNeedsDisplay];
}



-(void) fillBackgroundOfContext:(CGContextRef)context withRect:(CGRect)rect;
{
	CGContextSetFillColorWithColor(context, [backgroundColor CGColor]);
	CGContextFillRect(context, rect);
}

-(void) fillStarInContext:(CGContextRef)context withRect:(CGRect)rect
{
	CGContextSaveGState(context);//create the path using our points array
	CGContextBeginPath(context);
	CGContextAddLines(context, points, 10);
	CGContextClosePath(context);
	CGContextClip(context);  //clip drawing to the area defined by this path
	rect.size.width = rect.size.width * fillPercent;  //we want make the width of the rect
	CGContextSetFillColorWithColor(context, [fillColor CGColor]);
	CGContextFillRect(context, rect);
	
	CGContextRestoreGState(context);
	
}

-(void) drawStarOutlineInContext:(CGContextRef)context withRect:(CGRect)rect
{
	CGContextBeginPath(context);
	CGContextAddLines(context, points, 10);  //create the path
	CGContextClosePath(context);
	//set the properties for the line
	CGContextSetLineWidth(context, lineWidth);
	CGContextSetStrokeColorWithColor(context, [strokeColor CGColor]);//stroke the path
	CGContextStrokePath(context);
}

- (void)drawRect:(CGRect)rect {
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextSetShouldAntialias(context, true);CGLayerRef layer = CGLayerCreateWithContext(context, rect.size, NULL);
	CGContextRef layerContext = CGLayerGetContext(layer);
	//[self fillBackgroundOfContext:layerContext withRect:rect];

	[self fillStarInContext:layerContext withRect:CGRectInset(rect, lineWidth, lineWidth) ];
	[self drawStarOutlineInContext:layerContext withRect:rect];
	
	CGContextDrawLayerInRect(context, rect, layer);  //draw the layer to the actual drawing context
	
	CGLayerRelease(layer);  //release the layer
	
}

@end
