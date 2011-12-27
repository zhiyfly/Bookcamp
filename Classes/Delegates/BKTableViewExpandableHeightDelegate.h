//
//  BKTableViewExpandableHeightDelegate.h
//  bookcamp
//
//  Created by waiwai on 1/2/11.
//  Copyright 2011 __iwaiwai__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Three20UI/TTTableViewVarHeightDelegate.h"

@interface BKTableViewExpandableHeightDelegate : TTTableViewVarHeightDelegate {
	NSIndexPath *_selectedCellIndexPath;
}
@property (nonatomic, retain) NSIndexPath * selectedCellIndexPath;

@end
