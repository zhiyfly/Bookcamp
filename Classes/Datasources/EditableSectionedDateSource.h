//
//  EditableSectionedDateSource.h
//  bookcamp
//
//  Created by lin waiwai on 2/1/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Three20UI/TTSectionedDataSource.h"

@interface EditableSectionedDateSource : TTSectionedDataSource {

}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle 
											forRowAtIndexPath:(NSIndexPath *)indexPath;

@end
