//
//  People.m
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

#import "People.h"


@implementation People
@synthesize uid=_uid;
@synthesize peopleStatus = _peopleStatus;
@synthesize signature = _signature;
@synthesize avatar = _avatar;
@synthesize name=  _name;


-(id)initWithID:(NSNumber*)uid{
	if (self = [super init]) {
		self.uid = uid;
	}
	return self;
}

-(void)sync{
	NSString* url =  ApiServerDistination(people/%@,[self.uid stringValue]) ;
	TTURLRequest* request = [TTURLRequest requestWithURL:url delegate:self];
	[request setValue:@"Mozilla/5.0 (Windows; U; Windows NT 5.1; zh-CN; rv:1.9.2.3) Gecko/20100401 Firefox/3.6.3" forHTTPHeaderField:@"User-Agent"];
	//[request setHttpMethod:GET];
	TTURLJSONResponse* response = [[TTURLJSONResponse alloc] init];
	request.response = response;
	TT_RELEASE_SAFELY(response);
	[request send];
	self.peopleStatus = Loading;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)request:(TTURLRequest*)request didFailLoadWithError:(NSError*)error {
	self.peopleStatus = Fail;
	BCNSLog(@"%@",error);
}




///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)requestDidFinishLoad:(TTURLRequest*)request {
	TTURLJSONResponse* response = request.response;
	NSDictionary *root = response.rootObject;
	self.name = [root valueForKeyPath:@"title.$t"];
	self.signature = [[root objectForKey:@"db:signature"] objectForKey:@"$t"];
	NSDictionary *value;
	for (value in [root objectForKey:@"link"]) {
		if ([[value objectForKey:@"@rel"] isEqualToString:@"icon"]) {
			self.avatar = [value objectForKey:@"@href"];
			break;
		}
	}
	self.peopleStatus= Finish;
	
}


@end
