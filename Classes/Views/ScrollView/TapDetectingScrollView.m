//
//  TapZoomImageView.h
//  TouchImageViewerDemo
//
//  Created on 01/06/09.
//  Copyright Standard Orbit Software, LLC 2009. All rights reserved.
//	LICENSE <http://creativecommons.org/licenses/BSD/>
//
// $Revision$
// $Author$
// $Date$

#import "TapDetectingScrollView.h"

#define TAP_DELAY 0.40

static inline CGPoint midpointBetweenPoints(CGPoint a, CGPoint b)
{
    CGFloat x = (a.x + b.x) / 2.0;
    CGFloat y = (a.y + b.y) / 2.0;
    return CGPointMake(x, y);
}

@interface TapDetectingScrollView ()
- (void)handleSingleTap;
- (void)handleDoubleTap;
- (void)handleTwoFingerTap;
@end

@interface TapDetectingScrollView()
@property (nonatomic, retain) NSSet *beginningTwoFingerTapTouches;
@property (nonatomic, retain) NSMutableSet *endingTwoFinderTapTouches;
@end


@implementation TapDetectingScrollView

#pragma mark -
#pragma mark UIView Overrides

- (id) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
		
		// The scroll view resizes every which way but loose
		[self setAutoresizingMask:UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin];
		
		// We're very interactive
        [self setUserInteractionEnabled:YES];
        [self setMultipleTouchEnabled:YES];
    }
    return self;
}

- (void) dealloc;
{
	//LOG_EXIT;
	[super dealloc];
}

- (void) willMoveToSuperview:(UIView *)newSuperview;
{
	if ( newSuperview == nil ) 
	{
		// Cleanup ivars when view is going away
		//ReleaseAndNil( _twoFingerTapTouchesBegan );
		//ReleaseAndNil( _twoFingerTapTouchesEnded );
	}
}


#pragma mark -
#pragma mark UIResponder Overrides


-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{	
	//LOG_ENTRY;
	NSSet *ourTouches = [event touchesForView:self];
	
#if DEBUG
	NSLog(@"-----------");
	NSLog(@"# of total touches: %d", [touches count]);
	for ( UITouch *touch in ourTouches ) {
		NSLog(@"touch <%p> tapCount: %d", touch, [touch tapCount]);
	}
#endif
	
	// Reset these two-finger tap-detecting properties at the beginning of any new touch.  When a new touch begins, any previous two-finger tap is cancelled.  
	self.beginningTwoFingerTapTouches = nil;
	self.endingTwoFinderTapTouches = nil;
	/* NOTE,  FUTURE DEVELOPER!
	 Two finger taps usually begin with two touchs down, but often end one touch at a time.  You need to distinguish when an ending touch is part of a two-finger-tap, a single-finger-tap, or something else.  In this code, a non-nil value for self.beginningTwoFingerTapTouches is used as an indicator that we've detected the start of a two-finger tap.  
	 
	 -touchesEnded: will be invoked twice when a two-finger tap ends one finger at a time.  To prevent the second ending touch from being treated as the end of a single tap, we branch there on the value of self.beginningTwoFingerTapTouches:  non-nil means the ending touch is part of a two-finger tap;  a nil value means that it isn't.
	 */
	
	// Detect two-finger tap at the start of the sequence
	
	BOOL isTwoFingerTap = ([ourTouches count] == 2) && [touches isEqualToSet:ourTouches];
	if ( isTwoFingerTap ) 
	{
		// Both touches should have ended with tap count of 1 in order to consider this a two-finger tap.
		for ( UITouch *touch in ourTouches ) {
			isTwoFingerTap = isTwoFingerTap && ([touch tapCount] == 1);
		}
		
#if DEBUG
		//NSLog(@"isTwoFingerTap? %@", StringFromBool(isTwoFingerTap));
#endif
		
		if ( isTwoFingerTap ) 
		{
			self.beginningTwoFingerTapTouches = [NSSet setWithSet:ourTouches];
			self.endingTwoFinderTapTouches = [NSMutableSet set];
		} 
	}
	
	else {
		[super touchesBegan:touches withEvent:event];
	}
	
	//LOG_EXIT;
}

- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	//LOG_ENTRY;
	//为了适应SimpleBrowserViewController进行修改
	NSSet *ourTouches = touches;
	//	NSSet *outTouches = [event touchesForView:self];
	
	// Handle two-finger tap first.
	
	if ( self.beginningTwoFingerTapTouches ) 
	{		
		/* NOTE, FUTURE DEVELOPER!
		 -touchesEnded: will be invoked twice when a two-finger tap ends one finger at a time.  To prevent the second ending touch from being treated as the end of a single tap, we branch there on the value of self.beginningTwoFingerTapTouches:  non-nil means the ending touch is part of a two-finger tap;  a nil value means that it isn't.  self.beginningTwoFingerTapTouches is nil'd out at the top of every new -touchesBegan: to make this work.
		 */
		
		// We're only interested in the touches in our view...
		
		if ( [ourTouches count] == 2 ) 
		{
			// Both touches ended together
			[self.endingTwoFinderTapTouches addObjectsFromArray:[ourTouches allObjects]];
		}
		else if ( [ourTouches count] == 1 ) 
		{
			// If this is one of our two-finger taps ending, collect it.
			UITouch *touch = [ourTouches anyObject];
			
			if ( [self.beginningTwoFingerTapTouches containsObject:touch] ) 
			{
				[self.endingTwoFinderTapTouches addObject:touch];
			}
		}
		
		
		// Do we have two tap touches collected for the two-finger tap?  If so, then fire it off.
		if ( [self.endingTwoFinderTapTouches count] == 2 ) 
		{
			// Check if both touches are taps.  If so, then we have a two-finger tap.
			BOOL isTwoFingerTap = YES;
			for ( UITouch *touch in self.endingTwoFinderTapTouches ) 
			{
				isTwoFingerTap = isTwoFingerTap && [touch tapCount] == 1;
			}
			
			if ( isTwoFingerTap )  
			{
				// Use the midpoint between the two touches as the location of the two-finger tap.
				NSArray *taps = [self.endingTwoFinderTapTouches allObjects];
				UITouch *firstFinger = [taps objectAtIndex:0];
				UITouch *secondFinger = [taps objectAtIndex:1];
				_tapLocation = midpointBetweenPoints( [firstFinger locationInView:self], [secondFinger locationInView:self]);
				
				[self handleTwoFingerTap];
			}
		}
		
		// Short-circuit return
		//LOG_EXIT;
		return;
	}
	
	// Handle single-finger taps
	
	BOOL singleFingerTapDetected = [ourTouches count] == 1;
	if ( singleFingerTapDetected ) 
	{
		NSUInteger tapCount = [[ourTouches anyObject] tapCount];
		switch ( tapCount ) {
			case 1:
				[self performSelector:@selector(handleSingleTap) withObject:nil afterDelay:TAP_DELAY];
				break;
				
			case 2:
				[NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(handleSingleTap) object:nil];
				[self handleDoubleTap];
				break;
				
			default:
				// Pass handling off to UIScrollView
				[super touchesBegan:touches withEvent:event];
				break;
		} // switch
		
		//LOG_EXIT;
		return;
	}
	
	// If no taps (single- or double-finger) were handled above, pass handling off to UIScrollView
	[super touchesBegan:touches withEvent:event];
	
	//LOG_EXIT;
}

- (void) touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
	//LOG_ENTRY;
	
	// Reset our tap-detection flags
	//	_twoFingerTapHandled = NO;
	//	_twoFingerTapDetected = NO;
	self.beginningTwoFingerTapTouches = nil;
	self.endingTwoFinderTapTouches = nil;
	
	[super touchesCancelled:touches withEvent:event];
	
	//LOG_EXIT;
}

#pragma mark -
#pragma mark Tap Handling

- (void)handleSingleTap 
{
	id <TapDetectingScrollViewDelegate> tappingDelegate = (id <TapDetectingScrollViewDelegate>)self.delegate;
	
	if ( [tappingDelegate respondsToSelector:@selector(tapDetectingScrollView:gotSingleTapAtPoint:)])
		[tappingDelegate tapDetectingScrollView:self gotSingleTapAtPoint:_tapLocation];
}

- (void)handleDoubleTap 
{
	id <TapDetectingScrollViewDelegate> tappingDelegate = (id <TapDetectingScrollViewDelegate>)self.delegate;
	
	if ( [tappingDelegate respondsToSelector:@selector(tapDetectingScrollView:gotDoubleTapAtPoint:)])
		[tappingDelegate tapDetectingScrollView:self gotDoubleTapAtPoint:_tapLocation];
}

- (void)handleTwoFingerTap 
{
	id <TapDetectingScrollViewDelegate> tappingDelegate = (id <TapDetectingScrollViewDelegate>)self.delegate;
	
	if ( [tappingDelegate respondsToSelector:@selector(tapDetectingScrollView:gotTwoFingerTapAtPoint:)])
	{
		[tappingDelegate tapDetectingScrollView:self gotTwoFingerTapAtPoint:_tapLocation];
	}
}

#pragma mark -
#pragma mark Properties

@synthesize beginningTwoFingerTapTouches = _twoFingerTapTouchesBegan;
@synthesize endingTwoFinderTapTouches = _twoFingerTapTouchesEnded;

@end
