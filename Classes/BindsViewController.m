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


@implementation BindsViewController


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)dealloc {

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

	inReBinding = NO;
	[self loadData];
}

-(void)loadData{
	NSUInteger i;
	for (i=0; i < SnsCount; i++) {
        
		siteBindStatus[i] = siteBindStatusUnKnown;
		
        NSError *error = nil;
		NSString *uid =[UMSNSService  getUid:UMENG_KEY andForPlatform:(UMShareToType)i error:error];
		NSMutableDictionary *authData = [NSMutableDictionary dictionaryWithDictionary: [[NSUserDefaults standardUserDefaults] objectForKey: @"authData"]];
		NSDictionary *bindInfo = [authData objectForKey:(NSString*)connectedSiteStr[i]];
        
		if ( bindInfo ) {
			siteBindStatus[i] = 1;
		} else {
			siteBindStatus[i] = 0;
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
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (BOOL)shouldOpenURL:(NSString*)URL {
	return NO;
}

//- (UITableViewCellSelectionStyle)tableSelectionStyle {
//    return UITableViewCellSelectionStyleBlue;
//}


- (void)oauthDidFinish:(NSString *)uid andAccessToken:(NSDictionary *)accessToken andPlatformType:(UMShareToType)platfrom{
    NSError *error;
    
    NSString *currentUid = [UMSNSService getUid:UMENG_KEY andForPlatform:(UMShareToType)platfrom error:nil];
    
    
	BookViewController *bookViewController = [TTNavigator navigator].visibleViewController ;
    shareToType = platfrom;
    if (currentUid) {
        
         //sync the info
		NSMutableDictionary *authData = [NSMutableDictionary dictionaryWithDictionary: [[NSUserDefaults standardUserDefaults] objectForKey: @"authData"]];

		if (!authData) {
			authData  = [NSMutableDictionary dictionary];
		}
      
        NSDictionary  *bindInfo =  [NSDictionary dictionaryWithObject:[NSNumber numberWithInt:HasBound] forKey:@"BindStatus"];        
        [authData setObject:bindInfo forKey:(NSString*)connectedSiteStr[shareToType]];
        [[NSUserDefaults standardUserDefaults] setValue:authData forKey:@"authData"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [[Factory sharedInstance] triggerWarning:(NSString*)BCLocalizedString(@"binding successfull", @"binding successfull") ];
        [self loadData];
        
    } 
}


 
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{

	BindsViewController *currentViewController = [TTNavigator navigator].visibleViewController ;	
	UIViewController *controller ;
    NSMutableDictionary *authData = [NSMutableDictionary dictionaryWithDictionary: [[NSUserDefaults standardUserDefaults] objectForKey: @"authData"]];
    if (!authData) {
        authData  = [NSMutableDictionary dictionary];
    }
    
    NSDictionary *bindInfo = [authData objectForKey:(NSString*)connectedSiteStr[shareToType]];
	switch (buttonIndex) {
		//解除绑定
		case 0:
            
            if ( bindInfo && ![bindInfo isKindOfClass:[NSNull class]]) {
                [authData removeObjectForKey:connectedSiteStr[(UMShareToType)shareToType]];
                [[NSUserDefaults standardUserDefaults] setValue:authData forKey:@"authData"];
                [[NSUserDefaults standardUserDefaults] synchronize];
				
				[UMSNSService writeOffAccounts:(UMShareToType)shareToType];
				[self loadData];
            } else {
                return;
            }
            
            break;
		//重新绑定
		case 1:
            //go to oauth
            
            [UMSNSService setDataSendDelegate:self];
            [UMSNSService setOauthDelegate:self];
            switch (shareToType) {
                case UMShareToTypeRenr:
                    [UMSNSService oauthRenr:currentViewController andAppkey:UMENG_KEY];
                    
                    break;
                case UMShareToTypeSina:
                    [UMSNSService oauthSina:currentViewController andAppkey:UMENG_KEY];  
                    
                    break;
                case UMShareToTypeTenc:
                    [UMSNSService oauthTenc:currentViewController andAppkey:UMENG_KEY];   
            }
            
             
			inReBinding = YES;
            
			
            break;
		//取消
		case 2:
		default:
			break;
	}
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:NO];
}

 
///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)didSelectObject:(id)object atIndexPath:(NSIndexPath*)indexPath {
	
	//绑定设置
    shareToType  = indexPath.row;
	if (siteBindStatus[indexPath.row] != siteBindStatusUnKnown) {
		//go straight to bindSettingView
		if (siteBindStatus[indexPath.row] == 0) {
			BindsViewController *currentViewController = [TTNavigator navigator].visibleViewController ;	
			[UMSNSService setDataSendDelegate:self];
            [UMSNSService setOauthDelegate:self];
            switch (shareToType) {
                case UMShareToTypeRenr:
                    [UMSNSService oauthRenr:currentViewController andAppkey:UMENG_KEY];
                    
                    break;
                case UMShareToTypeSina:
                    [UMSNSService oauthSina:currentViewController andAppkey:UMENG_KEY];  
                    
                    break;
                case UMShareToTypeTenc:
                    [UMSNSService oauthTenc:currentViewController andAppkey:UMENG_KEY];   
            }
            
			
			inReBinding = YES;
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
