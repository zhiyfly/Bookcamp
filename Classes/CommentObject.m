//
//  CommentObject.m
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

#import "CommentObject.h"


@implementation CommentObject

@synthesize title = _title;
@synthesize content = _content;
@synthesize rating = _rating;
@synthesize	updated = _updated;
@synthesize votes = _votes;
@synthesize author = _author;
@synthesize commentStatus = _commentStatus;
@synthesize cid = _cid;
@synthesize unvotes = _unvotes;

-(id)initWithCommentID:(NSNumber*)cid{
	if (self = [super init]) {
		_commentStatus = Initing;
		self.cid = cid;
	}
	return self;
}

-(void)sync{
	NSString* url =  ApiServerDistination(review/%@,self.cid) ;
	TTURLRequest *request = [TTURLRequest
							 requestWithURL:url
							 delegate: self];
	[request setValue:@"Mozilla/5.0 (Windows; U; Windows NT 5.1; zh-CN; rv:1.9.2.3) Gecko/20100401 Firefox/3.6.3" forHTTPHeaderField:@"User-Agent"];
	[request setHttpMethod:@"GET"];
	TTURLJSONResponse* response = [[TTURLJSONResponse alloc] init];
	request.response = response;
	TT_RELEASE_SAFELY(response);
	[request send];
	self.commentStatus = Loading;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)request:(TTURLRequest*)request didFailLoadWithError:(NSError*)error {
	self.commentStatus = Fail;
	BCNSLog(@"%@",error);
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)observeValueForKeyPath:(NSString *)keyPath
					  ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context
{
    if ([keyPath isEqual:@"peopleStatus"]) {
  		ObjectStatusFlag peopleStatus =  (ObjectStatusFlag)[[change objectForKey:NSKeyValueChangeNewKey] intValue];
		if ( peopleStatus == Finish || peopleStatus == Fail  ){
			[self.author removeObserver:self
							  forKeyPath:@"peopleStatus"];
			self.commentStatus= Finish;
		}
    }
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)requestDidFinishLoad:(TTURLRequest*)request {
	TTURLJSONResponse* response = request.response;
	NSDictionary *root = response.rootObject;
	NSDictionary *value;
	for (value in [root valueForKeyPath:@"author.link"] ) {
		if ([[value objectForKey:@"@rel"] isEqualToString:@"self"]) {
			self.author = [[People alloc] initWithID:[NSNumber numberWithInt:[[[value objectForKey:@"@href"] lastPathComponent] intValue] ]];
			[self.author addObserver:self
				   forKeyPath:@"peopleStatus"
					  options:(NSKeyValueObservingOptionNew |
							   NSKeyValueObservingOptionOld)
					  context:NULL];
			[self.author sync];
			break;
		}
	}
	self.title = [root valueForKeyPath:@"title.$t"];

	self.rating = [NSNumber numberWithInt:[ [[root objectForKey:@"gd:rating"] objectForKey:@"@value"] intValue]*2 ];
	if (!self.content ) {
		self.content =  [root valueForKeyPath:@"summary.$t"];
	}
	
	NSString *stringDate = [root valueForKeyPath:@"updated.$t"];
	stringDate = [stringDate stringByReplacingOccurrencesOfString:@":"
													   withString:@""
														  options:0
															range:NSMakeRange(20, stringDate.length-20)];
	NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
	[dateFormatter setLocale:[[[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"] autorelease]];
	[dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZ"];
 	self.updated = [dateFormatter dateFromString:stringDate];
	self.votes = [[root objectForKey:@"db:votes"] objectForKey:@"@value"];
}



@end
