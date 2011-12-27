//
//  ScreenCapture.h
//  iFrame
//
//  Created by lin waiwai on 4/13/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ScreenCapture : NSObject {

}

+(ScreenCapture*)capture;
- (UIImage *)captureView:(UIView *)view;
@end
