//
//  BookObject.m
//  bookcamp
//
//  Created by lin waiwai on 2/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "BookObject.h"


@implementation BookObject

@synthesize authors = _authors;
@synthesize oid = _oid;
@synthesize thumbURL = _thumbURL;
@synthesize averageRate = _averageRate;
@synthesize bookName = _bookName;
@synthesize summary = _summary;
@synthesize authorIntro = _authorIntro;
@synthesize price = _price;
@synthesize publisher = _publisher;
@synthesize bookStatus = _bookStatus;
@synthesize pubdate = _pubdate;
@synthesize numRaters = _numRaters;
@synthesize pages = _pages;
@synthesize isbn13 = _isbn13;
@synthesize isbn10 = _isbn10;

-(void)dealloc{
	
	TT_RELEASE_SAFELY(_oid);
	TT_RELEASE_SAFELY(_thumbURL);
	TT_RELEASE_SAFELY(_averageRate);
	TT_RELEASE_SAFELY(_authors);
	TT_RELEASE_SAFELY(_bookName);
	TT_RELEASE_SAFELY(_summary);
	TT_RELEASE_SAFELY(_authorIntro);
	TT_RELEASE_SAFELY(_price);
	TT_RELEASE_SAFELY(_publisher);
	TT_RELEASE_SAFELY(_pubdate);
	TT_RELEASE_SAFELY(_numRaters);
	TT_RELEASE_SAFELY(_pages);
	TT_RELEASE_SAFELY(_isbn13);
	TT_RELEASE_SAFELY(_isbn10);
	[super dealloc];
}

-(id)initWithBookID:(NSNumber*)bookID{
	if (self = [super init]) {
		_bookStatus = Initing;
		self.oid = bookID;
	}
	return self;
}

-(id)initWithISBN13:(NSNumber*)isbnNum{
	if (self = [super init]) {
		_bookStatus = Initing;
		self.isbn13 = isbnNum;
	}
	return self;
}

-(id)initWithISBN10:(NSNumber *)isbnNum{
	if (self = [super init]) {
		_bookStatus = Initing;
		self.isbn10 = isbnNum;
	}
	return self;
}

-(void)sync{
	NSString* url;
	if (_oid) {
		url =  ApiServerDistination(book/subject/%@,(NSString*)_oid) ;
	}
	if (_isbn13) {
		url = ApiServerDistination(book/subject/isbn/%@,(NSString*)_isbn13) ;
	} else if (_isbn10) {
		url = ApiServerDistination(book/subject/isbn/%@,(NSString*)_isbn10) ;
	}


	TTURLRequest* request = [TTURLRequest
							 requestWithURL:url
							 delegate: self];
	[request setValue:@"Mozilla/5.0 (Windows; U; Windows NT 5.1; zh-CN; rv:1.9.2.3) Gecko/20100401 Firefox/3.6.3" forHTTPHeaderField:@"User-Agent"];
	[request setHttpMethod:@"GET"];
	// [request addFile:imageData mimeType:@"image/jpeg"  fileName:@"file"]; 
	TTURLJSONResponse* response = [[TTURLJSONResponse alloc] init];
	request.response = response;
	TT_RELEASE_SAFELY(response);
	[request send];
	self.bookStatus = Loading;
}

-(NSMutableArray*)authors{
	if (!_authors) {
		_authors = [[NSMutableArray alloc]initWithCapacity:1];
	}
	return _authors;
}

//- (void)hudWasHidden:(MBProgressHUD *)hud {
//    // Remove HUD from screen when the HUD was hidded
//	[hud removeFromSuperview];
//	TT_RELEASE_SAFELY(hud);
//}

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)request:(TTURLRequest*)request didFailLoadWithError:(NSError*)error {
	self.bookStatus = Fail;
	NSLog(@"%@",error);
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)requestDidFinishLoad:(TTURLRequest*)request {
	TTURLJSONResponse* response = request.response;
	NSDictionary *root = response.rootObject;
	NSDictionary *value;
	for (value in [root objectForKey:@"link"]) {
		if ([[value objectForKey:@"@rel"] isEqualToString:@"image"]) {
			self.thumbURL = [value objectForKey:@"@href"];
			break;
		}
	}
	self.averageRate = [NSNumber numberWithFloat:[[[root objectForKey:@"gd:rating"] objectForKey:@"@average"] floatValue]];
	self.oid = [NSNumber numberWithFloat:[[[[root objectForKey:@"id"] objectForKey:@"$t"] lastPathComponent] floatValue]];
	self.numRaters = [NSNumber numberWithFloat:[[[root objectForKey:@"gd:rating"] objectForKey:@"@numRaters"] floatValue]];
	self.bookName = [root valueForKeyPath:@"title.$t"];
	self.summary = [root valueForKeyPath:@"summary.$t"];
	for (NSDictionary *authorDic in [root objectForKey:@"author"]) {
		[self.authors addObject:[authorDic valueForKeyPath:@"name.$t"]];
	}
	for (value in [root objectForKey:@"db:attribute"]) {
		if ([[value objectForKey:@"@name"] isEqualToString:@"author-intro"]) {
			self.authorIntro = [value objectForKey:@"$t"];
		} else if ([[value objectForKey:@"@name"] isEqualToString:@"price"]) {
			self.price = [NSNumber numberWithFloat:[[value objectForKey:@"$t"] floatValue]] ;
		} else if ([[value objectForKey:@"@name"] isEqualToString:@"publisher"]) {
			self.publisher = [value objectForKey:@"$t"];
		} else if ([[value objectForKey:@"@name"] isEqualToString:@"pubdate"]) {
			NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
			[dateFormatter setDateFormat:@"yyyy-MM"];
			[dateFormatter setLocale:[NSLocale currentLocale]];
			self.pubdate  = [dateFormatter dateFromString:[[value objectForKey:@"$t"] stringByReplacingOccurrencesOfString:@"." withString:@"-"]];
		} else if ([[value objectForKey:@"@name"] isEqualToString:@"pages"]) {
			self.pages = [NSNumber numberWithFloat:[[value objectForKey:@"$t"] floatValue]];
		} else if ([[value objectForKey:@"@name"] isEqualToString:@"isbn13"]) {
			self.isbn13 = [NSNumber numberWithFloat:[[value objectForKey:@"$t"] floatValue]];
		} else if ([[value objectForKey:@"@name"] isEqualToString:@"isbn10"]) {
			self.isbn10 = [NSNumber numberWithFloat:[[value objectForKey:@"$t"] floatValue]];;
		}
	}
	if (!self.price) {
		self.price = [NSNumber numberWithInt:0];
	}
	self.bookStatus= Finish;
	
}

@end

















