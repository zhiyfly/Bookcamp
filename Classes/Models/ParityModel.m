//
//  ParityModel.m
//  bookcamp
//
//  Created by lin waiwai on 2/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ParityModel.h"
#import <Three20Network/Three20Network.h>
#import "extThree20XML/extThree20XML.h"
#import "CXHTMLDocument.h"
#import "TFHpple.h"
#import "BookObject.h"
#define ShopLinkAndPrice @"//table[@class='olt']//td[@class='pl2']//a"
#define Saveon  @"//table[@class='olt']//td[@class='pl2']"
#define BookPriceSearch @"//div[@id='content']//div[@class='article']//div[@class='indent']//p[@class='pl']"

@implementation ParityModel

@synthesize oid = _oid;
@synthesize parityItems = _parityItems;
@synthesize priceLabelText = _priceLabelText;

-(void)dealloc{
	TT_RELEASE_SAFELY(_parityItems);
	[super dealloc];
}

-(id)initWithBookID:(NSNumber*)oid{
	if (self = [super init]) {
		self.oid = oid;
	}
	return self;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)load:(TTURLRequestCachePolicy)cachePolicy more:(BOOL)more {
	if (!self.isLoading ) {
		NSString *distination =  [NSString stringWithFormat:@"subject/%@/buylinks?sortby=price",self.oid];
		NSString* url =  [BookServerBase stringByAppendingString:distination];
		TTURLRequest* request = [TTURLRequest
								 requestWithURL: url
								 delegate: self];
		
		//[request setValue:@"Basic N21lbno6N21lbnpfMjIxNWE=" forHTTPHeaderField:@"Authorization"];
		//[request setValue:@"iphone" forHTTPHeaderField:@"User-Mobile"];
		[request setValue:@"Mozilla/5.0 (Windows; U; Windows NT 5.1; zh-CN; rv:1.9.2.3) Gecko/20100401 Firefox/3.6.3" forHTTPHeaderField:@"User-Agent"];
		request.cachePolicy = cachePolicy;
		TTURLDataResponse* response = [[TTURLDataResponse alloc] init];
		request.response = response;
		TT_RELEASE_SAFELY(response);
		
		[request send];
	}
}

#pragma mark -
#pragma mark MBProgressHUDDelegate methods

- (void)hudWasHidden:(MBProgressHUD *)hud {
    // Remove HUD from screen when the HUD was hidded
	[hud removeFromSuperview];
	TT_RELEASE_SAFELY(hud);
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)request:(TTURLRequest*)request didFailLoadWithError:(NSError*)error {	
	id navigationController = [[[TTNavigator navigator] visibleViewController] navigationController];
	
	
	MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:[navigationController view]];
	HUD.style = TTSTYLE(progressHUDStyle);
	
	// The sample image is based on the work by www.pixelpressicons.com, http://creativecommons.org/licenses/by/2.5/ca/
	// Make the customViews 37 by 37 pixels for best results (those are the bounds of the build-in progress indicators)
	HUD.customView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"warning.png"]] autorelease];
	
	// Set custom view mode
	HUD.mode = MBProgressHUDModeCustomView;
	
	HUD.minShowTime = 2;
    // Add HUD to screen
    [[navigationController view] addSubview:HUD];
	
    // Regisete for HUD callbacks so we can remove it from the window at the right time
    HUD.delegate = [[UIApplication sharedApplication] delegate];
	
	HUD.labelText = BCLocalizedString(@"unable connect", @"unable connect") ;
	
	[HUD show:YES];
	[HUD hide:YES];
	
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)requestDidFinishLoad:(TTURLRequest*)request {
	TTURLDataResponse* response = request.response;
	//NSData *htmlData = [[NSString stringWithContentsOfURL:[NSURL URLWithString: @"http://www.objectgraph.com/contact.html"]] dataUsingEncoding:NSUTF8StringEncoding];
	TFHpple *xpathParser = [[[TFHpple alloc] initWithHTMLData:response.data] autorelease];
	NSArray *elements  = [xpathParser search:ShopLinkAndPrice];	
	TFHppleElement *priceElement = [xpathParser at:BookPriceSearch];
	self.priceLabelText = [priceElement content];
	NSMutableArray *saveOn = [NSMutableArray arrayWithCapacity:[elements count]/2];
	NSArray *saveonElement = [xpathParser search:Saveon];
	TFHppleElement *element;
	for (element in saveonElement) {
		if ([element content]) {
			[saveOn addObject:[NSNumber numberWithFloat:[[element content] floatValue]]];
		}
	}
	NSMutableDictionary *parityItem = [NSMutableDictionary dictionary];
	NSUInteger i, count = [elements count];
	for (i = 0; i < count; i++) {
		TFHppleElement * obj = [elements objectAtIndex:i];
		if (i%2) {
			//price
			[parityItem setObject:[NSNumber numberWithFloat:[[obj content] floatValue]] forKey:@"price"];
			[self.parityItems addObject:parityItem];
		} else {
			//shopname
			parityItem = [NSMutableDictionary dictionary];
			[parityItem setObject:[[obj attributes] objectForKey:@"href"] forKey:@"href"];
			[parityItem setObject:[obj content] forKey:@"shopname"];
			
			[parityItem setObject:[saveOn objectAtIndex:i/2] forKey:@"saveon"];					   
		}
	}
	[super requestDidFinishLoad:request];
}

-(NSMutableArray*)parityItems{
	if (!_parityItems) {
		_parityItems = [[NSMutableArray alloc] init];
	}
	return _parityItems;
}


@end