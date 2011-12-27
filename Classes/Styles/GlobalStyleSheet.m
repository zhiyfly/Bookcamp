//
//  GlobalStyleSheet.m
//  bookcamp
//
//  Created by waiwai on 12/15/10.
//  Copyright 2010 __iwaiwai__. All rights reserved.
//

#import "GlobalStyleSheet.h"
#import "Three20Style/UIColorAdditions.h"
#import "Three20UI/UIViewAdditions.h"
#import "BAFillableStar.h"
#import "TTAreaStyle.h"


@implementation GlobalStyleSheet

-(UIFont*)titleFont{
	return  [UIFont systemFontOfSize:18];
}

-(UIFont*)summaryFont{
	return	[UIFont systemFontOfSize:14];
}

-(UIColor*)captionColor{
	return RGBCOLOR(70,70,70);
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (TTStyle*)segmentBar {
	
	return
	[TTFourBorderStyle styleWithTop:RGBCOLOR(187,187,187)  width:1 next:
	 [TTFourBorderStyle styleWithBottom:RGBCOLOR(180,180,180) width:2 next:
	  [TTFourBorderStyle styleWithBottom:[UIColor whiteColor] width:1 next:
	   [TTFourBorderStyle styleWithTop:[UIColor whiteColor] width:1 next:
		[TTLinearGradientFillStyle styleWithColor1:RGBCOLOR(248,248,248) color2:RGBCOLOR(240,240,240) next:nil]]]]];
	
}






-(TTStyle*)bookSelfStyle{
	return
	[TTImageStyle styleWithImageURL:@"bundle://bookSelf.png" defaultImage:nil
							   next:nil];
	
}

-(TTStyle*)infoViewStyle{
	return 
	[TTLinearGradientFillStyle styleWithColor1:RGBCOLOR(241,241,241) color2:RGBCOLOR(243,243,243) next:nil];
}

#define ArrowHeight 9
#define ArrowWidth 6

#define ArrowIndicatorWidth 18
#define ArrowIndicatorHeight 9

#define SegmentBarHeight 30

///////////////////////////////////////////////////////////////////////////////////////////////////
- (TTStyle*)segment:(UIControlState)state {
	//选中状态	
	CGFloat gap = 62;
	if (state == UIControlStateSelected) {
		return
		[TTBoxStyle styleWithPadding:UIEdgeInsetsMake(5, gap, 2, gap) next:
		 [TTAreaStyle styleWithRect:CGRectMake(gap - ArrowWidth * 3, (SegmentBarHeight - ArrowHeight) / 2, ArrowWidth, ArrowHeight) 
							  style:[TTImageStyle styleWithImageURL:@"bundle://pinkLeftArrow.png" defaultImage:nil
															   next:nil]
							   next:
		  [TTAreaStyle styleWithRect:CGRectMake(gap, SegmentBarHeight - ArrowIndicatorHeight , ArrowIndicatorWidth, ArrowIndicatorHeight) 
							   style:[TTImageStyle styleWithImageURL:@"bundle://arrowIndicator.png" defaultImage:nil
																next:nil]
								next:
		   [TTTextStyle styleWithFont:[UIFont boldSystemFontOfSize:14] 
								color:RGBCOLOR(254,15,89)
					  minimumFontSize:8 shadowColor:nil shadowOffset:CGSizeMake(0, 0)
						textAlignment:UITextAlignmentCenter verticalAlignment:UIControlContentVerticalAlignmentTop
						lineBreakMode:UILineBreakModeCharacterWrap numberOfLines:1 next:nil]]]];
		
	} else {
		return
		[TTBoxStyle styleWithPadding:UIEdgeInsetsMake(5, gap, 2, gap) next:
		 [TTAreaStyle styleWithRect:CGRectMake(gap - ArrowWidth * 3, (SegmentBarHeight - ArrowHeight) / 2, ArrowWidth, ArrowHeight) 
							  style:[TTImageStyle styleWithImageURL:@"bundle://grayLeftArrow.png" defaultImage:nil
															   next:nil]
							   next:
		  [TTTextStyle  styleWithFont:[UIFont boldSystemFontOfSize:14]  color:TTSTYLEVAR(textColor)
					  minimumFontSize:8 shadowColor:nil shadowOffset:CGSizeMake(0, 0)
						textAlignment:UITextAlignmentCenter verticalAlignment:UIControlContentVerticalAlignmentTop
						lineBreakMode:UILineBreakModeCharacterWrap numberOfLines:1 next:nil]]];
	}
	
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (TTStyle*)stripBarStyle {
	
	return
	
	[TTFourBorderStyle styleWithTop:RGBCOLOR(187,187,187)  width:1 next:
	 [TTFourBorderStyle styleWithBottom:RGBCOLOR(180,180,180) width:2 next:
	  [TTFourBorderStyle styleWithBottom:[UIColor whiteColor] width:1 next:
	   [TTFourBorderStyle styleWithTop:[UIColor whiteColor] width:1 next:
		[TTLinearGradientFillStyle styleWithColor1:RGBCOLOR(248,248,248) color2:RGBCOLOR(240,240,240) next:nil]]]]];
	
}



///////////////////////////////////////////////////////////////////////////////////////////////////
- (TTStyle*)segment:(UIControlState)state corner:(short)corner {
	TTShape* shape = nil;
	if (corner == 1) {
		shape = [TTRoundedRectangleShape shapeWithTopLeft:4 topRight:0 bottomRight:0 bottomLeft:0];
	} else if (corner == 2) {
		shape = [TTRoundedRectangleShape shapeWithTopLeft:0 topRight:4 bottomRight:0 bottomLeft:0];
	} else if (corner == 3) {
		shape = [TTRoundedRectangleShape shapeWithTopLeft:0 topRight:0 bottomRight:4 bottomLeft:0];
	} else if (corner == 4) {
		shape = [TTRoundedRectangleShape shapeWithTopLeft:0 topRight:0 bottomRight:0 bottomLeft:4];
	} else if (corner == 5) {
		shape = [TTRoundedRectangleShape shapeWithTopLeft:4 topRight:0 bottomRight:0 bottomLeft:4];
	} else if (corner == 6) {
		shape = [TTRoundedRectangleShape shapeWithTopLeft:0 topRight:4 bottomRight:4 bottomLeft:0];
	} else {
		shape = [TTRectangleShape shape];
	}
	
	if (state == UIControlStateSelected) {
		return
		[TTSolidFillStyle styleWithColor:RGBCOLOR(0, 0, 0) next:
		 [TTFourBorderStyle styleWithBottom:[UIColor blackColor] width:1 next:
		  [TTTextStyle styleWithFont:[UIFont boldSystemFontOfSize:16]  color:RGBCOLOR(0, 0, 0)
					 minimumFontSize:8 shadowColor:nil shadowOffset:CGSizeMake(0,0)
								next:nil]]];
	} else {
		return
		[TTSolidFillStyle styleWithColor:RGBCOLOR(0, 0, 0) next:
		 [TTFourBorderStyle styleWithBottom:[UIColor blackColor] width:1 next:
		  [TTTextStyle styleWithFont:[UIFont boldSystemFontOfSize:16]  color:RGBCOLOR(0, 0, 0)
					 minimumFontSize:8 shadowColor:nil shadowOffset:CGSizeMake(0,0)
								next:nil]]];
	}
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (TTStyle*)segmentLeft:(UIControlState)state {
	return [self segment:state corner:5];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (TTStyle*)segmentRight:(UIControlState)state {
	return [self segment:state corner:6];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (TTStyle*)segmentCenter:(UIControlState)state {
	return [self segment:state corner:0];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (TTStyle*)tabGridTabImage:(UIControlState)state {
	return
    [TTImageStyle styleWithImageURL:nil defaultImage:nil contentMode:UIViewContentModeLeft
							   size:CGSizeZero next:nil];
}



///////////////////////////////////////////////////////////////////////////////////////////////////
- (UIColor*)tabBarTintColor {
	return RGBCOLOR(100, 140, 168);
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (TTStyle*)tabBar {
	
	return
	
    [TTSolidFillStyle styleWithColor:RGBCOLOR(243,243,243) next:
	 [TTFourBorderStyle styleWithTop:RGBCOLOR(184,184,184) right:nil bottom:nil left:nil width:1 next:nil]];
	
	
}

-(TTStyle*)expressTab:(UIControlState)state {
	return [self tab:state iconStr:@"Book"];
}


-(TTStyle*)historyTab:(UIControlState)state {
	return [self tab:state iconStr:@"History"];
}

-(TTStyle*)scanFromCameraTab:(UIControlState)state {
	CGFloat gap = 38;
	return 	
	[TTInsetStyle styleWithInset:UIEdgeInsetsMake(1, 0, 0, 0) next:
	 [TTBoxStyle styleWithPadding:UIEdgeInsetsMake(0,gap, 0,gap) next:
	  [TTAreaStyle styleWithRect:CGRectMake(0, 0, 2*gap, 40) style:
	   [TTImageStyle styleWithImageURL:@"bundle://scanBtnNormal.png" defaultImage:nil
								  next:nil]
							next:nil]]];
}

-(TTStyle*)favoriteTab:(UIControlState)state {
	return [self tab:state iconStr:@"Like"];
}

-(TTStyle*)moreTab:(UIControlState)state {
	return [self tab:state iconStr:@"More"];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (TTStyle*)tab:(UIControlState)state iconStr:(NSString*)iconStr {
	//选中状态	
	CGFloat fontSize = 15;
	CGFloat gap = 15;
	
	UILabel *label = [[UILabel alloc] init];
	label.text = iconStr;
	[label sizeToFit];
	label.backgroundColor = [UIColor clearColor];
	label.font = [UIFont systemFontOfSize:8];
	UIImage *merged ;
	
	if (state == UIControlStateSelected) {	
		label.frame =  CGRectMake(18, 20, label.width, label.height);
		UIImage* groundImage = [UIImage imageNamed:@"tabHightlightedBackground.png"];
		UIImageView *background = [[[UIImageView alloc] initWithImage:groundImage] autorelease];
		background.frame = CGRectMake(0, 0, groundImage.size.width, groundImage.size.height);
		label.textColor = RGBCOLOR(255,0,78);
		[background addSubview:label];
		merged = [[ScreenCapture capture] captureView:background];
		
		return
		[TTInsetStyle styleWithInset:UIEdgeInsetsMake(1, 0, 0, 0) next:
		 [TTSolidFillStyle styleWithColor:RGBCOLOR(243,243,243) next:
		  [TTImageStyle styleWithImage:merged defaultImage:nil
								  next:
		   [TTBoxStyle styleWithPadding:UIEdgeInsetsMake(5,gap, 0,gap) next:
			
			[TTTextStyle styleWithFont:[UIFont systemFontOfSize:fontSize] color:RGBCOLOR(255,0,78)
					   minimumFontSize:8
						   shadowColor:nil shadowOffset:CGSizeMake(0, 0)
						 textAlignment:UITextAlignmentCenter
					 verticalAlignment:UIControlContentVerticalAlignmentTop
						 lineBreakMode:UILineBreakModeWordWrap numberOfLines:1
								  next:nil
			 
			 ]]]]];
	} else {
		label.textColor = [UIColor blackColor];
		merged = [[ScreenCapture capture] captureView:label];
		return
		[TTInsetStyle styleWithInset:UIEdgeInsetsMake(1, 0, 0, 0) next:
		 [TTSolidFillStyle styleWithColor:RGBCOLOR(243,243,243) next:
		  [TTAreaStyle styleWithRect:CGRectMake(18, 20, label.width, label.height) style:
		   [TTImageStyle styleWithImage:merged defaultImage:nil
								   next:nil]
								next:
		   [TTFourBorderStyle styleWithTop:RGBCOLOR(250,250,250) width:1 next:
			[TTFourBorderStyle styleWithTop:[UIColor whiteColor] width:1 next:
			 [TTBoxStyle styleWithPadding:UIEdgeInsetsMake(5,gap, 0,gap) next:
			  
			  [TTTextStyle styleWithFont:[UIFont systemFontOfSize:fontSize] color:[UIColor blackColor]
						 minimumFontSize:8
							 shadowColor:nil
							shadowOffset:CGSizeMake(0, 0)
						   textAlignment:UITextAlignmentCenter
					   verticalAlignment:UIControlContentVerticalAlignmentTop
						   lineBreakMode:UILineBreakModeWordWrap numberOfLines:1
									next:nil
			   ]]]]]]];
	}
}



///////////////////////////////////////////////////////////////////////////////////////////////////
- (TTStyle*)navigatorBarStyle{
	return
	[TTLinearGradientFillStyle styleWithColor1:[UIColor whiteColor] color2:RGBCOLOR(249,249,249)
										  next:nil];
	
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (TTStyle*)navigatorBarStyleTwo{
	return
	[TTFourBorderStyle styleWithTop:[UIColor whiteColor] width:1 next:
	 [TTLinearGradientFillStyle styleWithColor1:RGBCOLOR(248,249,251)  color2:RGBCOLOR(242,242,242)
										   next:nil]];
	
}

-(TTStyle*) navigatorBarStyleThree{
	return
	
	[TTLinearGradientFillStyle styleWithColor1:RGBCOLOR(248,249,251)  color2:RGBCOLOR(242,242,242)
										  next:
	 [TTShadowStyle styleWithColor:RGBCOLOR(198,198,198) blur:2 offset:CGSizeMake(0, 2) next:
	  [TTFourBorderStyle styleWithBottom:[UIColor whiteColor] width:1 next:nil]
	  
	  ]];
}



-(TTStyle*) toggleIconStyle:(UIControlState)state{
	//选中状态
	if (state == UIControlStateSelected) {
		UIColor* border = [TTSTYLEVAR(tabBarTintColor) multiplyHue:0 saturation:0 value:0.7];
		
		return
		[TTShapeStyle styleWithShape:[TTRoundedRectangleShape shapeWithTopLeft:4.5 topRight:4.5
																   bottomRight:0 bottomLeft:0] next:
		 [TTInsetStyle styleWithInset:UIEdgeInsetsMake(5, 1, 0, 1) next:
		  [TTReflectiveFillStyle styleWithColor:TTSTYLEVAR(tabTintColor) next:
		   [TTInsetStyle styleWithInset:UIEdgeInsetsMake(-1, -1, 0, -1) next:
			[TTFourBorderStyle styleWithTop:border right:border bottom:nil left:border width:1 next:
			 [TTBoxStyle styleWithPadding:UIEdgeInsetsMake(6, 12, 2, 12) next:
			  [TTTextStyle styleWithFont:[UIFont boldSystemFontOfSize:14]  color:TTSTYLEVAR(textColor)
						 minimumFontSize:8 shadowColor:nil
							shadowOffset:CGSizeMake(0, 0) next:nil]]]]]]];
	} else {
		return
		[TTInsetStyle styleWithInset:UIEdgeInsetsMake(5, 1, 1, 1) next:
		 [TTBoxStyle styleWithPadding:UIEdgeInsetsMake(6, 12, 2, 12) next:
		  [TTTextStyle styleWithFont:[UIFont boldSystemFontOfSize:14]  color:[UIColor whiteColor]
					 minimumFontSize:8 shadowColor:nil
						shadowOffset:CGSizeMake(0, 0) next:nil]]];
	}
	
}

-(UIFont*) moduleTitleFont{
	return [UIFont systemFontOfSize:18];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (TTStyle*)moduleTitleStyle {
	return
    [TTSolidFillStyle styleWithColor:[UIColor clearColor] next:
	 [TTBoxStyle styleWithPadding:UIEdgeInsetsMake(8, 8, 8, 8) next:
	  [TTTextStyle styleWithFont: TTSTYLEVAR(moduleTitleFont)
						   color: RGBCOLOR(255,0,78)
				 minimumFontSize: 0
					 shadowColor: nil
					shadowOffset: TTSTYLEVAR(photoCaptionTextShadowOffset)
				   textAlignment: UITextAlignmentCenter
			   verticalAlignment: UIControlContentVerticalAlignmentCenter
				   lineBreakMode: UILineBreakModeTailTruncation
				   numberOfLines: 6
							next: nil]]];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (TTStyle*)priceLabelStyle {
	return 
	[TTBoxStyle styleWithPadding:UIEdgeInsetsMake(8, 8, 8, 8) next:
	 [TTTextStyle styleWithFont:TTSTYLEVAR(photoCaptionFont) color:RGBCOLOR(102,102,102)
				minimumFontSize:0 
					shadowColor:nil 
				   shadowOffset:CGSizeZero next:nil]];
}


-(TTStyle*) finishButtonStyle:(UIControlState)state{
	//选中状态
	if (state == UIControlStateSelected) {
		UIColor* border = [TTSTYLEVAR(tabBarTintColor) multiplyHue:0 saturation:0 value:0.7];
		
		return
		[TTShapeStyle styleWithShape:[TTRoundedRectangleShape shapeWithRadius:4.5] next:
		 [TTSolidBorderStyle styleWithColor:RGBCOLOR(187,187,187) width:1 next:
		  [TTLinearGradientFillStyle styleWithColor1:[UIColor whiteColor]
											  color2:RGBCOLOR(212,212,212) next:
		   [TTBoxStyle styleWithPadding:UIEdgeInsetsMake(4, 12, 4, 12) next:
			[TTTextStyle styleWithFont:[UIFont systemFontOfSize:14] color:RGBCOLOR(255,0,78)
					   minimumFontSize:8
						   shadowColor:nil shadowOffset:CGSizeZero
						 textAlignment:UITextAlignmentCenter
					 verticalAlignment:UIControlContentVerticalAlignmentTop
						 lineBreakMode:UILineBreakModeWordWrap numberOfLines:1
								  next:nil]]]]];
	} else {
		return
		[TTShapeStyle styleWithShape:[TTRoundedRectangleShape shapeWithRadius:4.5] next:
		 [TTSolidBorderStyle styleWithColor:RGBCOLOR(187,187,187) width:1 next:
		  [TTLinearGradientFillStyle styleWithColor1:[UIColor whiteColor]
											  color2:RGBCOLOR(212,212,212) next:
		   [TTBoxStyle styleWithPadding:UIEdgeInsetsMake(4, 12, 4, 12) next:
			[TTTextStyle styleWithFont:[UIFont systemFontOfSize:14] color:RGBCOLOR(255,0,78)
					   minimumFontSize:8
						   shadowColor:nil shadowOffset:CGSizeZero
						 textAlignment:UITextAlignmentCenter
					 verticalAlignment:UIControlContentVerticalAlignmentTop
						 lineBreakMode:UILineBreakModeWordWrap numberOfLines:1
								  next:nil]]]]];
	}	
}

-(TTStyle*) cancelButtonStyle:(UIControlState)state{
	//选中状态
	if (state == UIControlStateSelected) {
		UIColor* border = [TTSTYLEVAR(tabBarTintColor) multiplyHue:0 saturation:0 value:0.7];
		
		return
		[TTShapeStyle styleWithShape:[TTRoundedRectangleShape shapeWithRadius:4.5] next:
		 [TTSolidBorderStyle styleWithColor:RGBCOLOR(187,187,187) width:1 next:
		  [TTLinearGradientFillStyle styleWithColor1:[UIColor whiteColor]
											  color2:RGBCOLOR(212,212,212) next:
		   [TTBoxStyle styleWithPadding:UIEdgeInsetsMake(4, 12, 4, 12) next:
			[TTTextStyle styleWithFont:[UIFont systemFontOfSize:14] color:RGBCOLOR(255,0,78)
					   minimumFontSize:8
						   shadowColor:nil shadowOffset:CGSizeZero
						 textAlignment:UITextAlignmentCenter
					 verticalAlignment:UIControlContentVerticalAlignmentTop
						 lineBreakMode:UILineBreakModeWordWrap numberOfLines:1
								  next:nil]]]]];
	} else {
		return
		[TTShapeStyle styleWithShape:[TTRoundedRectangleShape shapeWithRadius:4.5] next:
		 [TTSolidBorderStyle styleWithColor:RGBCOLOR(187,187,187) width:1 next:
		  [TTLinearGradientFillStyle styleWithColor1:[UIColor whiteColor]
											  color2:RGBCOLOR(212,212,212) next:
		   [TTBoxStyle styleWithPadding:UIEdgeInsetsMake(4, 12, 4, 12) next:
			[TTTextStyle styleWithFont:[UIFont systemFontOfSize:14] color:RGBCOLOR(255,0,78)
					   minimumFontSize:8
						   shadowColor:nil shadowOffset:CGSizeMake(0, 0)
						 textAlignment:UITextAlignmentCenter
					 verticalAlignment:UIControlContentVerticalAlignmentTop
						 lineBreakMode:UILineBreakModeWordWrap numberOfLines:1
								  next:nil]]]]];
	}
	
}

-(TTStyle*) editButtonStyle:(UIControlState)state{
	//选中状态
	if (state == UIControlStateSelected) {
		UIColor* border = [TTSTYLEVAR(tabBarTintColor) multiplyHue:0 saturation:0 value:0.7];
		
		return
		[TTShapeStyle styleWithShape:[TTRoundedRectangleShape shapeWithRadius:4.5] next:
		 [TTSolidBorderStyle styleWithColor:RGBCOLOR(187,187,187) width:1 next:
		  [TTLinearGradientFillStyle styleWithColor1:[UIColor whiteColor]
											  color2:RGBCOLOR(212,212,212) next:
		   [TTBoxStyle styleWithPadding:UIEdgeInsetsMake(4, 12, 4, 12) next:
			[TTTextStyle styleWithFont:[UIFont systemFontOfSize:14] color:RGBCOLOR(255,0,78)
					   minimumFontSize:8
						   shadowColor:nil shadowOffset:CGSizeZero
						 textAlignment:UITextAlignmentCenter
					 verticalAlignment:UIControlContentVerticalAlignmentTop
						 lineBreakMode:UILineBreakModeWordWrap numberOfLines:1
								  next:nil]]]]];
	} else {
		return
		[TTShapeStyle styleWithShape:[TTRoundedRectangleShape shapeWithRadius:4.5] next:
		 [TTSolidBorderStyle styleWithColor:RGBCOLOR(187,187,187) width:1 next:
		  [TTLinearGradientFillStyle styleWithColor1:[UIColor whiteColor]
											  color2:RGBCOLOR(212,212,212) next:
		   [TTBoxStyle styleWithPadding:UIEdgeInsetsMake(4, 12, 4, 12) next:
			[TTTextStyle styleWithFont:[UIFont systemFontOfSize:14] color:RGBCOLOR(255,0,78)
					   minimumFontSize:8
						   shadowColor:nil shadowOffset:CGSizeMake(0, 0)
						 textAlignment:UITextAlignmentCenter
					 verticalAlignment:UIControlContentVerticalAlignmentTop
						 lineBreakMode:UILineBreakModeWordWrap numberOfLines:1
								  next:nil]]]]];
	}
	
}
//back btn style
-(TTStyle*) backButtonStyle:(UIControlState)state{
	NSString *imageURL = @"bundle://pinkRightArrow.png";
	//选中状态	
	CGFloat fontSize = 14;
	
	CGFloat imageWidth = 10;
	CGFloat imageHeight = 10;
	if (state == UIControlStateSelected) {
		
		return
		[TTAreaStyle styleWithBlock:^(CGRect rect ,id data){ 
			return CGRectMake( [[data objectAtIndex:0] floatValue] / 2, (CGRectGetHeight(rect) - [[data objectAtIndex:0] floatValue]) / 2,  [[data objectAtIndex:0] floatValue],  [[data objectAtIndex:1] floatValue]);
		} 
							   data:[NSArray arrayWithObjects:[NSNumber numberWithFloat:imageWidth],
									 [NSNumber numberWithFloat:imageHeight],
									 nil]
							  style: [TTImageStyle styleWithImageURL:imageURL defaultImage:nil next:nil]
							   next:
		 [TTBoxStyle styleWithPadding:UIEdgeInsetsMake(0, imageWidth*3, 0, 0) next:
		  [TTTextStyle styleWithFont:[UIFont systemFontOfSize:fontSize] color:RGBCOLOR(255,0,78)
					 minimumFontSize:8
						 shadowColor:nil shadowOffset:CGSizeMake(0, 0)
					   textAlignment:UITextAlignmentCenter
				   verticalAlignment:UIControlContentVerticalAlignmentCenter
					   lineBreakMode:UILineBreakModeWordWrap numberOfLines:1
								next:nil
		   
		   ]]];
	} else {
		return 
		[TTAreaStyle styleWithBlock:^(CGRect rect ,id data){ 
			return CGRectMake( [[data objectAtIndex:0] floatValue] / 2, (CGRectGetHeight(rect) - [[data objectAtIndex:0] floatValue]) / 2,  [[data objectAtIndex:0] floatValue],  [[data objectAtIndex:1] floatValue]);
		} 
							   data:[NSArray arrayWithObjects:[NSNumber numberWithFloat:imageWidth],
									 [NSNumber numberWithFloat:imageHeight],
									 nil]
							  style: [TTImageStyle styleWithImageURL:imageURL defaultImage:nil next:nil]
							   next:
		 [TTBoxStyle styleWithPadding:UIEdgeInsetsMake(0, imageWidth*3, 0, 0) next:
		  [TTTextStyle styleWithFont:[UIFont systemFontOfSize:fontSize] color:RGBCOLOR(255,0,78)
					 minimumFontSize:8
						 shadowColor:nil shadowOffset:CGSizeMake(0, 0)
					   textAlignment:UITextAlignmentCenter
				   verticalAlignment:UIControlContentVerticalAlignmentCenter
					   lineBreakMode:UILineBreakModeWordWrap numberOfLines:1
								next:nil
		   
		   ]]];
	}
	
}


-(TTStyle*)toolbarButton:(UIControlState)state withImgURL:(NSString*)imageURL{
	//选中状态	
	CGFloat fontSize = 15;
	
	CGFloat imageWidth = 15;
	CGFloat imageHeight = 15;
	if (state == UIControlStateSelected || state == UIControlStateHighlighted) {	
		
		
		
		UIImage* groundImage = [UIImage imageNamed:@"tabHightlightedBackground.png"];
		UIImageView *background = [[[UIImageView alloc] initWithImage:groundImage] autorelease];
		background.frame = CGRectMake(0, 0, groundImage.size.width, groundImage.size.height);
		UIImage *merged = [[ScreenCapture capture] captureView:background];
		
		return
		[TTSolidFillStyle styleWithColor:RGBCOLOR(242,242,242) next:
		 [TTInsetStyle styleWithInset:UIEdgeInsetsMake(0, -1, 0, -1) next:
		 [TTFourBorderStyle styleWithTop:RGBCOLOR(183,183,183) width:1 next:
		  [TTFourBorderStyle styleWithTop:[UIColor whiteColor] width:1 next:
		   [TTImageStyle styleWithImage:merged defaultImage:nil
								   next:
			[TTAreaStyle styleWithBlock:^(CGRect rect ,id data){ 
			   return CGRectMake( [[data objectAtIndex:0] floatValue] / 2, (CGRectGetHeight(rect) - [[data objectAtIndex:0] floatValue]) / 2,  [[data objectAtIndex:0] floatValue],  [[data objectAtIndex:1] floatValue]);
		   } 
								   data:[NSArray arrayWithObjects:[NSNumber numberWithFloat:imageWidth],
										 [NSNumber numberWithFloat:imageHeight],
										 nil]
								  style: [TTImageStyle styleWithImageURL:imageURL defaultImage:nil next:nil]
								   next:
			 [TTBoxStyle styleWithPadding:UIEdgeInsetsMake(0, imageWidth * 3 / 2, 0, 0) next:
			  [TTTextStyle styleWithFont:[UIFont systemFontOfSize:fontSize] color:RGBCOLOR(45,45,45)
						 minimumFontSize:8
							 shadowColor:nil shadowOffset:CGSizeMake(0, 0)
						   textAlignment:UITextAlignmentCenter
					   verticalAlignment:UIControlContentVerticalAlignmentCenter
						   lineBreakMode:UILineBreakModeWordWrap numberOfLines:1
									next:nil
			   
			   ]]]]]]]];
	} else {
		return 
		[TTSolidFillStyle styleWithColor:RGBCOLOR(242,242,242) next:
		 [TTInsetStyle styleWithInset:UIEdgeInsetsMake(0, -1, 0, -1) next:
		 [TTFourBorderStyle styleWithTop:RGBCOLOR(183,183,183) width:1 next:
		  [TTFourBorderStyle styleWithTop:[UIColor whiteColor] width:1 next:
		   [TTAreaStyle styleWithBlock:^(CGRect rect ,id data){ 
			  return CGRectMake( [[data objectAtIndex:0] floatValue] / 2, (CGRectGetHeight(rect) - [[data objectAtIndex:0] floatValue]) / 2,  [[data objectAtIndex:0] floatValue],  [[data objectAtIndex:1] floatValue]);
		  } 
								  data:[NSArray arrayWithObjects:[NSNumber numberWithFloat:imageWidth],
										[NSNumber numberWithFloat:imageHeight],
										nil]
								 style: [TTImageStyle styleWithImageURL:imageURL defaultImage:nil next:nil]
								  next:
			[TTBoxStyle styleWithPadding:UIEdgeInsetsMake(0, imageWidth * 3 / 2, 0, 0) next:
			 [TTTextStyle styleWithFont:[UIFont systemFontOfSize:fontSize] color:RGBCOLOR(45,45,45)
						minimumFontSize:8
							shadowColor:nil shadowOffset:CGSizeMake(0, 0)
						  textAlignment:UITextAlignmentCenter
					  verticalAlignment:UIControlContentVerticalAlignmentCenter
						  lineBreakMode:UILineBreakModeWordWrap numberOfLines:1
								   next:nil
			  
			  ]]]]]]];
	}
	
}

-(TTStyle*)toolbarFavoriteButton:(UIControlState)state{
	NSString *imageURL = @"bundle://express.png";
	return [self toolbarButton:state withImgURL:imageURL];
}

-(TTStyle*)toolbarCommentButton:(UIControlState)state{
	NSString *imageURL = @"bundle://comment.png";
	return [self toolbarButton:state withImgURL:imageURL];
}

-(TTStyle*)toolbarParityButton:(UIControlState)state{
	NSString *imageURL = @"bundle://price.png";
	return [self toolbarButton:state withImgURL:imageURL];
}

-(TTStyle*)toolbarAuthorButton:(UIControlState)state{
	NSString *imageURL = @"bundle://writer.png";
	//选中状态	
	CGFloat fontSize = 15;
	
	CGFloat imageWidth = 15;
	CGFloat imageHeight = 15;
	
	UIImage* groundImage = [UIImage imageNamed:@"tabHightlightedBackground.png"];
	UIImageView *background = [[[UIImageView alloc] initWithImage:groundImage] autorelease];
	background.frame = CGRectMake(0, 0, groundImage.size.width, groundImage.size.height);
	UIImage *merged = [[ScreenCapture capture] captureView:background];
	if (state == UIControlStateSelected||state == UIControlStateHighlighted) {
		
		return
		[TTSolidFillStyle styleWithColor:RGBCOLOR(242,242,242) next:
		 [TTFourBorderStyle styleWithTop:RGBCOLOR(183,183,183) width:1 next:
		  
		  [TTFourBorderStyle styleWithTop:[UIColor whiteColor] width:1 next:
		   [TTImageStyle styleWithImage:merged defaultImage:nil
								   next:
			[TTAreaStyle styleWithBlock:^(CGRect rect ,id data){ 
			   return CGRectMake( [[data objectAtIndex:0] floatValue] / 2, (CGRectGetHeight(rect) - [[data objectAtIndex:0] floatValue]) / 2,  [[data objectAtIndex:0] floatValue],  [[data objectAtIndex:1] floatValue]);
		   } 
								   data:[NSArray arrayWithObjects:[NSNumber numberWithFloat:imageWidth],
										 [NSNumber numberWithFloat:imageHeight],
										 nil]
								  style: [TTImageStyle styleWithImageURL:imageURL defaultImage:nil next:nil]
								   next:
			 [TTBoxStyle styleWithPadding:UIEdgeInsetsMake(0, imageWidth * 3 / 2, 0, 0) next:
			  [TTTextStyle styleWithFont:[UIFont systemFontOfSize:fontSize] color:RGBCOLOR(45,45,45)
						 minimumFontSize:8
							 shadowColor:nil shadowOffset:CGSizeMake(0, 0)
						   textAlignment:UITextAlignmentCenter
					   verticalAlignment:UIControlContentVerticalAlignmentCenter
						   lineBreakMode:UILineBreakModeWordWrap numberOfLines:1
									next:nil
			   
			   ]]]]]]];
	} else {
		return 
		[TTSolidFillStyle styleWithColor:RGBCOLOR(242,242,242) next:
		 [TTFourBorderStyle styleWithTop:RGBCOLOR(183,183,183) right:[UIColor whiteColor]
								  bottom:nil left:nil width:1 next:
		  [TTFourBorderStyle styleWithTop:[UIColor whiteColor] right:RGBCOLOR(183,183,183)
								   bottom:nil left:nil width:1 next:
		   [TTAreaStyle styleWithBlock:^(CGRect rect ,id data){ 
			  return CGRectMake( [[data objectAtIndex:0] floatValue] / 2, (CGRectGetHeight(rect) - [[data objectAtIndex:0] floatValue]) / 2,  [[data objectAtIndex:0] floatValue],  [[data objectAtIndex:1] floatValue]);
		  } 
								  data:[NSArray arrayWithObjects:[NSNumber numberWithFloat:imageWidth],
										[NSNumber numberWithFloat:imageHeight],
										nil]
								 style: [TTImageStyle styleWithImageURL:imageURL defaultImage:nil next:nil]
								  next:
			[TTBoxStyle styleWithPadding:UIEdgeInsetsMake(0, imageWidth * 3 / 2, 0, 0) next:
			 [TTTextStyle styleWithFont:[UIFont systemFontOfSize:fontSize] color:RGBCOLOR(45,45,45)
						minimumFontSize:8
							shadowColor:nil shadowOffset:CGSizeMake(0, 0)
						  textAlignment:UITextAlignmentCenter
					  verticalAlignment:UIControlContentVerticalAlignmentCenter
						  lineBreakMode:UILineBreakModeWordWrap numberOfLines:1
								   next:nil
			  
			  ]]]] ]];
	}
}




- (TTStyle*)linkButton:(UIControlState)state {
	if (state == UIControlStateNormal) {
		return
		[TTShapeStyle styleWithShape:[TTRoundedRectangleShape shapeWithRadius:8] next:
		 [TTInsetStyle styleWithInset:UIEdgeInsetsMake(0, 0, 1, 0) next:
		  [TTShadowStyle styleWithColor:RGBACOLOR(255,255,255,0) blur:1 offset:CGSizeMake(0, 1) next:
		   [TTLinearGradientFillStyle styleWithColor1:RGBCOLOR(255, 255, 255)
											   color2:RGBCOLOR(216, 221, 231) next:
			[TTSolidBorderStyle styleWithColor:RGBCOLOR(161, 167, 178) width:1 next:
			 [TTBoxStyle styleWithPadding:UIEdgeInsetsMake(10, 12, 9, 12) next:
			  [TTTextStyle styleWithFont:nil color:TTSTYLEVAR(linkTextColor)
							 shadowColor:nil
							shadowOffset:CGSizeMake(0, 0) next:nil]]]]]]];
	} else if (state == UIControlStateHighlighted) {
		return
		[TTShapeStyle styleWithShape:[TTRoundedRectangleShape shapeWithRadius:8] next:
		 [TTInsetStyle styleWithInset:UIEdgeInsetsMake(0, 0, 1, 0) next:
		  [TTShadowStyle styleWithColor:RGBACOLOR(255,255,255,0.9) blur:1 offset:CGSizeMake(0, 1) next:
		   [TTLinearGradientFillStyle styleWithColor1:RGBCOLOR(225, 225, 225)
											   color2:RGBCOLOR(196, 201, 221) next:
			[TTSolidBorderStyle styleWithColor:RGBCOLOR(161, 167, 178) width:1 next:
			 [TTBoxStyle styleWithPadding:UIEdgeInsetsMake(10, 12, 9, 12) next:
			  [TTTextStyle styleWithFont:nil color:[UIColor whiteColor]
							 shadowColor:nil
							shadowOffset:CGSizeMake(0, 0) next:nil]]]]]]];
	} else {
		return nil;
	}
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (TTStyle*)favoriteButtonStyle:(UIControlState)state {
	//选中状态
	if (state == UIControlStateSelected) {
		[TTSolidFillStyle styleWithColor:RGBCOLOR(194,189,162) next:
		 [TTBoxStyle styleWithPadding:UIEdgeInsetsMake(5, 5, 5, 5) next:
		  [TTTextStyle styleWithFont:TTSTYLEVAR(font) color:[UIColor whiteColor]
					   textAlignment:UITextAlignmentCenter next:nil
		   ]]];
	} else {
		[TTSolidFillStyle styleWithColor:RGBCOLOR(194,189,162) next:
		 [TTBoxStyle styleWithPadding:UIEdgeInsetsMake(5, 5, 5, 5) next:
		  [TTTextStyle styleWithFont:TTSTYLEVAR(font) color:[UIColor whiteColor]
					   textAlignment:UITextAlignmentCenter next:nil
		   ]]];
	}
}

-(TTStyle*)sliderSegmentLeftStyle{
	return
	[TTShapeStyle styleWithShape:[TTRoundedRectangleShape shapeWithRadius:6] next:
	 
	 [TTImageStyle styleWithImageURL:@"bundle://sliderSwitchBackground.png" next:
	  [TTAreaStyle styleWithRect:CGRectMake(20, 8, 12, 12) style:[TTImageStyle styleWithImageURL:@"bundle://express.png" next:nil]
							next:
	   [TTInnerShadowStyle styleWithColor:RGBACOLOR(0,0,0,0.5) blur:6 offset:CGSizeMake(1, 1) next:
		[TTSolidBorderStyle styleWithColor:RGBCOLOR(176,176,176) width:1 next:nil]]]]];
}


-(UIImage*)sliderSegmentLeftImage{
	TTView *segmentView = [[[TTView alloc] initWithFrame:CGRectMake(0, 0, 116 , 28)] autorelease];
	segmentView.style = TTSTYLE(sliderSegmentLeftStyle);
	UILabel *label = [[[UILabel alloc] initWithFrame:CGRectMake(40, 4, 80, 20)] autorelease];
	label.text = BCLocalizedString(@"BookExpress", @"BookExpress");
	label.font = [UIFont boldSystemFontOfSize:14];
	label.textColor = RGBCOLOR(51,51,51);
	label.backgroundColor = [UIColor clearColor];
	[segmentView addSubview:label];	
	segmentView.backgroundColor = [UIColor clearColor];
	return [[[ScreenCapture capture] captureView:segmentView] stretchableImageWithLeftCapWidth:1 topCapHeight:0];
}


-(TTStyle*)sliderSegmentRightStyle{
	CGFloat imgSize = 12;
	return
	
	[TTShapeStyle styleWithShape:[TTRoundedRectangleShape shapeWithRadius:6] next:
	 
	 [TTImageStyle styleWithImageURL:@"bundle://sliderSwitchBackground.png" next:
	  [TTAreaStyle styleWithBlock:^(CGRect rect ,id data){
		 return CGRectMake(CGRectGetWidth(rect) - 20 -[[data objectAtIndex:0] floatValue], (CGRectGetHeight(rect) - [[data objectAtIndex:0] floatValue]) / 2 , 
						   [[data objectAtIndex:0] floatValue], [[data objectAtIndex:0] floatValue]);
	 } 
							 data:[NSArray arrayWithObjects:[NSNumber numberWithFloat:imgSize],nil]
							style:
	   [TTImageStyle styleWithImageURL:@"bundle://ranking.png" next:nil]
							 next:
	   [TTInnerShadowStyle styleWithColor:RGBACOLOR(0,0,0,0.5) blur:6 offset:CGSizeMake(1, 1) next:
		[TTSolidBorderStyle styleWithColor:RGBCOLOR(176,176,176) width:1 next:nil]]]]];
}

-(UIImage*)sliderSegmentRightImage{
	TTView *segmentView = [[[TTView alloc] initWithFrame:CGRectMake(0, 0, 116  , 28)] autorelease];
	segmentView.style = TTSTYLE(sliderSegmentRightStyle);
	UILabel *label = [[[UILabel alloc] initWithFrame:CGRectMake(40, 4, 80, 20)] autorelease];
	label.font = [UIFont boldSystemFontOfSize:14];
	label.text = BCLocalizedString(@"Ranking", @"Ranking");
	label.textColor = RGBCOLOR(51,51,51);
	label.backgroundColor = [UIColor clearColor];
	[segmentView addSubview:label];
	segmentView.backgroundColor = [UIColor clearColor];
	return [[[ScreenCapture capture] captureView:segmentView] stretchableImageWithLeftCapWidth:1 topCapHeight:0];
}

-(TTStyle*)sliderSegmentThumbStyle{
	return 
	[TTSolidFillStyle styleWithColor:[UIColor clearColor] next:
	 [TTShapeStyle styleWithShape:[TTRoundedRectangleShape shapeWithRadius:4.5] next:
	  [TTLinearGradientFillStyle styleWithColor1:RGBCOLOR(232,232,232) color2:RGBCOLOR(244,244,244) next:
	   [TTInsetStyle styleWithInset:UIEdgeInsetsMake(1, 0, 1, 0) next:
		[TTBevelBorderStyle styleWithHighlight:RGBCOLOR(209,209,209) shadow:[UIColor whiteColor] width:1
								   lightSource:270 next:
		 [TTInsetStyle styleWithInset:UIEdgeInsetsMake(-2, -1, -2, -1) next:
		  [TTLinearGradientBorderStyle styleWithColor1:RGBCOLOR(181,181,181) color2:RGBCOLOR(166,166,166) 
												 width:1 next:
		   
		   nil]]]]]]];
	
}

-(UIImage*)sliderSegmentThumbImage{
	TTView *thumbView = [[[TTView alloc] initWithFrame:CGRectMake(0, 0, 28, 28)] autorelease];
	thumbView.backgroundColor = [UIColor clearColor];
	thumbView.style = TTSTYLE(sliderSegmentThumbStyle);
	
	BAFillableStar *star = [[[BAFillableStar alloc] initWithFrame:CGRectMake(thumbView.width / 4 + 0.5, thumbView.height / 4  ,
																			 thumbView.width / 2 - 1, thumbView.height / 2 )] autorelease];
	star.backgroundColor = [UIColor clearColor];
	star.fillColor = RGBCOLOR(255,0,78);
	star.strokeColor =  RGBCOLOR(231,0,71);
	star.fillPercent=1;
	[thumbView addSubview:star];
	
	return	[[ScreenCapture capture] captureView:thumbView] ;
}



-(TTStyle*) bookSummaryTitleStyle{
	return 
	[TTTextStyle styleWithFont: [UIFont systemFontOfSize:22] 
						 color: RGBCOLOR(51,51,51)
			   minimumFontSize: 0
				   shadowColor: nil
				  shadowOffset: CGSizeZero
				 textAlignment: UITextAlignmentLeft
			 verticalAlignment: UIControlContentVerticalAlignmentCenter
				 lineBreakMode: UILineBreakModeCharacterWrap
				 numberOfLines: 6
						  next: nil];
}

-(TTStyle*) bookSummaryAuthorStyle{
	return 
	[TTAreaStyle styleWithRect:CGRectMake(0, 2, 10, 12) style:
	 [TTImageStyle styleWithImageURL:@"bundle://writerWhite.png" next:nil]
						  next:
	 [TTBoxStyle styleWithPadding:UIEdgeInsetsMake(0, 20, 0, 0) next:
	  [TTTextStyle styleWithFont: [UIFont systemFontOfSize:14] 
						   color: RGBCOLOR(128,128,128)
				 minimumFontSize: 0
					 shadowColor: nil
					shadowOffset: CGSizeZero
				   textAlignment: UITextAlignmentLeft
			   verticalAlignment: UIControlContentVerticalAlignmentCenter
				   lineBreakMode: UILineBreakModeCharacterWrap
				   numberOfLines: 6
							next: nil]]];
}

-(TTStyle*) bookSummaryTimelineStyle{
	return 
	[TTAreaStyle styleWithRect:CGRectMake(0, 2, 12, 12) style:
	 [TTImageStyle styleWithImageURL:@"bundle://time.png" next:nil]
						  next:
	 [TTBoxStyle styleWithPadding:UIEdgeInsetsMake(0, 20, 0, 0) next:
	  [TTTextStyle styleWithFont: [UIFont systemFontOfSize:14] 
						   color: RGBCOLOR(128,128,128)
				 minimumFontSize: 0
					 shadowColor: nil
					shadowOffset: CGSizeZero
				   textAlignment: UITextAlignmentLeft
			   verticalAlignment: UIControlContentVerticalAlignmentCenter
				   lineBreakMode: UILineBreakModeCharacterWrap
				   numberOfLines: 6
							next: nil]]];
}


-(TTStyle*) bookSummaryRateStyle{
	return 
	[TTTextStyle styleWithFont: [UIFont systemFontOfSize:14] 
						 color: RGBCOLOR(128,128,128)
			   minimumFontSize: 0
				   shadowColor: RGBCOLOR(171,171,171)
				  shadowOffset: CGSizeZero
				 textAlignment: UITextAlignmentLeft
			 verticalAlignment: UIControlContentVerticalAlignmentCenter
				 lineBreakMode: UILineBreakModeCharacterWrap
				 numberOfLines: 1
						  next: nil];
}

-(TTStyle*) testStyle{
	CGFloat timeIconWidth = 10;
	CGFloat timeIconHeight = 12;
	return 
	[TTAreaStyle styleWithBlock:^(CGRect rect ,id data){ 
		return CGRectMake(0, (CGRectGetHeight(rect) - [[data objectAtIndex:0] floatValue]) / 2 , 10, 12);
	} 
						   data:[NSArray arrayWithObjects:[NSNumber numberWithFloat:timeIconWidth],
								 [NSNumber numberWithFloat:timeIconHeight],nil]
						  style:
	 [TTImageStyle styleWithImageURL:@"bundle://time.png" next:nil]
						   next:
	 [TTBoxStyle styleWithPadding:UIEdgeInsetsMake(0, 20, 0, 0) next:
	  [TTTextStyle styleWithFont: [UIFont systemFontOfSize:14] 
						   color: RGBCOLOR(128,128,128)
				 minimumFontSize: 0
					 shadowColor: nil
					shadowOffset: CGSizeZero
				   textAlignment: UITextAlignmentLeft
			   verticalAlignment: UIControlContentVerticalAlignmentCenter
				   lineBreakMode: UILineBreakModeCharacterWrap
				   numberOfLines: 6
							next: nil]]];
}

-(TTStyle*)infoBackground{
	return [TTImageStyle styleWithImageURL:@"bundle://infoBackground.png" next:nil];
}


-(TTStyle*)backBtnCloseStyle:(UIControlState)state {
	return
	[TTAreaStyle styleWithBlock:^(CGRect rect ,id data){ 
		CGFloat imageSize = 16;
		return CGRectMake((CGRectGetWidth(rect) - imageSize)/2, (CGRectGetHeight(rect) - imageSize)/2, imageSize, imageSize);
	}	
						   data:nil
						  style:
	 [TTImageStyle styleWithImageURL:@"bundle://close.png" next:nil]
						   next:nil];
}

-(TTStyle*)popupViewStyle{
	return [TTImageStyle styleWithImageURL:@"bundle://popupViewBackground.png" next:nil];
}

-(TTStyle*)commentViewStyle{
	return [TTImageStyle styleWithImageURL:@"bundle://commentDetail.png" next:nil];
}

-(TTStyle*) authorLabelStyle{
	return  [TTTextStyle styleWithFont: [UIFont systemFontOfSize:16] 
								 color: RGBCOLOR(128,128,128)
					   minimumFontSize: 0
						   shadowColor: nil
						  shadowOffset: CGSizeZero
						 textAlignment: UITextAlignmentCenter
					 verticalAlignment: UIControlContentVerticalAlignmentCenter
						 lineBreakMode: UILineBreakModeCharacterWrap
						 numberOfLines: 1
								  next: nil];
}

- (TTStyle*)stripTab:(UIControlState)state position:(int)position{
	int radius = 6;	
	TTShape *shape = nil;
	switch (position) {
		case 0:
			shape = [TTRoundedRectangleShape shapeWithTopLeft:radius topRight:0 bottomRight:0 bottomLeft:radius];
			break;
		case 1:
			shape = [TTRoundedRectangleShape shapeWithTopLeft:0 topRight:0 bottomRight:0 bottomLeft:0];
			break;
		case 2:
			shape = [TTRoundedRectangleShape shapeWithTopLeft:0 topRight:radius bottomRight:radius bottomLeft:0];
			break;
		default:
			break;
	}
	//选中状态	
	CGFloat gap = 34;
	if (state == UIControlStateSelected) {
		return
		[TTShapeStyle styleWithShape:shape next:
		 [TTImageStyle styleWithImageURL:@"bundle://sliderSwitchBackground.png" next:
		  [TTFourBorderStyle styleWithBottom:[UIColor whiteColor] width:1 next:
		   [TTBoxStyle styleWithPadding:UIEdgeInsetsMake(5, gap, 2, gap) next:
			
			[TTInnerShadowStyle styleWithColor:RGBACOLOR(0,0,0,0.5) blur:6 offset:CGSizeMake(1, 1) next:
			 [TTTextStyle styleWithFont: [UIFont systemFontOfSize:14] 
								  color: RGBCOLOR(255,0,78)
						minimumFontSize: 0
							shadowColor: nil
						   shadowOffset: CGSizeZero
						  textAlignment: UITextAlignmentLeft
					  verticalAlignment: UIControlContentVerticalAlignmentCenter
						  lineBreakMode: UILineBreakModeCharacterWrap
						  numberOfLines: 6
								   next: nil
			  ]]]]]];
		
	} else {
		return
		
		[TTShapeStyle styleWithShape:shape next:
		 [TTBoxStyle styleWithPadding:UIEdgeInsetsMake(5, gap, 2, gap) next:	
		  [TTBevelBorderStyle styleWithHighlight:[UIColor whiteColor]
										  shadow:RGBCOLOR(181, 181, 181)
										   width:1
									 lightSource:270
											next:
		   [TTInsetStyle styleWithInset:UIEdgeInsetsMake(0, position==0? -1: -2, 0, -1) next:
			[TTBevelBorderStyle styleWithHighlight:RGBCOLOR(181, 181, 181)
											shadow:[UIColor whiteColor]
											 width:1
									   lightSource:270
											  next:
			 [TTLinearGradientFillStyle styleWithColor1:RGBCOLOR(244,244,244)
												 color2:RGBCOLOR(232,232,232) next:
			  [TTInsetStyle styleWithInset:UIEdgeInsetsMake(-3, 0, -1, -1) next:
			   [TTFourBorderStyle styleWithRight:RGBCOLOR(181, 181, 181) width:1 next:
				[TTInsetStyle styleWithInset:UIEdgeInsetsMake(3, 0, 1, 1) next:
				 [TTTextStyle styleWithFont: [UIFont systemFontOfSize:14] 
									  color: RGBCOLOR(128,128,128)
							minimumFontSize: 0
								shadowColor: nil
							   shadowOffset: CGSizeZero
							  textAlignment: UITextAlignmentLeft
						  verticalAlignment: UIControlContentVerticalAlignmentCenter
							  lineBreakMode: UILineBreakModeCharacterWrap
							  numberOfLines: 6
									   next: nil
				  ]]]]]]]]]];
	}
	
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (TTStyle*)stripTabLeft:(UIControlState)state {
	return [self stripTab:state position:0];
}
///////////////////////////////////////////////////////////////////////////////////////////////////
- (TTStyle*)stripTabCenter:(UIControlState)state {
	return [self stripTab:state position:1];
}
///////////////////////////////////////////////////////////////////////////////////////////////////
- (TTStyle*)stripTabRight:(UIControlState)state {
	return	[self stripTab:state position:2];
	
}

-(TTStyle*) favoriteTableCellStyle{
	return [TTFourBorderStyle styleWithBottom:[UIColor whiteColor] width:1 next:
			[TTInsetStyle styleWithInset:UIEdgeInsetsMake(0, -1, 0, -1) next:
			 [TTFourBorderStyle styleWithBottom:RGBCOLOR(187,187,187) width:1 next:
			  [TTSolidFillStyle styleWithColor:RGBCOLOR(241,241,241) next:nil
			   ]]]];
}




///////////////////////////////////////////////////////////////////////////////////////////////////
- (TTStyle*)feedbackLinkStyle:(UIControlState)state {
	CGFloat imgSize = 18;
	if (state == UIControlStateNormal) {
		return
		[TTShapeStyle styleWithShape:[TTRoundedRectangleShape shapeWithRadius:8] next:
		 [TTLinearGradientFillStyle styleWithColor1:RGBCOLOR(252,252, 252)
											 color2:RGBCOLOR(241, 241, 241) next:
		  [TTSolidBorderStyle styleWithColor:RGBCOLOR(218, 218, 218) width:1 next:
		   [TTInsetStyle styleWithInset:UIEdgeInsetsMake(0, 0, 0, -1) next:
			[TTFourBorderStyle styleWithBottom:RGBCOLOR(171,171,171) width:1 next:
			 [TTInsetStyle styleWithInset:UIEdgeInsetsMake(0, 0, 0, -1) next:
			  [TTFourBorderStyle styleWithBottom:RGBCOLOR(254,254,254) width:1 next:
			   [TTAreaStyle styleWithBlock:^(CGRect rect ,id data){ 
				  return CGRectMake(BKContentMargin, (CGRectGetHeight(rect) - [[data objectAtIndex:0] floatValue]) / 2 ,[[data objectAtIndex:0] floatValue] , [[data objectAtIndex:0] floatValue]);
			  } 
									  data:[NSArray arrayWithObjects:[NSNumber numberWithFloat:imgSize],
											nil]
									 style:[TTImageStyle styleWithImageURL:@"bundle://feedback.png" next:nil]
									  next:
				[TTAreaStyle styleWithBlock:^(CGRect rect ,id data){ 
				   return CGRectMake(CGRectGetWidth(rect) - BKContentMargin - [[data objectAtIndex:0] floatValue], (CGRectGetHeight(rect) - [[data objectAtIndex:0] floatValue]) / 2 ,[[data objectAtIndex:0] floatValue] , [[data objectAtIndex:0] floatValue]);
			   } 
									   data:[NSArray arrayWithObjects:[NSNumber numberWithFloat:imgSize],
											 nil]
									  style:[TTImageStyle styleWithImageURL:@"bundle://arrowGray.png" next:nil]
									   next:
				 [TTBoxStyle styleWithPadding:UIEdgeInsetsMake(0, BKContentMargin*2+imgSize, 0, 0) next:
				  [TTTextStyle styleWithFont: [UIFont systemFontOfSize:18]
									   color: RGBCOLOR(235,0,72)	
							 minimumFontSize: 0
								 shadowColor: nil
								shadowOffset: CGSizeMake(0, 0)
							   textAlignment: UITextAlignmentLeft
						   verticalAlignment: UIControlContentVerticalAlignmentCenter
							   lineBreakMode: UILineBreakModeCharacterWrap
							   numberOfLines: 0
										next: nil]]]]]]]]]]];
	} else if (state == UIControlStateHighlighted) {
		return
		[TTShapeStyle styleWithShape:[TTRoundedRectangleShape shapeWithRadius:8] next:
		 [TTLinearGradientFillStyle styleWithColor1:RGBCOLOR(252,252, 252)
											 color2:RGBCOLOR(241, 241, 241) next:
		  [TTSolidBorderStyle styleWithColor:RGBCOLOR(218, 218, 218) width:1 next:
		   [TTInsetStyle styleWithInset:UIEdgeInsetsMake(0, 0, 0, -1) next:
			[TTFourBorderStyle styleWithBottom:RGBCOLOR(171,171,171) width:1 next:
			 [TTInsetStyle styleWithInset:UIEdgeInsetsMake(0, 0, 0, -1) next:
			  [TTFourBorderStyle styleWithBottom:RGBCOLOR(254,254,254) width:1 next:
			   [TTAreaStyle styleWithBlock:^(CGRect rect ,id data){ 
				  return CGRectMake(BKContentMargin, (CGRectGetHeight(rect) - [[data objectAtIndex:0] floatValue]) / 2 ,[[data objectAtIndex:0] floatValue] , [[data objectAtIndex:0] floatValue]);
			  } 
									  data:[NSArray arrayWithObjects:[NSNumber numberWithFloat:imgSize],
											nil]
									 style:[TTImageStyle styleWithImageURL:@"bundle://feedback.png" next:nil]
									  next:
				[TTAreaStyle styleWithBlock:^(CGRect rect ,id data){ 
				   return CGRectMake(CGRectGetWidth(rect) - BKContentMargin - [[data objectAtIndex:0] floatValue], (CGRectGetHeight(rect) - [[data objectAtIndex:0] floatValue]) / 2 ,[[data objectAtIndex:0] floatValue] , [[data objectAtIndex:0] floatValue]);
			   } 
									   data:[NSArray arrayWithObjects:[NSNumber numberWithFloat:imgSize],
											 nil]
									  style:[TTImageStyle styleWithImageURL:@"bundle://arrowGray.png" next:nil]
									   next:
				 [TTBoxStyle styleWithPadding:UIEdgeInsetsMake(0, BKContentMargin*2+imgSize, 0, 0) next:
				  [TTTextStyle styleWithFont: [UIFont systemFontOfSize:18]
									   color: RGBCOLOR(235,0,72)	
							 minimumFontSize: 0
								 shadowColor: nil
								shadowOffset: CGSizeMake(0, 0)
							   textAlignment: UITextAlignmentLeft
						   verticalAlignment: UIControlContentVerticalAlignmentCenter
							   lineBreakMode: UILineBreakModeCharacterWrap
							   numberOfLines: 0
										next: nil]]]]]]]]]]];
	} else {
		return nil;
	}
}



-(UIImage*)defalutAvatar{
	return [UIImage imageNamed:@"authorAvatar.png"];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (TTStyle*)authorAvatarStyle:(UIControlState)state {
	if (state & UIControlStateHighlighted) {
		return
		[TTShadowStyle styleWithColor:RGBACOLOR(100,100,100,0.5) blur:2 offset:CGSizeMake(0, 1) next:
		 [TTSolidFillStyle styleWithColor:[UIColor whiteColor] next:
		  
		  [TTBoxStyle styleWithPadding:UIEdgeInsetsMake(3, 3, 3, 3) next:
		   [TTImageStyle styleWithImage:[self defalutAvatar] defaultImage:nil
							contentMode:UIViewContentModeScaleToFill size:CGSizeZero next:
			[TTImageStyle styleWithImage:nil defaultImage:nil
							 contentMode:UIViewContentModeScaleToFill size:CGSizeZero next:
			 [TTSolidBorderStyle styleWithColor:RGBCOLOR(212,212,212) width:1 next:nil
			  ]]]]]];
	} else {
		return
		[TTShadowStyle styleWithColor:RGBACOLOR(100,100,100,0.5) blur:2 offset:CGSizeMake(0, 1) next:
		 [TTSolidFillStyle styleWithColor:[UIColor whiteColor] next:
		  
		  [TTBoxStyle styleWithPadding:UIEdgeInsetsMake(3, 3, 3, 3) next:
		   [TTImageStyle styleWithImage:[self defalutAvatar] defaultImage:nil
							contentMode:UIViewContentModeScaleToFill size:CGSizeZero next:
			[TTImageStyle styleWithImage:nil defaultImage:nil
							 contentMode:UIViewContentModeScaleToFill size:CGSizeZero next:
			 [TTSolidBorderStyle styleWithColor:RGBCOLOR(212,212,212) width:1 next:nil
			  ]]]]]];	}
}


-(TTStyle*)booknameStyle{
	return 
	[TTBoxStyle styleWithMargin:UIEdgeInsetsMake(0, 0, BKContentMargin, 0) next:
	 [TTTextStyle styleWithFont: [UIFont systemFontOfSize:16]
						  color: RGBCOLOR(48,48,48)	
				minimumFontSize: 0
					shadowColor: nil
				   shadowOffset: CGSizeMake(0, 0)
				  textAlignment: UITextAlignmentLeft
			  verticalAlignment: UIControlContentVerticalAlignmentCenter
				  lineBreakMode: UILineBreakModeCharacterWrap
				  numberOfLines: 0
						   next: nil]];
}

-(TTStyle*)bookItemStyle{
	return 
	[TTBoxStyle styleWithMargin:UIEdgeInsetsMake(0, 0, BKContentSmallMargin, 0) next:
	 [TTTextStyle styleWithFont: [UIFont systemFontOfSize:14]
						  color: RGBCOLOR(116,116,116)	
				minimumFontSize: 0
					shadowColor: nil
				   shadowOffset: CGSizeMake(0, 0)
				  textAlignment: UITextAlignmentLeft
			  verticalAlignment: UIControlContentVerticalAlignmentCenter
				  lineBreakMode: UILineBreakModeCharacterWrap
				  numberOfLines: 0
						   next: nil]];
}

-(TTStyle*) commentDismissBtnStyle:(UIControlState)state{
	//选中状态
	if (state == UIControlStateSelected) {
		return
		[TTImageStyle styleWithImageURL:@"bundle://shrink.png" next:nil];
		
	} else {
		return
		[TTImageStyle styleWithImageURL:@"bundle://shrink.png" next:nil];
		
	}
	
}

-(TTStyle*) bookThumbStyle:(UIControlState)state{
	UIImage *defaultImage = [self defalutBookCover];
	
	if (state & UIControlStateHighlighted) {
		return
		[TTSolidFillStyle styleWithColor:[UIColor clearColor]  next:
		 [TTShapeStyle styleWithShape:[TTRoundedRectangleShape shapeWithRadius:5] next:
		  [TTBoxStyle styleWithPadding:UIEdgeInsetsMake(2, 2, 2, 2) next:
		   [TTImageStyle styleWithImage:defaultImage next:
			[TTImageStyle styleWithImage:nil defaultImage:nil
							 contentMode:UIViewContentModeScaleToFill size:CGSizeZero next:
			 [TTImageStyle styleWithImage:nil defaultImage:nil
							  contentMode:UIViewContentModeScaleToFill size:CGSizeZero next:nil
			  ]]]]]];
	} else {
		return
		[TTSolidFillStyle styleWithColor:[UIColor clearColor]  next:
		 [TTShapeStyle styleWithShape:[TTRoundedRectangleShape shapeWithRadius:5] next:
		  [TTBoxStyle styleWithPadding:UIEdgeInsetsMake(2, 2, 2, 2) next:
		   [TTImageStyle styleWithImage:defaultImage next:
		   [TTImageStyle styleWithImage:nil defaultImage:nil
							contentMode:UIViewContentModeScaleToFill size:CGSizeZero next:
			[TTImageStyle styleWithImage:nil defaultImage:nil
							 contentMode:UIViewContentModeScaleToFill size:CGSizeZero next:nil
			 ]]]]]];
	}
	

}

-(TTStyle*) bookViewThumbStyle:(UIControlState)state{
	
	UIImage *defaultImage = [self defalutBookCover];
	if (state & UIControlStateHighlighted) {
		return
		[TTSolidBorderStyle styleWithColor:RGBCOLOR(250,250,250) width:1 next:
		   [TTImageStyle styleWithImage:defaultImage next:
			[TTImageStyle styleWithImage:nil defaultImage:nil
							 contentMode:UIViewContentModeScaleToFill size:CGSizeZero next:
			 [TTImageStyle styleWithImage:nil defaultImage:nil
							  contentMode:UIViewContentModeScaleToFill size:CGSizeZero next:nil
			  ]]]];
	} else {
		return
		[TTSolidBorderStyle styleWithColor:RGBCOLOR(250,250,250) width:1 next:
		 [TTImageStyle styleWithImage:defaultImage next:
		  [TTImageStyle styleWithImage:nil defaultImage:nil
						   contentMode:UIViewContentModeScaleToFill size:CGSizeZero next:
		   [TTImageStyle styleWithImage:nil defaultImage:nil
							contentMode:UIViewContentModeScaleToFill size:CGSizeZero next:nil
			]]]];
	}
	
	
}



-(UIImage*)defalutBookCover{
	u_int32_t i =  arc4random() % 8;
	return [UIImage imageNamed:[NSString stringWithFormat:@"%d.png",i]];
}

-(TTStyle*) progressHUDStyle{
	return 
	[TTShapeStyle styleWithShape:[TTRoundedRectangleShape shapeWithRadius:5] next:
	 [TTFourBorderStyle styleWithTop:RGBCOLOR(250,250,250) right:RGBCOLOR(250,250,250) bottom:RGBCOLOR(250,250,250)
								left:RGBCOLOR(250,250,250) width:1 next:
	 [TTSolidFillStyle styleWithColor:RGBACOLOR(243,243,243,0.7) next:nil
		 ]]];
}

-(TTStyle*)composeViewStyle{
	return 
	[TTShapeStyle styleWithShape:[TTRoundedRectangleShape shapeWithRadius:6] next:
	 [TTFourBorderStyle styleWithTop:RGBCOLOR(250,250,250) right:RGBCOLOR(250,250,250) bottom:RGBCOLOR(250,250,250)
								left:RGBCOLOR(250,250,250) width:1 next:
	  [TTSolidFillStyle styleWithColor:RGBACOLOR(243,243,243,0.5) next:
	   [TTInsetStyle styleWithInset:UIEdgeInsetsMake(4, 4, 4, 4) next:
		[TTSolidFillStyle styleWithColor:RGBACOLOR(243,243,243,.7) next:
		 [TTInsetStyle styleWithInset:UIEdgeInsetsMake(35, 6, 35, 6) next:
		  [TTSolidFillStyle styleWithColor:RGBACOLOR(243,243,243,.8) next:nil
		   ]]]]]]];
}


-(TTStyle*) closeButtonStyle:(UIControlState)state{
	
	//选中状态
	if (state == UIControlStateSelected) {
		return
		[TTImageStyle styleWithImageURL:@"bundle://shrink.png" next:nil];
		
	} else {
		return
		[TTImageStyle styleWithImageURL:@"bundle://shrink.png" next:nil];
		
	}
	
	
}

-(TTStyle*)submitButtonStyle:(UIControlState)state{
	//选中状态
	if (state == UIControlStateSelected) {
		UIColor* border = [TTSTYLEVAR(tabBarTintColor) multiplyHue:0 saturation:0 value:0.7];
		
		return
		[TTShapeStyle styleWithShape:[TTRoundedRectangleShape shapeWithRadius:4.5] next:
		 [TTSolidBorderStyle styleWithColor:RGBCOLOR(187,187,187) width:1 next:
		  [TTLinearGradientFillStyle styleWithColor1:[UIColor whiteColor]
											  color2:RGBCOLOR(212,212,212) next:
		   [TTBoxStyle styleWithPadding:UIEdgeInsetsMake(4, 12, 4, 12) next:
			[TTTextStyle styleWithFont:[UIFont systemFontOfSize:14] color:RGBCOLOR(255,0,78)
					   minimumFontSize:8
						   shadowColor:nil shadowOffset:CGSizeZero
						 textAlignment:UITextAlignmentCenter
					 verticalAlignment:UIControlContentVerticalAlignmentTop
						 lineBreakMode:UILineBreakModeWordWrap numberOfLines:1
								  next:nil]]]]];
	} else {
		return
		[TTShapeStyle styleWithShape:[TTRoundedRectangleShape shapeWithRadius:4.5] next:
		 [TTSolidBorderStyle styleWithColor:RGBCOLOR(187,187,187) width:1 next:
		  [TTLinearGradientFillStyle styleWithColor1:[UIColor whiteColor]
											  color2:RGBCOLOR(212,212,212) next:
		   [TTBoxStyle styleWithPadding:UIEdgeInsetsMake(4, 12, 4, 12) next:
			[TTTextStyle styleWithFont:[UIFont systemFontOfSize:14] color:RGBCOLOR(255,0,78)
					   minimumFontSize:8
						   shadowColor:nil shadowOffset:CGSizeMake(0, 0)
						 textAlignment:UITextAlignmentCenter
					 verticalAlignment:UIControlContentVerticalAlignmentTop
						 lineBreakMode:UILineBreakModeWordWrap numberOfLines:1
								  next:nil]]]]];
	}  

	
	
}



-(TTStyle*)sharebookTitleStyle{
	return [TTTextStyle styleWithFont:[UIFont systemFontOfSize:16] color:RGBCOLOR(33,33,33)
			   minimumFontSize:0 
				   shadowColor:nil 
				  shadowOffset:CGSizeZero next:nil];
}


@end






