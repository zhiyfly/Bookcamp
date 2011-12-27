//
//  CommentModel.m
//  bookcamp
//
//  Created by lin waiwai on 2/13/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CommentModel.h"
#import <Three20Network/Three20Network.h>
#import "extThree20XML/extThree20XML.h"
#import "CXHTMLDocument.h"
#import "TFHpple.h"
#import "BookObject.h"
#define CommentContentSearch @"//div[@class='piir']//span[@property='v:description']"
#define ComenntUnVote @"//em[@id='ucount%@l']"
@implementation CommentModel

@synthesize cid=_cid;
@synthesize comment = _comment;

-(void)dealloc{
	TT_RELEASE_SAFELY (_comment);
	[super dealloc];
}

-(id)initWithCommentID:(NSNumber*)cid{
	if (self = [super init]) {
		self.cid = cid;
	}
	return self;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)load:(TTURLRequestCachePolicy)cachePolicy more:(BOOL)more {
	if (!self.isLoading ) {
		NSString* url = [NSString stringWithFormat:@"%@%@/" ,BookServerDistination(review/) , self.cid];
		_request = [TTURLRequest requestWithURL: url delegate: self];
		[_request setValue:@"Mozilla/5.0 (Windows; U; Windows NT 5.1; zh-CN; rv:1.9.2.3) Gecko/20100401 Firefox/3.6.3" forHTTPHeaderField:@"User-Agent"];
		_request.cachePolicy = cachePolicy;
		TTURLDataResponse* response = [[TTURLDataResponse alloc] init];
		_request.response = response;
		TT_RELEASE_SAFELY(response);
		
		[_request send];
		
	}
}

-(CommentObject*)comment{
	if (!_comment) {
		_comment = [[CommentObject alloc] initWithCommentID:self.cid];
	}
	return _comment;
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
- (void)observeValueForKeyPath:(NSString *)keyPath
					  ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context
{
    if ([keyPath isEqual:@"commentStatus"]) {
  		ObjectStatusFlag commentStatus =  (ObjectStatusFlag)[[change objectForKey:NSKeyValueChangeNewKey] intValue];
		if ( commentStatus == Finish || commentStatus == Fail  ){
			[self.comment removeObserver:self
								forKeyPath:@"commentStatus"];
			[super requestDidFinishLoad:_request];
		}
    }
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)requestDidFinishLoad:(TTURLRequest*)request {
	TTURLDataResponse* response = request.response;
	//NSData *htmlData = [[NSString stringWithContentsOfURL:[NSURL URLWithString: @"http://www.objectgraph.com/contact.html"]] dataUsingEncoding:NSUTF8StringEncoding];
	TFHpple *xpathParser = [[[TFHpple alloc] initWithHTMLData:response.data] autorelease];
	TFHppleElement *reviewContent  = [xpathParser at:CommentContentSearch]; // get the page title - this is xpath notation
	TFHppleElement *unVote = [xpathParser at:[NSString stringWithFormat:ComenntUnVote,self.cid]];
	

	
	self.comment.content = [reviewContent content];
	self.comment.unvotes = [NSNumber numberWithInt: [[unVote content] intValue]];
	
	//the observer must be before the sync.
	[self.comment addObserver:self
		   forKeyPath:@"commentStatus"
			  options:(NSKeyValueObservingOptionNew |
					   NSKeyValueObservingOptionOld)
			  context:NULL];
	
	[self.comment sync];


}



@end
