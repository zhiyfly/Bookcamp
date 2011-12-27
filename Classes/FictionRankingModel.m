//
//  FictionRankingModel.m
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

#import "FictionRankingModel.h"
#import "NofictionExpressModel.h"
#import <Three20Network/Three20Network.h>
#import "extThree20XML/extThree20XML.h"
#import "CXHTMLDocument.h"
#import "TFHpple.h"
#import "BookObject.h"
#define DoubanLatestBookPath @"//ul[@class='chart-dashed-list']//li[@class='clearfix']//p[@class='clearfix cover']//a"
@implementation FictionRankingModel

@synthesize books = _books;

static int numLatestBook=0;

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)load:(TTURLRequestCachePolicy)cachePolicy more:(BOOL)more {
	
	if (!self.isLoading ) {
		
		NSString* url = [BookServerDistination(chart) stringByAppendingString:@"?subcat=F"];

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

///////////////////////////////////////////////////////////////////////////////////////////////////
-(NSMutableArray*)books{
	if (!_books) {
		_books = [[NSMutableArray alloc] initWithCapacity:numLatestBook];
	}
	return _books;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)request:(TTURLRequest*)request didFailLoadWithError:(NSError*)error {		
	
	[[Factory sharedInstance] triggerWarning:BCLocalizedString(@"unable connect", @"unable connect") ];
	
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
				[ModelLocator sharedInstance].rankingFictionBooks = self.books;
			}
		}
    }
    // be sure to call the super implementation
    // if the superclass implements it
	
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
	for (element in elements) {
		if ([[element tagName] isEqualToString:@"a"]){
			NSNumber *bookID = [NSNumber numberWithInt: [[[[element attributes] objectForKey:@"href"] lastPathComponent] intValue]] ;
			BookObject *book = [[[BookObject alloc] initWithBookID:bookID] autorelease];
			[self.books addObject:book];
			//the observer must be before the sync.
			[book addObserver:self
				   forKeyPath:@"bookStatus"
					  options:(NSKeyValueObservingOptionNew |
							   NSKeyValueObservingOptionOld)
					  context:NULL];
			[book sync];
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