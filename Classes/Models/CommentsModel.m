//
//  CommentsModel.m
//  bookcamp
//
//  Created by lin waiwai on 2/13/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CommentsModel.h"
#import <Three20Network/Three20Network.h>
#import "extThree20XML/extThree20XML.h"
#import "CXHTMLDocument.h"
#import "TFHpple.h"
#import "BookObject.h"

@implementation CommentsModel
@synthesize oid=_oid;

@synthesize allComments = _allComments;
@synthesize goodComments = _goodComments;
@synthesize badComments = _badComments;

-(void)dealloc{
	TT_RELEASE_SAFELY(_allComments);
	TT_RELEASE_SAFELY(_goodComments);
	TT_RELEASE_SAFELY(_badComments);
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
		NSInteger start;
		if ([self.allComments count] > 0 && [[self.allComments lastObject] isKindOfClass:[TTTableMoreButton class]] ) {
			start = [self.allComments count] - 1;
		} else {
			start = 0;
		}
		NSString* url = [NSString stringWithFormat: 
						 [ApiServerDistination(book/subject/%@/reviews,self.oid) stringByAppendingString:@"&start-index=%d&max-results=10"] ,
						 [self.allComments count]];
//		NSLog(url);
		TTURLRequest* request = [TTURLRequest requestWithURL: url delegate: self];
		[request setValue:@"Mozilla/5.0 (Windows; U; Windows NT 5.1; zh-CN; rv:1.9.2.3) Gecko/20100401 Firefox/3.6.3" forHTTPHeaderField:@"User-Agent"];
		request.cachePolicy = cachePolicy;
		TTURLJSONResponse* response = [[TTURLJSONResponse alloc] init];
		request.response = response;
		TT_RELEASE_SAFELY(response);
		
		[request send];
	}
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

#define GoodCommentScore 5
///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)requestDidFinishLoad:(TTURLRequest*)request {
	TTURLJSONResponse* response = request.response;
	NSArray *entrys = [response.rootObject objectForKey:@"entry"];
	if ([self.allComments count] > 0 && [[self.allComments lastObject] isKindOfClass:[TTTableMoreButton class]]) {
		[self.allComments removeLastObject];
		[self.goodComments removeLastObject];
		[self.badComments removeLastObject];
	}
	for (NSDictionary *entry in entrys) {
		NSString *linkStr = @"";
		for (NSDictionary *link in [entry objectForKey:@"link"] ) {
			if ([[link objectForKey:@"@rel"] isEqualToString:@"self"]) {
				linkStr = [@"tt://comment/" stringByAppendingString: [[link objectForKey:@"@href"] lastPathComponent] ];
				break;
			}
		}
		[self.allComments addObject:
			[TableCommentItem itemWithTitle:[entry valueForKeyPath:@"title.$t"] caption:nil 
									text:[entry valueForKeyPath:@"summary.$t"]
								  rating:[NSNumber numberWithFloat:[[[entry objectForKey:@"gd:rating"] objectForKey:@"@value"] floatValue]*2]
							   timestamp:nil URL:linkStr]];
		if ([[[entry objectForKey:@"gd:rating"] objectForKey:@"@value"] floatValue]*2 > GoodCommentScore) {
			[self.goodComments addObject:
			 [TableCommentItem itemWithTitle:[entry valueForKeyPath:@"title.$t"] caption:nil 
										 text:[entry valueForKeyPath:@"summary.$t"]
									   rating:[NSNumber numberWithFloat:[[[entry objectForKey:@"gd:rating"] objectForKey:@"@value"] floatValue]*2]
									timestamp:nil URL:linkStr]];
		}else {
			[self.badComments addObject:
			 [TableCommentItem itemWithTitle:[entry valueForKeyPath:@"title.$t"] caption:nil 
										 text:[entry valueForKeyPath:@"summary.$t"]
									   rating:[NSNumber numberWithFloat:[[[entry objectForKey:@"gd:rating"] objectForKey:@"@value"] floatValue]*2]
									timestamp:nil URL:linkStr]];
		}
	}
	if ([[response.rootObject valueForKeyPath:@"opensearch:totalResults.$t"] intValue] - [self.allComments count] > 0) {
		[self.allComments addObject:[TTTableMoreButton itemWithText:BCLocalizedString(@"load more", @"load more")]];
		[self.goodComments addObject:[TTTableMoreButton itemWithText:BCLocalizedString(@"load more", @"load more")]];
		[self.badComments addObject:[TTTableMoreButton itemWithText:BCLocalizedString(@"load more", @"load more")]];
	}
	

	
	[super requestDidFinishLoad:request];
}


-(NSMutableArray*)allComments{
	if (!_allComments) {
		_allComments = [[NSMutableArray alloc] init];
	}
	return _allComments;
}

-(NSMutableArray*)goodComments{
	if (!_goodComments) {
		_goodComments = [[NSMutableArray alloc] init];
	}
	return _goodComments;
}

-(NSMutableArray*)badComments{
	if (!_badComments) {
		_badComments = [[NSMutableArray alloc] init];
	}
	return _badComments;
}




@end
