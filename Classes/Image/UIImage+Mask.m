//
//  UIImage+Superposition.m
//  ePubViewer
//
//  Created by lin waiwai on 1/24/11.
//  Copyright 2011 infzm. All rights reserved.
//

#import "UIImage+Mask.h"


@implementation UIImage (Mask)

-(UIImage*)addMaskImage:(UIImage*)mask{
	CGSize targetSize = CGSizeMake(mask.size.width,mask.size.height);
    UIGraphicsBeginImageContext(targetSize); 
    //Creating the rect where the scaled image is drawn in
    CGRect rect = CGRectMake((mask.size.width-self.size.width)/2,(mask.size.height - self.size.height)/2,self.size.width,self.size.height);
    //Draw the image into the rect
    [self drawInRect:rect];
	[mask drawInRect:CGRectMake(0, 0, mask.size.width, mask.size.height)];
    //Saving the image, ending image context
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
    return newImage;
}

@end
