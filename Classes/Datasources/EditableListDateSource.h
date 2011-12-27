//
//  EditableListDateSource.h
//  bookcamp
//
//  Created by lin waiwai on 2/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface EditableListDateSource : BookListDataSource {

}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle 
forRowAtIndexPath:(NSIndexPath *)indexPath;

@end
