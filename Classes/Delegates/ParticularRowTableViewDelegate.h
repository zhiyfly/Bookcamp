//
//  ParticularRowTableViewDelegate.h
//  bookcamp
//
//  Created by lin waiwai on 7/24/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ParticularRowTableViewDelegate : TTTableViewVarHeightDelegate {

}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath;
@end
