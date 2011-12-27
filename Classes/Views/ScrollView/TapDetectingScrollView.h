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

/**
TapDetectingScrollView is based on the TapDetectingImageView class from the Apple sample code project ScrollViewSuite.
<http://developer.apple.com/iPhone/library/samplecode/ScrollViewSuite/>.

It enables the detection and handling of single and double taps with one finger, and a double-finder tap in the scroll view.
The delegate of the scroll view implements the methods defined in TapDetectingScrollViewDelegate protocol to handle the detected taps.
*/

@interface TapDetectingScrollView : UIScrollView 
{
@private	    
    // Touch detection
    CGPoint _tapLocation;         // Needed to record location of single tap, which will only be registered after delayed perform.
	
	NSSet *_twoFingerTapTouchesBegan; // Collect the touches of a two-finger tap at the start of the gesture.
	NSMutableSet *_twoFingerTapTouchesEnded; // Collects each touch of a two-finger tap as they end, possible one finger at a time.
}
@end

#pragma mark -

/* Protocol for the tap-detecting image view's delegate. */
@protocol TapDetectingScrollViewDelegate <UIScrollViewDelegate>

@optional
- (void) tapDetectingScrollView:(TapDetectingScrollView *)scrollView gotSingleTapAtPoint:(CGPoint)tapPoint;
- (void) tapDetectingScrollView:(TapDetectingScrollView *)scrollView gotDoubleTapAtPoint:(CGPoint)tapPoint;
- (void) tapDetectingScrollView:(TapDetectingScrollView *)scrollView gotTwoFingerTapAtPoint:(CGPoint)tapPoint;

@end
