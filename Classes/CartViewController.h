//
//  CartViewController.h
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
#import "ParityModel.h"
#import "BaseTableViewController.h"

@interface CartViewController : BaseTableViewController {
	ParityModel *_parityModel;
	NSNumber *_oid;
	TTView *_headerView;
	TTLabel *_bookPriceLabel;
	TTView *_footerView;
	BookObject *_book;
}
@property (nonatomic, retain, readonly) BookObject *book;
@property (nonatomic, retain, readonly) TTView *footerView;
@property (nonatomic, retain, readonly) TTLabel *bookPriceLabel;
@property (nonatomic, retain, readonly) TTView *headerView;
@property (nonatomic, retain) NSNumber *oid;
@property (nonatomic, retain, readonly) ParityModel *parityModel;


@end
