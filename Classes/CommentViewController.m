//
//  CommentViewController.m
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
#import "CommentViewController.h"
#import "ScreenCapture.h"
#import "UIImage+Resize.h"
@implementation CommentViewController

@synthesize commentAuthorInfoBar = _commentAuthorInfoBar;
@synthesize commentContentView = _commentContentView;
@synthesize cid = _cid;
@synthesize commentModel = _commentModel;
@synthesize wrapper = _wrapper;


#if !defined(MY_BANNER_UNIT_ID)
#error "You must define MY_BANNER_UNIT_ID as your AdMob Publisher ID"
#endif

#ifndef NO_AD

- (void)adView:(GADBannerView *)bannerView
didFailToReceiveAdWithError:(GADRequestError *)error {
	BCNSLog(@"adView:didFailToReceiveAdWithError:%@", [error localizedDescription]);
}

- (void)adViewDidReceiveAd:(GADBannerView *)bannerView {
	[UIView beginAnimations:@"BannerSlide" context:nil];
	bannerView.frame = CGRectMake(0.0,
								  self.view.frame.size.height -
								  bannerView.frame.size.height,
								  bannerView.frame.size.width,
								  bannerView.frame.size.height);
	UIScrollView *scrollView = [self.commentContentView scrollView];
	[scrollView setContentInset:UIEdgeInsetsMake(0, 0, CGRectGetHeight(bannerView.frame), 0)];
	[UIView commitAnimations];
}

#endif

- (void)adViewWillPresentScreen:(GADBannerView *)bannerView{
	
}

-(void)dealloc {
#ifndef NO_AD
	bannerView_.delegate = nil;
	[bannerView_ release];
#endif
	TT_RELEASE_SAFELY(_commentAuthorInfoBar);
	TT_RELEASE_SAFELY(_commentContentView);
	TT_RELEASE_SAFELY(_commentModel);
	TT_RELEASE_SAFELY(_wrapper);
	[super dealloc];
}



-(void)viewDidLoad{
	[super viewDidLoad];
	
}

-(CGRect)rectForNavigator{
	return BKNavigatorBarFrameThree();
}

-(id)initWithCommentID:(NSString*)cid{
	if (self = [super initWithNibName:nil bundle:nil]) {
		[self.backBtn setStylesWithSelector:@"backBtnCloseStyle:"];
		
		UIImageView *backgroundView = [[[UIImageView alloc] initWithFrame:CGRectMake(0, BKNavigatorBarHeight,
																		   CGRectGetWidth(BKScreenBoundsWithoutBar()),
																		   CGRectGetHeight(BKScreenBoundsWithoutBar()) - BKNavigatorBarHeight )] autorelease];
		//backgroundView.backgroundColor = [UIColor clearColor];

		backgroundView.image = [[ScreenCapture capture] captureView:[[[TTNavigator navigator] visibleViewController] view] inRect:backgroundView.frame];

		
		[self.view addSubview:backgroundView];
		[self.view sendSubviewToBack:backgroundView];
		
		self.cid = [NSNumber numberWithInt:[cid intValue]];
		[self.navigatorBar addToNavigatorView:self.backBtn align:NavigationViewAlignLeft];
	}
	return self;
}

-(CommentModel*)commentModel{
	if (!_commentModel) {
		_commentModel = [[CommentModel alloc] initWithCommentID:self.cid];
	}
	return _commentModel;
}

-(void)createModel{
	self.model = self.commentModel;
}



- (void)didLoadModel:(BOOL)firstTime{
	[super didLoadModel:firstTime];
	CommentObject *comment = self.commentModel.comment;
	
	CommentAuthorInfoItem *item = [CommentAuthorInfoItem itemWithName:comment.author.name signature:comment.author.signature
															avatarURL:comment.author.avatar];
	[self.commentAuthorInfoBar setObject:item];
	
	NSString *commentContent = [[comment.content copy] autorelease];
	while (commentContent && [commentContent rangeOfString:@"\n\n"].location != NSNotFound) {
		commentContent = [commentContent stringByReplacingOccurrencesOfString:@"\n\n" withString:@"\n"];
	}
	
	while (commentContent && [commentContent rangeOfString:@"\n\r\n\r"].location != NSNotFound) {
		commentContent = [commentContent stringByReplacingOccurrencesOfString:@"\n\r\n\r" withString:@"\n\r"];
	}
	
	
//	while (commentContent && [commentContent rangeOfString:@"　　"].location != NSNotFound) {
//		commentContent = [commentContent stringByReplacingOccurrencesOfString:@"　　" withString:@"　"];
//	}
//	while (commentContent && [commentContent rangeOfString:@"  "].location != NSNotFound) {
//		commentContent = [commentContent stringByReplacingOccurrencesOfString:@"  " withString:@" "];
//	}
//	
	commentContent = [commentContent stringByReplacingOccurrencesOfString:@"\n" withString:@"<br/><br/>"];
	commentContent = [commentContent stringByReplacingOccurrencesOfString:@"\n\r" withString:@"<br/><br/>"];

	
	
	NSString *regexString       = @"\\s{2,}";
	
	NSMutableString* mutableCommentContent = [NSMutableString stringWithString:commentContent];
	
	[mutableCommentContent replaceOccurrencesOfRegex:regexString withString:@"<br/><br/>"];
	
//	commentContent = [commentContent stringByReplacingOccurrencesOfString:@" " withString:@"<br/><br/>"];
//	commentContent = [commentContent stringByReplacingOccurrencesOfString:@"　" withString:@"<br/><br/>"];
	
	CommentContentItem  *contentItem = [CommentContentItem itemWithContent:mutableCommentContent date:comment.updated rating:comment.rating profitIt:comment.votes
																	 count:[NSNumber numberWithInt:([comment.votes intValue]+[comment.unvotes intValue])]];

	[self.commentContentView setObject:contentItem];
	
#ifndef NO_AD	
	//ad start
	
	// Create a view of the standard size at the bottom of the screen.
	bannerView_ = [[GADBannerView alloc]
                   initWithFrame:CGRectMake(0.0,
                                            self.view.frame.size.height,
                                            GAD_SIZE_320x50.width,
                                            GAD_SIZE_320x50.height)];
	
	// Specify the ad's "unit identifier." This is your AdMob Publisher ID.
	
	bannerView_.adUnitID = MY_BANNER_UNIT_ID;
	
	// Let the runtime know which UIViewController to restore after taking
	// the user wherever the ad goes and add it to the view hierarchy.
	bannerView_.rootViewController = self;
	[self.view addSubview:bannerView_];
	
	[bannerView_ setDelegate:self];
	// Initiate a generic request to load it with an ad.
	GADRequest *request =  [GADRequest request];
	[request addKeyword:comment.author.name];
	[request addKeyword:comment.author.signature];
	//[request addKeyword:comment.content];
#ifdef BCDebug 
	request.testDevices = [NSArray arrayWithObjects:
						   GAD_SIMULATOR_ID,                               // Simulator
						   @"28ab37c3902621dd572509110745071f0101b124",    // Test iPhone 3G 3.0.1
						   @"8cf09e81ef3ec5418c3450f7954e0e95db8ab200",    // Test iPod 4.3.1
						   nil];
#endif	
	[bannerView_ loadRequest:request];
#endif
	
}

