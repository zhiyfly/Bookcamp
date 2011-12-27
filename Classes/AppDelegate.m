//
//  bookcampAppDelegate.m
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
#import "AppDelegate.h"
#import "RootViewController.h"
#import "BindsViewController.h"

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
@implementation AppDelegate

@synthesize reader;

-(ReaderViewController *)reader{
	if (!reader) {
		reader = [ReaderViewController new];
		reader.readerDelegate = self;
	
		// use a custom overlay
		reader.showsZBarControls = NO;
		overlay = [ReaderOverlayView new];
		overlay.delegate = self;
			
		ZBarImageScanner *scanner = reader.scanner;
	
		// show EAN variants as such
		[scanner setSymbology: ZBAR_UPCA
					   config: ZBAR_CFG_ENABLE
						   to: 1];
		[scanner setSymbology: ZBAR_UPCE
					   config: ZBAR_CFG_ENABLE
						   to: 1];
		[scanner setSymbology: ZBAR_ISBN13
					   config: ZBAR_CFG_ENABLE
						   to: 1];
	
		// disable rarely used i2/5 to improve performance
		[scanner setSymbology: ZBAR_I25
					   config: ZBAR_CFG_ENABLE
						   to: 0];

	}
	return reader;
}


#ifdef enableUmeng
- (void)applicationWillResignActive:(UIApplication *)application {
	[MobClick appTerminated];
}- (void)applicationWillEnterForeground:(UIApplication *)application {
	[MobClick setDelegate:self];
	[MobClick appLaunched];
} 

- (void)applicationWillTerminate:(UIApplication *)application{
		[MobClick appTerminated];
}

//- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{

	

	//}
//}


- (NSString *)appKey{
#error fill the umeng app key;
	return @"";
} 
#endif

/////////////////////////////////////////////////////////////////////////////////////////////////
- (void)applicationDidFinishLaunching:(UIApplication *)application {
	
	/*
	 #if !TARGET_IPHONE_SIMULATOR
	 [application registerForRemoteNotificationTypes:
	 UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound];
	 #endif
	 
	 */
	TTNavigator* navigator = [TTNavigator navigator];
	navigator.delegate = self;
	navigator.persistenceMode = TTNavigatorPersistenceModeAll;
	
	TTURLMap* map = navigator.URLMap;
	GlobalStyleSheet* styleSheet = [[GlobalStyleSheet alloc] init];
	[styleSheet addStyleSheetFromDisk:TTPathForBundleResource(@"stylesheet.css")];
	[TTStyleSheet setGlobalStyleSheet:styleSheet];
	TT_RELEASE_SAFELY(styleSheet);
	[map from:@"*" toViewController:[TTWebController class] transition:1 ];
	
	//主页
	[map from:@"tt://test/" toViewController:[TestViewController class]];
	[map from:@"tt://root/" toSharedViewController:[RootViewController class]];
	[map from:@"tt://root/#(selectedTab:)" toSharedViewController:[RootViewController class]];
	[map from:@"tt://comment/(initWithCommentID:)" toViewController:[CommentViewController class] transition:6];
	[map from:@"tt://comments/(initWithBookID:)" toViewController:[CommentsViewController class] transition:6];
	[map from:@"tt://scanFromCamera" toModalViewController:self selector:@selector(scanFromCamera)];
	//#ifdef BCDebug
	//	[map from:@"tt://scanFromCamera" toObject:self selector:@selector(scanFromCamera)];
	//#endif
	[map from:@"tt://detail" toViewController:[DetailViewController class]];
	[map from:@"tt://cart/(initWithBookID:)" toViewController:[CartViewController class] transition:6];
	[map from:@"tt://cart/isbn10/(initWithISBN10:)" toViewController:[CartViewController class]];
	[map from:@"tt://cart/isbn13/(initWithISBN13:)" toViewController:[CartViewController class]];
	[map from:@"tt://book/(initWithBookID:)" toViewController:[BookViewController class]];
	[map from:@"tt://book/(initWithISBN13:)/(fromScan:)" toViewController:[BookViewController class]];
	[map from:@"tt://author/(initWithBook:)" toViewController:[AuthorViewController class] transition:6];
	[map from:@"tt://binds" toViewController:[BindsViewController class]];
	
	[map from:[BookObject class] name:@"author" toURL:@"tt://author/(oid)"];
	[map from:[BookObject class] name:@"comments" toURL:@"tt://comments/(oid)"];
	[map from:[BookObject class] name:@"cart" toURL:@"tt://cart/(oid)"];
	
	
	//if (![navigator restoreViewControllers]) {
	//	[navigator openURLAction:[TTURLAction actionWithURLPath:@"tt://cart/5363767"]];
	//	[navigator openURLAction:[TTURLAction actionWithURLPath:@"tt://cart/isbn13/9787229030933"]];
	//[navigator openURLAction:[TTURLAction actionWithURLPath:@"tt://comment/4506490"]];
	[navigator openURLAction:[TTURLAction actionWithURLPath:@"tt://root/"]];
#ifdef enableUmeng
	[MobClick setDelegate:self];
	[MobClick appLaunched]; 
#endif
#ifndef NO_AD
	splashInterstitial_ = [[GADInterstitial alloc] init];
	
	splashInterstitial_.adUnitID = MY_BANNER_UNIT_ID;
	splashInterstitial_.delegate = self;
	
	GADRequest *request = [GADRequest request];

#ifdef BCDebug 
	request.testDevices = [NSArray arrayWithObjects:
						   GAD_SIMULATOR_ID,                               // Simulator
						   @"28ab37c3902621dd572509110745071f0101b124",    // Test iPhone 3G 3.0.1
						   @"8cf09e81ef3ec5418c3450f7954e0e95db8ab200",    // Test iPod 4.3.1
						   nil];
#endif
	
	[splashInterstitial_ loadAndDisplayRequest:request
								   usingWindow:navigator.window
								  initialImage:[UIImage imageNamed:@"Default.png"]];
#endif
	
}



