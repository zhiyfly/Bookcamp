//
// TTAreaStyle.m
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

#import "TTAreaStyle.h"

// Core
#import "Three20Core/TTCorePreprocessorMacros.h"

@implementation TTAreaStyle


@synthesize rect  = _rect;
@synthesize style = _style;
@synthesize areaBlock;
@synthesize data = _data;


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)dealloc {
	TT_RELEASE_SAFELY(areaBlock);
	TT_RELEASE_SAFELY(_style);
	TT_RELEASE_SAFELY(_data);
	[super dealloc];
}



///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Class public

///////////////////////////////////////////////////////////////////////////////////////////////////
+(TTAreaStyle*)styleWithBlock:(styleAreaBlock)styleArea data:(id)data style:(TTStyle*)stylez next:(TTStyle*)next; {
	TTAreaStyle* style = [[[self alloc] initWithNext:next] autorelease];
	style.style = stylez;
	style.areaBlock = styleArea;
	style.data = data;
	return style;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
+(TTAreaStyle*)styleWithRect:(CGRect)rect style:(TTStyle*)stylez next:(TTStyle*)next; {
	TTAreaStyle* style = [[[self alloc] initWithNext:next] autorelease];
	style.rect = rect;
	style.style = stylez;
	return style;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark TTStyle

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)draw:(TTStyleContext*)context {
	
	CGContextRef ctx = UIGraphicsGetCurrentContext();
	CGRect rect = context.frame;
	CGRect contentRect = context.contentFrame;
	if (self.areaBlock) {
		self.rect = self.areaBlock(contentRect, self.data);
	}
	CGContextSaveGState(ctx);
	
	[context.shape addToPath:rect];
	CGContextClip(ctx);
	CGContextClipToRect(ctx,self.rect);
	context.frame = self.rect;
	context.contentFrame = self.rect;
	[self.style draw:context];
	//restore the rect
	context.frame = rect;
	context.contentFrame = contentRect;
	CGContextRestoreGState(ctx);
	
	return [self.next draw:context];
}


@end
