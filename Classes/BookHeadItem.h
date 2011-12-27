//
//  BookHeadItem.h
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


@interface BookHeadItem : NSObject <NSCoding> {
	NSString *_bookThumbURL;
	NSString *_bookName;
	NSNumber *_rating;
	NSString *_bookCommentURL;
	NSString *_parityURL;
	NSNumber *_evaluationNum;
}

@property (nonatomic, retain) NSString *bookCommentURL;
@property (nonatomic, retain) NSString *parityURL;
@property (nonatomic, retain) NSString *bookName;
@property (nonatomic, retain) NSString *bookThumbURL;
@property (nonatomic, retain) NSNumber *rating;
@property (nonatomic, retain) NSNumber *evaluationNum;
+ (id)itemWithBook:(NSString*)name thumbURL:(NSString*)thumbURL parityURL:(NSString*)parityURL bookCommentURL:(NSString*)commentURL rating:(NSNumber*)rating evaluationNum:(NSNumber*)evaluationNum;

@end
