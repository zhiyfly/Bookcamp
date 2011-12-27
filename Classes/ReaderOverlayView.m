//------------------------------------------------------------------------
//  Copyright 2009-2010 (c) Jeff Brown <spadix@users.sourceforge.net>
//
//  This file is part of the ZBar iPhone App.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//
//  http://zbar.sourceforge.net/iphone
//------------------------------------------------------------------------

#import "ReaderOverlayView.h"

@implementation ReaderOverlayView;

@synthesize delegate;
//, tipShowDelay, tipHideDelay;
@synthesize navigatorBar;

//- (void) initTip
//{
//    tipView = [[UIView alloc]
//                  initWithFrame: CGRectMake(4, 360, 312, 118)];
//    tipView.backgroundColor = [UIColor colorWithWhite: 0
//                                       alpha: .5];
//    CALayer *layer = tipView.layer;
//    layer.cornerRadius = 16;
//    layer.borderColor = [UIColor grayColor].CGColor;
//    layer.borderWidth = 2;
//
//    UILabel *label =
//        [[UILabel alloc]
//            initWithFrame: CGRectMake(32, 8, 248, 48)];
//    label.text = @"No barcode detected!\nTap here for help";
//    label.textAlignment = UITextAlignmentCenter;
//    label.backgroundColor = [UIColor clearColor];
//    label.textColor = [UIColor whiteColor];
//    label.font = [UIFont systemFontOfSize: 18];
//    label.numberOfLines = 2;
//    label.adjustsFontSizeToFitWidth = YES;
//    label.minimumFontSize = 10;
//    label.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
//    [tipView addSubview: label];
//    [label release];
//
//    label = [[UILabel alloc]
//                initWithFrame: CGRectMake(4, 4, 24, 24)];
//    label.text = @"\u00d7"; // 'x' (multiply symbol)
//    label.textAlignment = UITextAlignmentCenter;
//    label.backgroundColor = [UIColor clearColor];
//    label.textColor = [UIColor whiteColor];
//    label.font = [UIFont boldSystemFontOfSize: 18];
//    label.userInteractionEnabled = YES;
//    [tipView addSubview: label];
//    [label release];
//
//    UIButton *button =
//        [UIButton buttonWithType: UIButtonTypeCustom];
//    button.frame = CGRectMake(0, 0, 64, 64);
//    [button addTarget: self
//            action: @selector(hideTipAnimated)
//            forControlEvents: UIControlEventTouchUpInside];
//    [tipView addSubview: button];
//
//    button = [UIButton buttonWithType: UIButtonTypeCustom];
//    button.frame = CGRectMake(64, 0, 248, 64);
//    [button addTarget: self
//            action: @selector(info)
//            forControlEvents: UIControlEventTouchUpInside];
//    [tipView addSubview: button];
//}

-(NavigatorBar*)navigatorBar{
	if (!_navigatorBar){
		_navigatorBar = [[NavigatorBar alloc] initWithFrame:CGRectMake(0, 426, 320, 54)];
		[_navigatorBar setStyle:TTSTYLE(navigatorBarStyle)];
		[self addSubview:_navigatorBar];
		
	}
	return _navigatorBar;
}

- (id) init
{
    self = [super initWithFrame: CGRectMake(0, 0, 320, 480)];
    if(!self)
        return(nil);

//    tipShowDelay = 5;
 //   tipHideDelay = 5;

    self.backgroundColor = [UIColor clearColor];

    //[self initTip];
    //[self addSubview: tipView];

//    toolbar = [[UIToolbar alloc]
//                  initWithFrame: CGRectMake(0, 426, 320, 54)];
//    toolbar.barStyle = UIBarStyleBlackOpaque;
//    [self addSubview: toolbar];
	cancelBtn = [[TTButton alloc] init];
	[cancelBtn setStylesWithSelector:@"cancelButtonStyle:"];
	[cancelBtn setTitle:BCLocalizedString(@"cancel", @"cancel") forState:UIControlStateNormal];
	[cancelBtn sizeToFit];
	[cancelBtn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
	
	[self.navigatorBar addToNavigatorView:cancelBtn align:NavigationViewAlignCenter];
	
	
    doneBtn =
        [[UIBarButtonItem alloc]
            initWithBarButtonSystemItem: UIBarButtonSystemItemDone
            target: self
            action: @selector(dismiss)];
//    cancelBtn =
//        [[UIBarButtonItem alloc]
//            initWithBarButtonSystemItem: UIBarButtonSystemItemCancel
//            target: self
//            action: @selector(dismiss)];
    space =
        [[UIBarButtonItem alloc]
            initWithBarButtonSystemItem: UIBarButtonSystemItemFlexibleSpace
            target: nil
            action: nil];

    infoBtn = [[UIButton buttonWithType: UIButtonTypeInfoLight]
                  retain];
    infoBtn.frame = CGRectMake(266, 426, 54, 54);
    [infoBtn addTarget: self
             action: @selector(info)
             forControlEvents: UIControlEventTouchUpInside];
    //[self addSubview: infoBtn];

    return(self);
}

- (void) dealloc
{
 //   [toolbar release];
 //   toolbar = nil;
    [doneBtn release];
    doneBtn = nil;
    [cancelBtn release];
    cancelBtn = nil;
    [infoBtn release];
    infoBtn = nil;
    [space release];
    space = nil;
    //[tipView release];
    //tipView = nil;
    [super dealloc];
}

//- (void) showTipAnimated
//{
//    if(!showTip)
//        return;
//    showTip = NO;
//
//    [UIView beginAnimations: @"ShowTip"
//            context: nil];
//    [UIView setAnimationDuration: .5];
//    tipView.transform = CGAffineTransformIdentity;
//    infoBtn.center = CGPointMake(293, 394);
//    [UIView commitAnimations];
//
//    if(tipHideDelay > 0)
//        [self performSelector: @selector(hideTipAnimated)
//              withObject: nil
//              afterDelay: tipHideDelay];
//}

//- (void) hideTip
//{
//    // squeeze the tip into the info button as it pops down
//    tipView.transform = CGAffineTransformMake(.1, 0, 2.5, .4875, 280.5, 45.16);
//    infoBtn.center = CGPointMake(293, 453);
//}
//
//- (void) hideTipAnimated
//{
//    [UIView beginAnimations: @"HideTip"
//            context: nil];
//    [UIView setAnimationDuration: .5];
//    [self hideTip];
//    [UIView commitAnimations];
//}

- (void) willAppear
{
//    if(tipShowDelay > 0) {
//        [self hideTip];
//        showTip = YES;
// [self performSelector: @selector(showTipAnimated)
//              withObject: nil
//              afterDelay: tipShowDelay];
//    }
}

- (void) willDisappear
{
//    showTip = NO;
    //[self hideTipAnimated];
}

- (void) setMode: (ReaderOverlayMode) mode
{
    UIBarButtonItem *dismissBtn;
    if(mode == OVERLAY_MODE_DONE)
        dismissBtn = doneBtn;
    else
        dismissBtn = cancelBtn;
    //toolbar.items = [NSArray arrayWithObjects: dismissBtn, space, nil];
}

- (void) dismiss
{
    [delegate performSelector: @selector(readerOverlayDidDismiss)
          withObject: nil
          afterDelay: 0.1];
}

- (void) info
{
    [delegate readerOverlayDidRequestHelp];
}

@end
