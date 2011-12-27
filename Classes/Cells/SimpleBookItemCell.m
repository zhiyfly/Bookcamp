//
//  SimpleBookCell.m
//  bookcamp
//
//  Created by lin waiwai on 7/27/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SimpleBookItemCell.h"


@implementation SimpleBookItemCell

///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString*)identifier {
	if (self = [super initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:identifier]) {
		self.detailTextLabel.backgroundColor = [UIColor clearColor];
		self.textLabel.backgroundColor = [UIColor clearColor];
	}
	
	return self;
}

@end
