//
//  Book.h
//  bookcamp
//
//  Created by lin waiwai on 3/14/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <CoreData/CoreData.h>


@interface Book :  NSManagedObject  
{
}

@property (nonatomic, retain) NSNumber * historied;
@property (nonatomic, retain) NSString * authorIntro;
@property (nonatomic, retain) NSNumber * pages;
@property (nonatomic, retain) NSNumber * isbn13;
@property (nonatomic, retain) id authors;
@property (nonatomic, retain) NSString * bookName;
@property (nonatomic, retain) NSDate * savedDate;
@property (nonatomic, retain) NSNumber * price;
@property (nonatomic, retain) NSString * summary;
@property (nonatomic, retain) NSNumber * oid;
@property (nonatomic, retain) NSString * publisher;
@property (nonatomic, retain) NSNumber * averageRate;
@property (nonatomic, retain) NSNumber * favorited;
@property (nonatomic, retain) NSNumber * isbn10;
@property (nonatomic, retain) NSNumber * numRaters;
@property (nonatomic, retain) NSString * thumbURL;
@property (nonatomic, retain) NSDate * pubdate;

@end



