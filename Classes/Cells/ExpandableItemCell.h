//
//  ExpandableCellItemCell.h
//  bookcamp
//
//  Created by waiwai on 1/1/11.
//  Copyright 2011 __iwaiwai__. All rights reserved.
//

#import <Foundation/Foundation.h>
// UI
#import "Three20UI/TTTableViewCell.h"

#import "ExpandableItem.h"

@interface ExpandableItemCell : TTTableViewCell {
	ExpandableItem *_item;
	
	UILabel *_keyLabel;
	UILabel *_valueLabel;
	TTButton *_toggleIcon;	

	TTStyledTextLabel *_descStyledLabel;
	
	CGFloat	_expandHeight;
	CGFloat	_collapseHeight;
}

@property (nonatomic, retain) UILabel* keyLabel ;
@property (nonatomic, retain) UILabel* valueLabel;
@property (nonatomic, retain) TTStyledTextLabel *descStyledLabel;

@property (nonatomic, retain,readonly) TTButton *toggleIcon;


@end
