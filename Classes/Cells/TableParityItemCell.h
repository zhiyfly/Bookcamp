//
//  TableParityItemCell.h
//  bookcamp
//
//  Created by waiwai on 12/22/10.
//  Copyright 2010 __iwaiwai__. All rights reserved.
//

#import "Three20UI/TTStyledTextTableCell.h"
#import "TableParityItem.h"


#define ShopNameLabelWidth 110
#define PriceLabelWidth 80
#define SaveonLabelWidth PriceLabelWidth

@interface TableParityItemCell : TTStyledTextTableCell {
	TableParityItem *_item;
	UILabel *_priceLabel;
	UILabel *_saveonLabel;
}
@property (nonatomic, retain, readonly) UILabel *priceLabel;
@property (nonatomic, retain, readonly) UILabel *saveonLabel;
@end
