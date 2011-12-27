//
//  BindsViewController.m
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
#import "BindsViewController.h"
const NSString * connectedSiteStr[] = {@"新浪微博"}; 

@implementation BindsViewController

@synthesize engine = _engine;

#define siteBindStatusUnKnown -1
 
#define bindTipStr(_HASBINDED)  BCLocalizedString(_HASBINDED? @"has bound":@"unbound,click to bound",_HASBINDED? @"has bound":@"unbound,click to bound")

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)dealloc {
	TT_RELEASE_SAFELY(_engine);
    [super dealloc];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
		[self.navigatorBar addToNavigatorView:self.backBtn align:NavigationViewAlignLeft];
		self.variableHeightRows = YES;
		inReBinding = NO;
	}
	return self;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
-(void)viewWillAppear:(BOOL)animated{
	[super viewWillAppear:animated];
	NSUInteger i;
	for (i=0; i < SnsCount; i++) {
		siteBindStatus[i] = siteBindStatusUnKnown;

		if ( [[NSUserDefaults standardUserDefaults] objectForKey: @"authData"]) {
			siteBindStatus[0] = 1;
		} else {
			siteBindStatus[0] = 0;
		}
		
	}
	BookListDataSource* dataSource = [[[BookListDataSource alloc] init] autorelease];
	for (int i = 0; i < SnsCount; ++i) {	
		[dataSource.items addObject:[BXTableSubtitleItem itemWithText:connectedSiteStr[i]
															 subtitle:siteBindStatus[i] == siteBindStatusUnKnown? BCLocalizedString(@"unknown bind status", @"unknown bind status")  : bindTipStr(siteBindStatus[i])
															 imageURL:[[@"bundle://" stringByAppendingString:
																		[connectedSite objectAtIndex:i]] stringByAppendingString:@".png"]
														 defaultImage:nil
																  URL:nil accessoryURL:nil]];
		
	}
	self.dataSource = dataSource;	
	inReBinding = NO;
	
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (BOOL)shouldOpenURL:(NSString*)URL {
	return NO;
}

//- (UITableViewCellSelectionStyle)tableSelectionStyle {
//    return UITableViewCellSelectionStyleBlue;
//}

-(OAuthEngine*)engine{
	if (!_engine){
		_engine = [[OAuthEngine alloc] initOAuthWithDelegate: self];
		_engine.consumerKey = kOAuthConsumerKey;
		_engine.consumerSecret = kOAuthConsumerSecret;
		[OAuthEngine setCurrentOAuthEngine:_engine];
	}
	return _engine;
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
	NSUserDefaults	*defaults = [NSUserDefaults standardUserDefaults];
	BindsViewController *currentViewController = [TTNavigator navigator].visibleViewController ;	
	UIViewController *controller ;
	switch (buttonIndex) {
		//解除绑定
		case 0:

			[defaults removeObjectForKey: @"authData"];
			[defaults synchronize];
			break;
		//重新绑定
		case 1:
			inReBinding = YES;
			controller = [OAuthController controllerToEnterCredentialsWithEngine: self.engine delegate: self];
			if (controller) {	
				[currentViewController presentModalViewController: controller animated: YES];
				return;
			}
			break;
		//取消
		case 2:
		default:
			break;
	}
	[self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:NO];
}


//=============================================================================================================================
#pragma mark OAuthEngineDelegate
#pragma mark save the user info 

- (void) storeCachedOAuthData: (NSString *) data forUsername: (NSString *) username {
	NSUserDefaults			*defaults = [NSUserDefaults standardUserDefaults];
	
	[defaults setObject: data forKey: @"authData"];
	[defaults synchronize];
}

- (NSString *) cachedOAuthDataForUsername: (NSString *) username {
	if (inReBinding) {
		return nil;
	}
	return [[NSUserDefaults standardUserDefaults] objectForKey: @"authData"];
}

- (void)removeCachedOAuthDataForUsername:(NSString *) username{
	NSUserDefaults			*defaults = [NSUserDefaults standardUserDefaults];
	
	[defaults removeObjectForKey: @"authData"];
	[defaults synchronize];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)didSelectObject:(id)object atIndexPath:(NSIndexPath*)indexPath {
	
	//绑定设置
	if (siteBindStatus[indexPath.row] != siteBindStatusUnKnown) {
		//go straight to bindSettingView
		if (siteBindStatus[indexPath.row] == 0) {
			UIViewController *controller = [OAuthController controllerToEnterCredentialsWithEngine: self.engine delegate: self];
			[self.navigationController presentModalViewController:controller animated:YES];
			return;
		}
		UIActionSheet *	actionSheet = [[[UIActionSheet  alloc] initWithTitle:@"账号绑定"
													delegate:self
										   cancelButtonTitle:@"取消"
									  destructiveButtonTitle:@"解除绑定"
										   otherButtonTitles:(BOOL)siteBindStatus[indexPath.row]?@"重新绑定":@"开始绑定",nil] autorelease];
		[actionSheet showInView:self.tableView];
	}
	else {
		UIAlertView *alertView = [[[UIAlertView alloc] initWithTitle:@"温馨提示" 
															message:@"链接错误，无法绑定"
														   delegate:nil
												  cancelButtonTitle:@"关闭"
												   otherButtonTitles:nil] autorelease];
		[alertView show];
		[self.tableView deselectRowAtIndexPath:indexPath animated:NO];
	}
	
	
}



@end
