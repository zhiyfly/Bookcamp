//
//  Locale.m
//  bookcamp
//
//  Created by waiwai on 12/10/10.
//  Copyright 2010 __iwaiwai__. All rights reserved.
//

#import "Locale.h"

///////////////////////////////////////////////////////////////////////////////////////////////////
NSString* BCLocalizedString(NSString* key, NSString* comment) {
	static NSBundle* bundle = nil;
	if (!bundle) {
		NSString* path = [[[NSBundle mainBundle] resourcePath]
						  stringByAppendingPathComponent:@"bookcamp.bundle"];
		bundle = [[NSBundle bundleWithPath:path] retain];
	}
	
	return [bundle localizedStringForKey:key value:key table:nil];
}

