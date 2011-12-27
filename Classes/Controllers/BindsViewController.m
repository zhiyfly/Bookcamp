//
//  BindsViewController.m
//  BengXin
//
//  Created by lin waiwai on 1/22/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "BindsViewController.h"
 
@implementation BindsViewController

#define siteBindStatusUnKnown -1

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)dealloc {
    [super dealloc];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
		inReBinding = NO;
		NSUInteger i;
		for (i=0; i < SnsCount; i++) {
			siteBindStatus[i] = siteBindStatusUnKnown;
		}
			BookListDataSource* dataSource = [[[BookListDataSource alloc] init] autorelease];
		for (int i = 0; i < [connectedSite count]; ++i) {	
			[dataSource.items addObject:[BXTableSubtitleItem itemWithText:connectedSiteStr[i]
																 subtitle:siteBindStatus[i] == siteBindStatusUnKnown? BCLocalizedString(@"unknown bind status", @"unknown bind status")  : bindTipStr(YES)
																 imageURL:[[@"bundle://" stringByAppendingString:
																			[connectedSite objectAtIndex:i]] stringByAppendingString:@".png"]
															 defaultImage:nil
																	  URL:nil accessoryURL:nil]];
			
		}
		self.dataSource = dataSource;		
	}
	return self;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark BXAPIDelegate
/*
///////////////////////////////////////////////////////////////////////////////////////////////////
- (void) onReturn:(NSInteger)reqIndex
		   status:(NSUInteger)theStatus
		   result:(NSDictionary*)theResult{
	if(BXRequestSuccessUpdated == theStatus && [ [theResult objectForKey:@"status"] isEqualToString:@"success"])
	{
		if(Sync_getBindStatus == reqIndex){
			NSUInteger i;
			for (i=0; i<SnsCount; i++) {
				siteBindStatus[i] = [[theResult objectForKey:[connectedSite objectAtIndex:i]] intValue];
			}
			BXListDataSource* dataSource = [[[BXListDataSource alloc] init] autorelease];
			for (int i = 0; i < [connectedSite count]; ++i) {	
				[dataSource.items addObject:[BXTableSubtitleItem itemWithText:connectedSiteStr[i]
																	 subtitle:siteBindStatus[i] == siteBindStatusUnKnown? @"未知绑定状态" : bindTipStr(siteBindStatus[i])
																	 imageURL:[[@"bundle://" stringByAppendingString:
																				[connectedSite objectAtIndex:i]] stringByAppendingString:@".png"]
																 defaultImage:nil
																		  URL:nil accessoryURL:nil]];
				
			}
			self.dataSource = dataSource;
		} else if (Sync_delete == reqIndex) {
			[[BXNetwork GetInstance] sendRequest:0 RequestType:Sync_getBindStatus 
											 Par:[NSArray arrayWithObject:[NSString stringWithFormat:@"%d", [ BXDataManager GetInstance].mainUser.ID]] delegate:self];
		}
	} else if (BXRequestFailNetworkError== theStatus) {
		
	}
	
}
*/
///////////////////////////////////////////////////////////////////////////////////////////////////
-(void)viewWillAppear:(BOOL)animated{
	[super viewWillAppear:animated];
	inReBinding = NO;
	
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (BOOL)shouldOpenURL:(NSString*)URL {
	return NO;
}

- (UITableViewCellSelectionStyle)tableSelectionStyle {
    return UITableViewCellSelectionStyleBlue;
}
/*
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
	BindsViewController *settingVewController;
	switch (buttonIndex) {
		//解除绑定
		case 0:
			NSUserDefaults	*defaults = [NSUserDefaults standardUserDefaults];
			[defaults removeObjectForKey: @"authData"];
			[defaults synchronize];
			break;
		//重新绑定
		case 1:
			BindsViewController *currentViewController = [TTNavigator navigator].visibleViewController ;
			UIViewController *controller = [OAuthController controllerToEnterCredentialsWithEngine: self.engine delegate: self];
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

*/
//=============================================================================================================================
#pragma mark OAuthEngineDelegate
#pragma mark save the user info 

- (void) storeCachedOAuthData: (NSString *) data forUsername: (NSString *) username {
	NSUserDefaults			*defaults = [NSUserDefaults standardUserDefaults];
	
	[defaults setObject: data forKey: @"authData"];
	[defaults synchronize];
}
/*
- (NSString *) cachedOAuthDataForUsername: (NSString *) username {
	if (inRebinding) {
		return nil;
	}
	return [[NSUserDefaults standardUserDefaults] objectForKey: @"authData"];
}
*/
- (void)removeCachedOAuthDataForUsername:(NSString *) username{
	NSUserDefaults			*defaults = [NSUserDefaults standardUserDefaults];
	
	[defaults removeObjectForKey: @"authData"];
	[defaults synchronize];
}
/*
///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)didSelectObject:(id)object atIndexPath:(NSIndexPath*)indexPath {
	
	//绑定设置
	if (siteBindStatus[indexPath.row] != siteBindStatusUnKnown) {
		//go straight to bindSettingView
		if (siteBindStatus[indexPath.row] == 0) {
			BindSettingViewController *settingVewController = [[BindSettingViewController alloc] initWithNibName:nil bundle:nil];
			[settingVewController setUsername:@""  password:@""  forSite:indexPath.row];
			[self.navigationController pushViewController:settingVewController animated:YES];
			return;
		}
		UIActionSheet *	actionSheet = [[[UIActionSheet  alloc] initWithTitle:STRING_BINDHELPERTITLE
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
*/


@end
