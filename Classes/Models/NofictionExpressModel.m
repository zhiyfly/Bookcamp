//
//  NofictionExpressModel.m
//  bookcamp
//
//  Created by lin waiwai on 2/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "NofictionExpressModel.h"
#import <Three20Network/Three20Network.h>
#import "extThree20XML/extThree20XML.h"
#import "CXHTMLDocument.h"
#import "TFHpple.h"
#import "BookObject.h"
#define DoubanLatestBookPath @"//div[@id='glide2']//li//a" //div[@id='glide1']//div[@class='detail-frame']//h2 | 
@implementation NofictionExpressModel

@synthesize books = _books;

static int numLatestBook=0;
-(void)dealloc{
	TT_RELEASE_SAFELY(_books);
	[super dealloc];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)load:(TTURLRequestCachePolicy)cachePolicy more:(BOOL)more {
	if (!self.isLoading ) {
		NSString* url = BookServerBase;
		TTURLRequest* request = [TTURLRequest
								 requestWithURL: url
								 delegate: self];
		[request setValue:@"Mozilla/5.0 (Windows; U; Windows NT 5.1; zh-CN; rv:1.9.2.3) Gecko/20100401 Firefox/3.6.3" forHTTPHeaderField:@"User-Agent"];
		request.cachePolicy = cachePolicy;
		TTURLDataResponse* response = [[TTURLDataResponse alloc] init];
		request.response = response;
		TT_RELEASE_SAFELY(response);
		
		[request send];
	}
}

///////////////////////////////////////////////////////////////////////////////////////////////////
-(NSMutableArray*)books{
	if (!_books) {
		_books = [[NSMutableArray alloc] initWithCapacity:numLatestBook];
	}
	return _books;
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

- (void)observeValueForKeyPath:(NSString *)keyPath
					  ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context
{
    if ([keyPath isEqual:@"bookStatus"]) {
  		ObjectStatusFlag bookStatus =  (ObjectStatusFlag)[[change objectForKey:NSKeyValueChangeNewKey] intValue];
		if ( bookStatus == Finish || bookStatus == Fail  ){
			numLatestBook--;
			if ( bookStatus == Fail) {
				[self.books removeObject:object];
			}
			if (!numLatestBook) {
				[object removeObserver:self
							forKeyPath:@"bookStatus"];
				[ModelLocator sharedInstance].latestNonfictionBooks = self.books;
			}
		}
    }
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)requestDidFinishLoad:(TTURLRequest*)request {
	TTURLDataResponse* response = request.response;
	//NSData *htmlData = [[NSString stringWithContentsOfURL:[NSURL URLWithString: @"http://www.objectgraph.com/contact.html"]] dataUsingEncoding:NSUTF8StringEncoding];
	TFHpple *xpathParser = [[[TFHpple alloc] initWithHTMLData:response.data] autorelease];
	NSArray *elements  = [xpathParser search:DoubanLatestBookPath]; // get the page title - this is xpath notation
	numLatestBook = [elements count];
#ifdef BCDebug
	static int f = 3;
	numLatestBook = f;
#endif
	TFHppleElement *element;
	BookObject *book;
	for (element in elements) {
		if ([[element tagName] isEqualToString:@"a"]){
			NSNumber *bookID = [NSNumber numberWithInt: [[[[element attributes] objectForKey:@"href"] lastPathComponent] intValue]] ;
			book = [[[BookObject alloc] initWithBookID:bookID] autorelease];
			//the observer must be before the sync.
			[book addObserver:self
				   forKeyPath:@"bookStatus"
					  options:(NSKeyValueObservingOptionNew |
							   NSKeyValueObservingOptionOld)
					  context:NULL];
			[book sync];
			[self.books addObject:book];
#ifdef BCDebug
			f--;
			if (f==0) {
				break;
			}
#endif
		}
	}
	[super requestDidFinishLoad:request];
}




@end