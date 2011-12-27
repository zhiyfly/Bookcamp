//
//  FavoriteDataSource.h
//  bookcamp
//
//  Created by lin waiwai on 3/13/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EditableListDateSource.h"
#import "FavoriteModel.h"

@interface FavoriteDataSource : EditableListDateSource {
	FavoriteModel *_favoriteModel;
}



@end
