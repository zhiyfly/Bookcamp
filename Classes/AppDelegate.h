//
//  bookcampAppDelegate.h
//  bookcamp
//
//  Created by waiwai on 12/10/10.
//  Copyright __iwaiwai__ 2010. All rights reserved.
//
#import "GlobalStyleSheet.h"

#import "MobClick.h"

#import "ReaderOverlayView.h"
#import "ReaderViewController.h"
#import "GADInterstitial.h"
@interface AppDelegate : NSObject <UIApplicationDelegate,GADInterstitialDelegate,ZBarReaderDelegate,MobClickDelegate> {
	ReaderViewController *reader;
	ReaderOverlayView *overlay;
#ifndef NO_AD
	  GADInterstitial *splashInterstitial_;
#endif
}

@property (nonatomic, retain) ReaderViewController *reader;
@end

