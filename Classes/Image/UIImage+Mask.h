//
//  UIImage+Superposition.h
//  ePubViewer
//
//  Created by lin waiwai on 1/24/11.
//  Copyright 2011 infzm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Mask)
-(UIImage*)addMaskImage:(UIImage*)mask;
@end