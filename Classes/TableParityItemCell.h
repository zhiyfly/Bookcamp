//
//  TableParityItemCell.h
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
#import "Three20UI/TTStyledTextTableCell.h"
#import "TableParityItem.h"


#define ShopNameLabelWidth 110
#define PriceLabelWidth 110
#define SaveonLabelWidth PriceLabelWidth

@interface TableParityItemCell : TTStyledTextTableCell {
	TableParityItem *_item;
	UILabel *_priceLabel;
	UILabel *_saveonLabel;
}
@property (nonatomic, retain, readonly) UILabel *priceLabel;
@property (nonatomic, retain, readonly) UILabel *saveonLabel;
@end
