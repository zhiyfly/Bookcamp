//
//  CommentContentItem.h
//  bookcamp
//
//  Created by waiwai on 12/27/10.
//  Copyright 2010 __iwaiwai__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CommentContentItem : NSObject <NSCoding> {
	//wrap _text to Style text
	TTStyledText	*_styledContent;
	NSString		*_text;
	NSDate			*_date;
	NSNumber		*_profitIt;
	NSNumber		*_count;
	NSNumber	*_rating;
}

@property (nonatomic, retain) NSString *text;
@property (nonatomic, retain) NSNumber *profitIt;
@property (nonatomic, retain) NSNumber *count;
@property (nonatomic, retain) NSDate   *date;
@property (nonatomic, retain, readonly) TTStyledText *styledContent;
@property (nonatomic, retain) NSNumber *rating;

+ (id)itemWithContent:(NSString*)content date:(NSDate*)date rating:(NSNumber*)rating profitIt:(NSNumber*)profitIt count:(NSNumber*)count;

@end
