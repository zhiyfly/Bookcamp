//
//  People.m
//  bookcamp
//
//  Created by lin waiwai on 2/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
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
	[request setHttpMethod:@"GET"];
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
	NSLog(@"%@",error);
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
