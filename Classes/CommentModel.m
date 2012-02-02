//
//  CommentModel.m
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
        //TODO:when the cachePolicy is not nocache ,the app crash .fix it
		_request.cachePolicy = TTURLRequestCachePolicyNoCache;
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



///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)request:(TTURLRequest*)request didFailLoadWithError:(NSError*)error {	

		
	[[Factory sharedInstance] triggerWarning:BCLocalizedString(@"unable connect", @"unable connect") ];
		
	
	
	
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
