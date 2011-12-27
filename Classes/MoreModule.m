//
//  MoreModule.m
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

#import "MoreModule.h"
#import "EditableSectionedDateSource.h"
#import "CSFlowLayout.h"

@implementation MoreModule



-(void)dealloc{
	  [[TTNavigator navigator].URLMap removeURL:@"tt://compose?to=(composeTo:)"];
	[super dealloc];
}

- (UIViewController*)composeTo:(NSString*)recipient {
	
	MFMailComposeViewController* controller = [[MFMailComposeViewController alloc] init];
	controller.mailComposeDelegate  = self;

	[controller setToRecipients:[NSArray arrayWithObject:recipient]];
	[controller setSubject:@"BookCamp意见反馈"];
 

	
	return controller;
}

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error{

	[controller dismissModalViewControllerAnimated:YES];
}

-(id)initWithConfig:(NSDictionary*)config{
	if (self = [super init]) {
		[[TTNavigator navigator].URLMap from:@"tt://compose?to=(composeTo:)"
					   toModalViewController:self selector:@selector(composeTo:)];
		
		[self.view.navigatorBar setStyle:TTSTYLE(navigatorBarStyle)];
		self.view.navigatorBarHidden = YES;	
		UIScrollView *scrollView = [[[UIScrollView alloc] initWithFrame:self.view.bounds] autorelease];
		[self.view.contentView addSubview:scrollView];
		scrollView.backgroundColor = [UIColor clearColor];
	
		TTView *aView = [[[TTView alloc] initWithFrame:self.view.bounds] autorelease];
		aView.backgroundColor = RGBCOLOR(241,241,241); 
		NSString *documentsDirectory = [[NSBundle mainBundle] pathForResource:@"aboutUs" ofType:@"html"]; 
		NSURL *URL = [[[NSURL alloc]initFileURLWithPath:documentsDirectory] autorelease];

		
		UIWebView *htmlView = [[[UIWebView alloc]  initWithFrame:CGRectMake(0, 0,
																		   self.view.contentView.width - 2*BKContentLargeMargin, 
																			self.view.contentView.height*5/7)] autorelease];
		
		htmlView.backgroundColor = [UIColor clearColor];
		[htmlView setOpaque:NO];
		[htmlView loadRequest:[NSURLRequest requestWithURL:URL]];
		htmlView.userInteractionEnabled = FALSE;
		[aView addSubview:htmlView];
		
		
		TTButton *feedback = [[[TTButton alloc] initWithFrame:CGRectMake(0, 0, self.view.contentView.width - 2*BKContentLargeMargin, 46)] autorelease];
		[feedback setTitle:BCLocalizedString(@"moreFeedback",@"the link button text of moreFeedback") forState:UIControlStateNormal];
		[feedback setStylesWithSelector:@"feedbackLinkStyle:"];
		//feedback.URL = @"tt://feedback";
		[feedback addTarget:@"tt://compose?to=jiansihun@foxmail.com" action:@selector(openURL) forControlEvents:UIControlEventTouchUpInside];
		
		[aView addSubview:feedback];
		
		
		BKLink *bindLink = [[[BKLink alloc] initWithFrame:CGRectMake(0, 0, feedback.width, feedback.height)] autorelease];
		[bindLink setStylesWithSelector:@"bindLinkStyle:"];
		[bindLink setTitle:BCLocalizedString(@"the text of bind link",@"the text of bind link") forState:UIControlStateNormal];

		bindLink.URL =  @"tt://binds";		
	
		[aView addSubview:bindLink];
		
		self.view.contentView.backgroundColor = RGBCOLOR(241,241,241);
		
		CSFlowLayout* flowLayout = [[[CSFlowLayout alloc] init] autorelease];
		flowLayout.padding = UIEdgeInsetsMake(BKContentLargeMargin, BKContentLargeMargin, BKContentLargeMargin, 0) ;
		flowLayout.VSpace = BKContentLargeMargin;
		CGSize size =  [flowLayout layoutSubviews:aView.subviews forView:aView];
		aView.frame = CGRectMake(0, 0, aView.width, size.height);
		
		scrollView.contentSize = CGSizeMake(aView.width, aView.height) ;
		
		[scrollView addSubview:aView];
		
		
	}
	return self;
}





//-(TTSectionedDataSource*)recordTableViewDataSource{
//	if (!_recordTableViewDataSource) {
//		NSMutableArray *items=  [NSMutableArray arrayWithObjects:[NSMutableArray arrayWithObjects:
//																  [TTTableImageItem itemWithText:BCLocalizedString(@"moreHelpCenter", @"moreHelpCenter") imageURL:@"bundle://moreHelpCenterIcon.png"
//																							 URL:@"tt://more/"],
//																  [TTTableImageItem itemWithText:BCLocalizedString(@"moreAboutUs", @"moreAboutUs") imageURL:@"bundle://moreAboutUsIcon.png"
//																							 URL:@"tt://more/"],
//																  nil],
//								 [NSMutableArray arrayWithObjects:
//								  [TTTableImageItem itemWithText:BCLocalizedString(@"moreRecommend", @"moreRecommend") imageURL:@"bundle://moreRecommendIcon.png"
//															 URL:@"tt://more/"],
//								  nil],nil];
//		_recordTableViewDataSource = [[EditableSectionedDateSource alloc]initWithItems:items sections:[NSMutableArray arrayWithObjects:@"",@"",nil]];
//	}
//	return _recordTableViewDataSource;
//}







@end