-(BOOL)canScan:(NSInteger)src{
	return [UIImagePickerController isSourceTypeAvailable: src];
}

// ZBarReaderDelegate

- (void)  imagePickerController: (UIImagePickerController*) picker
  didFinishPickingMediaWithInfo: (NSDictionary*) info
{
	// the image get from the scan reader
    UIImage *image = [info objectForKey: UIImagePickerControllerOriginalImage];
	
    id <NSFastEnumeration> results = [info objectForKey: ZBarReaderControllerResults];
    ZBarSymbol *sym = nil;
	//遍历到最后一个元素
    for(sym in results)
        break;
    assert(sym);
    assert(image);
    if(!sym || !image)
        return;
	
	//current time
    [NSDate date];

	
   [NSNumber numberWithInteger: sym.type];
	// the scaned barcode
	BCNSLog(sym.data);
	
	TTOpenURL([NSString stringWithFormat:@"tt://book/%@/YES",sym.data]);

    [overlay willDisappear];
	/*
    if(picker.sourceType == UIImagePickerControllerSourceTypeCamera)
        [self performSelector: @selector(playBeep)
				   withObject: nil
				   afterDelay: 0.01];
	*/
	
}




-(ReaderViewController*)scan:(NSInteger) src{
	self.reader.sourceType = src;
	if(src == UIImagePickerControllerSourceTypeCamera) {
		self.reader.showsCameraControls = NO;
		[overlay setMode: OVERLAY_MODE_CANCEL];
		self.reader.cameraOverlayView = overlay;
		[overlay willAppear];
	}
	//self.reader.title = BCLocalizedString(@"ScanViewControllerTitle", @"the title of scanViewControllerTitle");
	
	return reader;

}


- (ReaderViewController*) scanFromCamera
{
//#ifdef BCDebug
//	TTOpenURL(@"tt://book/9787543639133/YES");
//	return nil;
//#endif
    return [self scan: UIImagePickerControllerSourceTypeCamera];
	
}

// ReaderOverlayDelegate

- (void) readerOverlayDidDismiss
{
    [overlay willDisappear];
	
    [reader dismissModalViewControllerAnimated: YES];
	//TTOpenURL(@"tt://root/#1");
 	TTViewController *controller = [[TTNavigator navigator] viewControllerForURL:@"tt://root/#1"];
	[[controller tabBar] setSelectedTabIndex:1];
}

- (void) readerOverlayDidRequestHelp
{
    [overlay willDisappear];

    [reader showHelpWithReason: @"INFO"];
}


-(void)cleanup:(BOOL) force{
	if(force || !reader.parentViewController) {
        [overlay release];
        overlay = nil;
        [reader release];
        reader = nil;
      //  [beep release];
      //  beep = nil;
    }
}
- (void)navigator:(TTBaseNavigator*)navigator willOpenURL:(NSURL*)URL
	inViewController:(UIViewController*)controller{
	if ([controller isKindOfClass:[TTWebController class]]) {
		[[[TTNavigator navigator] visibleViewController] navigationController].navigationBarHidden = NO;
	} else {
		[[[TTNavigator navigator] visibleViewController] navigationController].navigationBarHidden = YES;
	}

}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (BOOL)navigator:(TTNavigator*)navigator shouldOpenURL:(NSURL*)URL {
  return YES;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (BOOL)application:(UIApplication*)application handleOpenURL:(NSURL*)URL {
  [[TTNavigator navigator] openURLAction:[TTURLAction actionWithURLPath:URL.absoluteString]];
  return YES;
}


/*

#pragma mark -
#pragma mark Remote notifications

#define serverTokenSave @"http://api.iwaiwai.org/deviceToken/save"

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
	// You can send here, for example, an asynchronous HTTP request to your web-server to store this deviceToken remotely.
	TTURLRequest *request = [TTURLRequest requestWithURL:@"" delegate:self];
	request.httpMethod = "POST";
	request.cachePolicy = TTURLRequestCachePolicyNone;
	request.response = [[[TTURLJSONResponse alloc] init] autorelease];
	[request.parameters setObject:[NSString stringWithFormat:@"%@",deviceToken] forKey:@"deviceToken"];
	
	[request send];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
	NSLog(@"Fail to register for remote notifications: %@", error);
}
///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)request:(TTURLRequest*)request didFailLoadWithError:(NSError*)error {
	NSLog(@"%@",error);
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)requestDidFinishLoad:(TTURLRequest*)request {
	TTURLJSONResponse* response = request.response;
	NSLog(response.rootObject);
}
*/

- (void)hudWasHidden:(MBProgressHUD *)hud {
    // Remove HUD from screen when the HUD was hidded
	[hud removeFromSuperview];
	TT_RELEASE_SAFELY(hud);
}

-(void)dealloc{
#ifndef NO_AD
	splashInterstitial_.delegate = nil;
	
	[splashInterstitial_ release];
#endif
	[super dealloc];
}

- (void)interstitial:(GADInterstitial *)interstitial
didFailToReceiveAdWithError:(GADRequestError *)error {
	BCNSLog(@"InterstitialExampleAppDelegate."
		  "interstitial:didFailToReceiveAdWithError:%@",
		  [error localizedDescription]);
}

- (void)interstitialDidReceiveAd:(GADInterstitial *)interstitial {
	BCNSLog(@"InterstitialExampleAppDelegate."
		  "interstitialDidReceiveAd:");
}

@end
