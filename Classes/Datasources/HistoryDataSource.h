//
//  HistoryDataSource.h
//  bookcamp
//
//  Created by lin waiwai on 3/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EditableSectionedDateSource.h"
#import "HistoryModel.h"

@interface HistoryDataSource : EditableSectionedDateSource {
	HistoryModel *_historyModel;
}


@end
