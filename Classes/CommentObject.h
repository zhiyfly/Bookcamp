//
//  CommentObject.h
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
#import "People.h"
@interface CommentObject : NSObject  <TTURLRequestDelegate>{
	NSNumber *_cid;
	NSString *_title;
	NSString *_content;
	NSNumber *_rating;
	NSDate	*_updated;
	NSNumber *_votes;
	NSNumber *_unvotes;
	People *_author;
	ObjectStatusFlag _commentStatus;
	
}

@property (nonatomic, retain) NSNumber *unvotes;
@property (nonatomic, retain) NSNumber *cid;
@property (nonatomic, retain) People *author;
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *content;
@property (nonatomic, retain) NSNumber *rating;
@property (nonatomic, retain) NSDate *updated;
@property (nonatomic, retain) NSNumber *votes;
@property (nonatomic) ObjectStatusFlag commentStatus;

-(id)initWithCommentID:(NSNumber*)cid;
-(void)sync;

@end
