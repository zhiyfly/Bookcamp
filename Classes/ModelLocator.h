//
//  ModelLocator.h
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

#import <Foundation/Foundation.h>


@interface ModelLocator : NSObject {
	NSArray *latestFictionBooks;
	NSArray *latestNonfictionBooks;
	NSArray *rankingFictionBooks;
	NSArray *rankingNonfictionBooks;
	NSManagedObjectModel *_managedObjectModel;
	NSPersistentStoreCoordinator *_persistentStoreCoordinator;
}

@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (nonatomic, retain) NSArray *latestFictionBooks;
@property (nonatomic, retain) NSArray *latestNonfictionBooks;
@property (nonatomic, retain) NSArray *rankingFictionBooks;
@property (nonatomic, retain) NSArray *rankingNonfictionBooks;

+ (ModelLocator*)sharedInstance;
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator ;
-(NSString *)applicationDocumentsDirectory ;
- (NSManagedObjectModel *)managedObjectModel ;
@end
