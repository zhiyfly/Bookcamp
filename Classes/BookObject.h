//
//  BookObject.h
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

#import <UIKit/UIKit.h>

#import "MBProgressHUD.h"

@interface BookObject :NSObject  <TTURLRequestDelegate>{
	NSNumber *_isbn13;
	NSNumber *_isbn10;
	NSNumber *_oid;
	NSString *_thumbURL;
	NSNumber *_averageRate;
	NSString *_bookName;
	NSString *_summary;
	NSMutableArray *_authors;
	NSString *_authorIntro;
	NSNumber *_price;
	NSString *_publisher;
	NSDate *_pubdate;
	NSNumber *_numRaters;
	NSNumber *_pages;
	
	ObjectStatusFlag _bookStatus;
}

@property (nonatomic, retain) NSNumber *isbn13;
@property (nonatomic, retain) NSNumber *isbn10;
@property (nonatomic, retain) NSNumber *pages;
@property (nonatomic, retain) NSNumber *numRaters;
@property (nonatomic, retain) NSDate *pubdate;
@property (nonatomic)ObjectStatusFlag bookStatus;
@property (nonatomic, retain) NSNumber *oid;
@property (nonatomic, retain) NSString *thumbURL;
@property (nonatomic, retain) NSNumber *averageRate;
@property (nonatomic, retain) NSString *bookName;
@property (nonatomic, retain) NSString *summary;
@property (nonatomic, retain) NSMutableArray *authors;
@property (nonatomic, retain) NSString  *authorIntro;
@property (nonatomic, retain) NSNumber *price;
@property (nonatomic, retain) NSString *publisher;


-(id)initWithBookID:(NSNumber*)bookID;
-(void)sync;

@end
