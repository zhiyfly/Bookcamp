//
//  BCTableViewDelegate.h
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

@protocol BCTableViewControllerDelegate

- (BOOL)shouldOpenURL:(NSString*)URL ;
- (id<TTModel>)model ;
- (void)didSelectObject:(id)object atIndexPath:(NSIndexPath*)indexPath;
- (void)didBeginDragging;
- (void)didEndDragging ;
- (void)hideMenu:(BOOL)animated;

@optional

- (UIView*)menuView;

@end



@interface BCTableViewDelegate : NSObject <UITableViewDelegate>  {
	id<BCTableViewControllerDelegate>  _controller;
	NSMutableDictionary*    _headers;
}

- (id)initWithController:(id<BCTableViewControllerDelegate>)controller;

@property (nonatomic, readonly) id<BCTableViewControllerDelegate> controller;


@end