-(void)viewWillAppear:(BOOL)animated{
	self.wrapper.frame = CGRectOffset(self.wrapper.frame, self.wrapper.width, 0	);
	
	[UIView beginAnimations:@"stretchComment" context:nil];
	
	[UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
	[UIView setAnimationDuration:.3];
	self.wrapper.frame = CGRectOffset(self.wrapper.frame, -self.wrapper.width, 0	);
	
	[super viewWillAppear:animated];
	[UIView commitAnimations];
	
}

-(void)viewWillDisappear:(BOOL)animated{
	[super viewWillDisappear:animated];
}


-(void)back:(TTButton *)btn{
	UINavigationController *navController = self.navigationController;
	[navController popViewControllerAnimated:NO];
	[navController popViewControllerAnimated:YES];

}

-(void)animationDidStop:(NSString *)animationID finished:(BOOL)finished context:(void *)context{
	self.view.userInteractionEnabled=YES;
	[self.navigationController popViewControllerAnimated:NO];
}

-(void)dismissCommentView:(TTButton*)btn{
	[UIView beginAnimations:@"shrinkComment" context:nil];
	
	[UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
	[UIView setAnimationDuration:.3];
	self.wrapper.frame = CGRectOffset(self.wrapper.frame, self.wrapper.width, 0	);
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
	[UIView commitAnimations];

}

#define CommentDismissBtnWidth 24
#define CommentDismissBtnHeight 29

-(TTView*)wrapper{
	if (!_wrapper) {
		_wrapper = [[TTView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight([self rectForNavigator]), 
															RootModuleWidth, CGRectGetHeight(BKScreenBoundsWithoutBar()) - CGRectGetHeight([self rectForNavigator])
																																		   )];
		
		
		TTButton *commentDismissBtn = [[[TTButton alloc] initWithFrame:CGRectMake(0, (_wrapper.height - CommentDismissBtnHeight) / 2,
																				CommentDismissBtnWidth, CommentDismissBtnHeight)] autorelease];
		[commentDismissBtn setStylesWithSelector:@"commentDismissBtnStyle:"];
		[commentDismissBtn addTarget:self action:@selector(dismissCommentView:) forControlEvents:UIControlEventTouchUpInside];
		_wrapper.style = TTSTYLE(commentViewStyle);
		[_wrapper addSubview:commentDismissBtn];
		[self.view addSubview:_wrapper];
	}
	return  _wrapper;
}



-(CommentContentView*)commentContentView{
	if (!_commentContentView) {	
		_commentContentView = [[CommentContentView alloc] initWithFrame:CGRectMake(BKContentMargin*2, CommentAuthorInfoBarHeight, RootModuleWidth-BKContentLargeMargin-BKContentMargin*2, CGRectGetHeight(self.view.frame)-CommentAuthorInfoBarHeight-4*BKContentLargeMargin)];
		_commentContentView.backgroundColor = [UIColor clearColor];

		[self.wrapper addSubview:_commentContentView];
	} 
	return _commentContentView;
}



-(CommentAuthorInfoView*)commentAuthorInfoBar{
	if (!_commentAuthorInfoBar) {
		_commentAuthorInfoBar = [[CommentAuthorInfoView alloc] initWithFrame:CGRectMake(0, 0, RootModuleWidth,CommentAuthorInfoBarHeight )];
		_commentAuthorInfoBar.backgroundColor = [UIColor clearColor];
		[self.wrapper addSubview:_commentAuthorInfoBar];
	}
	return _commentAuthorInfoBar;
}


@end
