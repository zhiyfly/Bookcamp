//
//  BookHeadView.m
//
// Created by lin waiwai(jiansihun@foxmail.com) on 1/19/11.
// Copyright 2011 __waiwai__. All rights reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//

#import "BookHeadView.h"
// UI
#import "Three20UI/TTImageView.h"
#import "Three20UI/TTTableMessageItem.h"
#import "Three20UI/UIViewAdditions.h"
#import "Three20Style/UIFontAdditions.h"

// Style
#import "Three20Style/TTGlobalStyle.h"
#import "Three20Style/TTDefaultStyleSheet.h"

// Core
#import "Three20Core/TTCorePreprocessorMacros.h"
#import "Three20Core/NSDateAdditions.h"

static const int  DefaultAuthorThumbHeight  = BKAuthorThumbHeight;
static const int DefaultBookThumbWidth = 105;
static const int DefaultBookThumbHeight = 142;  

static const int DefaultLinkButtonWidth = BKDefaultLinkButtonWidth;
static const int DefaultLinkButtonHeight = BKDefaultLinkButtonHeight;

@implementation BookHeadView

@synthesize bookThumb =  _bookThumb;
@synthesize info = _info;
@synthesize ratingLabel = _ratingLabel;
@synthesize ratingView = _ratingView;




///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)dealloc {
	TT_RELEASE_SAFELY(_item);
	TT_RELEASE_SAFELY(_bookThumb);
	TT_RELEASE_SAFELY(_info);
	TT_RELEASE_SAFELY(_ratingView);


	TT_RELEASE_SAFELY (_HUD);
    [super dealloc];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
-(id)object{
	return _item;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setObject:(id)object {	
	if (self.object != object) {
		[_item release];
		_item = [object retain];
		
		BookObject* item = object;
		if (item.thumbURL) {
			self.bookThumb.thumbURL = item.thumbURL;
		}
		
		NSString *format = @"<div class=\"booknameStyle\">%@</div><div class=\"bookItemStyle\">%@</div><div class=\"bookItemStyle\">%@</div><div class=\"bookItemStyle\">%@</div><div class=\"bookItemStyle\">%@</div>";
		
		NSString *author = @"";
		if ([item.authors count] > 0) {
			author = [item.authors objectAtIndex:0];
		}
		
		
		NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
		[dateFormatter setLocale:[NSLocale currentLocale]];
		[dateFormatter setDateFormat:@"yyyy-MM-dd"];
		
		NSString *infoStr = [NSString stringWithFormat:format,
							 item.bookName? item.bookName:@"",author?author:@"",
							 [dateFormatter stringFromDate:item.pubdate]?[dateFormatter stringFromDate:item.pubdate]:@"",item.publisher?item.publisher:@"", 
							 item.pages?[NSString stringWithFormat:BCLocalizedString(@"page format", @"page format") , item.pages]:@"" ];
		
		TTStyledText *styleText = [TTStyledText textFromXHTML:infoStr lineBreaks:YES URLs:NO];
		if (item.thumbURL) {
			styleText.width = self.width - (BKContentMargin*3 + DefaultBookThumbWidth );
		} else {
			styleText.width = self.width - BKContentMargin * 2;
		}
		self.info.text = styleText;
		
		if (item.averageRate) {
			
			[self.ratingView setRating:item.averageRate];
			self.ratingLabel.text = [NSString stringWithFormat:BCLocalizedString(@"rating format", @"rating format"),item.averageRate];
		}
		//		if (item.bookCommentURL) {
		//			self.bookCommentLink.URL = item.bookCommentURL; 
		//		}
		//		if (item.parityURL){
		//			self.parityLink.URL =  item.parityURL;
		//		}
		//		if (item.evaluationNum) {
		//			self.evaluationNumLabel.text =[NSString stringWithFormat:BCLocalizedString(@"(%@)HaveGiveAEvaluation",
		//																					   @"the number of person who have give the book a evaluation"),
		//										   item.evaluationNum];
		//
		//		}
	}
}




///////////////////////////////////////////////////////////////////////////////////////////////////
-(UILabel*)ratingLabel{
	if (!_ratingLabel) {
		_ratingLabel = [[UILabel alloc] init];
		_ratingLabel.backgroundColor  = [UIColor clearColor];
		_ratingLabel.font = [UIFont systemFontOfSize:14];
		_ratingLabel.textColor = RGBCOLOR(116,116,116);
		[self addSubview:_ratingLabel];
	}
	return _ratingLabel;
}



///////////////////////////////////////////////////////////////////////////////////////////////////
-(TTThumbView*)bookThumb{
	if (!_bookThumb) {
		_bookThumb = [[TTThumbView alloc] init];
		[_bookThumb setStylesWithSelector:@"bookViewThumbStyle:"];
		[self addSubview:_bookThumb];
		[_bookThumb addTarget:self action:@selector(postNewStatus) forControlEvents:UIControlEventTouchUpInside];
	}
	return _bookThumb;
}
 
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    shareToType = buttonIndex;
    NSString *currentUid = [UMSNSService getUid:UMENG_KEY andForPlatform:(UMShareToType)buttonIndex error:nil];
    
	BookViewController *bookViewController = (BookViewController*)[TTNavigator navigator].visibleViewController ;
        
    
    NSDictionary *authData = [[NSUserDefaults standardUserDefaults] objectForKey: @"authData"];
    if (!authData) {
        authData  = [NSDictionary dictionary];
    }

    NSDictionary *bindInfo = [authData objectForKey:(NSString*)connectedSiteStr[shareToType]];
    
 
    
    if (currentUid && bindInfo && HasBound == (BoundStatus)[[bindInfo objectForKey:@"BindStatus"] intValue] ) {
        shareToType = (UMShareToType)buttonIndex;
		[self performSelectorOnMainThread:@selector(compose) withObject:nil waitUntilDone:NO];
        return;
    } else {
        //go to oauth
        [UMSNSService setDataSendDelegate:self];
        [UMSNSService setOauthDelegate:self];
        switch (buttonIndex) {
            case 0:
                [UMSNSService oauthRenr:bookViewController andAppkey:UMENG_KEY];

                break;
            case 1:
                  [UMSNSService oauthSina:bookViewController andAppkey:UMENG_KEY];  
  
                break;
            case 2:
                [UMSNSService oauthTenc:bookViewController andAppkey:UMENG_KEY];    
                break;
            default:
                break;
				
        }
		
    }
}

- (void)oauthDidFinish:(NSString *)uid andAccessToken:(NSDictionary *)accessToken andPlatformType:(UMShareToType)platfrom{
    NSError *error;
    
    NSString *currentUid = [UMSNSService getUid:UMENG_KEY andForPlatform:platfrom error:nil];

    
	BookViewController *bookViewController = (	BookViewController *)[TTNavigator navigator].visibleViewController ;
    shareToType = platfrom;
    NSMutableDictionary *authData = [NSMutableDictionary dictionaryWithDictionary: [[NSUserDefaults standardUserDefaults] objectForKey: @"authData"]];
    if (!authData) {
        authData  = [NSMutableDictionary dictionary];
    }
    
    NSDictionary *bindInfo = [authData objectForKey:(NSString*)connectedSiteStr[shareToType]];
    

    
    if (currentUid) {

		NSDictionary *bindInfo =  [NSDictionary dictionaryWithObject:[NSNumber numberWithInt:HasBound] forKey:@"BindStatus"];
        

        [authData setObject:bindInfo forKey:(NSString*)connectedSiteStr[shareToType]];
        //NSDictionary *another = [NSDictionary dictionaryWithDictionary:authData];
        [[NSUserDefaults standardUserDefaults] setValue:authData forKey:@"authData"];
        [[NSUserDefaults standardUserDefaults] synchronize];

		[self performSelector:@selector(compose) withObject:nil afterDelay:0.1];

        
    } 
}


-(void)compose{
	
	UIView *navView = [TTNavigator navigator].visibleViewController.navigationController.view;
	
	UIControl *customView =  [[[UIControl alloc] initWithFrame:navView.frame] autorelease];
	[customView addTarget:self action:@selector(closeWindow:) forControlEvents:UIControlEventTouchUpInside];
	// can't set the opaque directly for it change the subviews's opaque 
	customView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.5];
	
	[customView addSubview: [self makeComposeView:customView.frame]];
	
	self.HUD.customView =customView;
	self.HUD.mode = MBProgressHUDModeCustomView;
	[self.HUD show:YES];
}

- (void)postNewStatus {
    
    UIActionSheet   *sheet = [[UIActionSheet alloc] initWithTitle:@"分享到" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"人人网",@"新浪微博",@"腾讯微博",nil];
    
	BookViewController *bookViewController = [TTNavigator navigator].visibleViewController ;
    [sheet showInView:bookViewController.view];
	
}

-(MBProgressHUD*)HUD{
	if (!_HUD) {
		UIView *navView = (UIView*)[TTNavigator navigator].visibleViewController.navigationController.view;
		_HUD = [[MBProgressHUD alloc] initWithView:[TTNavigator navigator].visibleViewController.navigationController.view];
		
		//HUD.style = TTSTYLE(progressHUDStyle);
		
		// Add HUD to screen
		[[TTNavigator navigator].visibleViewController.navigationController.view addSubview:_HUD];
		
		// Regisete for HUD callbacks so we can remove it from the window at the right time
		_HUD.delegate =  [[UIApplication sharedApplication] delegate];
		
	}
	return _HUD;
}

-(void)closeWindow:(TTButton*)btn{
	[self.HUD hide:YES];
}


#define cancelBtnHeight 24.f
#define cancelBtnWidth 24.f
#define StatuseTextViewTag 1
#define ContainerViewTag 2
#define LengthTipViewTag 3


-(UIView*)makeComposeView :(CGRect)frame{
	CGFloat leftOffset = 20;
	CGFloat inset = 6;
	UIView *container = [[[UIView alloc] initWithFrame:CGRectMake(leftOffset,  
																  CGRectGetHeight(frame) / 4 - cancelBtnHeight / 2,
																  CGRectGetWidth(frame) - 2 * leftOffset + cancelBtnWidth / 2 ,
																  CGRectGetHeight(frame) / 2 - cancelBtnWidth / 2)] autorelease];
	container.backgroundColor = [UIColor clearColor];
	container.tag = ContainerViewTag;
	TTView *compose = [[[TTView alloc] initWithFrame:CGRectMake(0,  cancelBtnHeight / 2, 
															   CGRectGetWidth(container.frame) - cancelBtnWidth / 2  , 
															   CGRectGetHeight(container.frame) - cancelBtnHeight / 2)] autorelease];
	compose.backgroundColor = [UIColor clearColor];
	compose.style = TTSTYLE(composeViewStyle);
	TTButton *cancelBtn = [[[TTButton alloc] initWithFrame:CGRectMake(CGRectGetWidth(container.frame) - cancelBtnWidth, 0,
																	 cancelBtnWidth, cancelBtnHeight)] autorelease];
	
	cancelBtn.backgroundColor = [UIColor clearColor];
	[cancelBtn setStylesWithSelector:@"closeButtonStyle:"];
	[cancelBtn setTitle:BCLocalizedString(@"cancel", @"cancel") forState:UIControlStateNormal];
	[cancelBtn addTarget:self action:@selector(closeWindow:) forControlEvents:UIControlEventTouchUpInside];
	[container addSubview:cancelBtn];
	[container addSubview:compose];
	
	TTLabel *titleLable = [[[TTLabel alloc] initWithFrame:CGRectMake(leftOffset, 10, 
																	 CGRectGetWidth(container.frame) - leftOffset *2, 0)] autorelease];
	titleLable.text = BCLocalizedString(@"share book title", @"share book title");
	titleLable.style =  TTSTYLE(sharebookTitleStyle);
	titleLable.backgroundColor = [UIColor clearColor];
	[titleLable sizeToFit];

	UITextView *textInput =  [[[UITextView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(titleLable.frame) + 12,  CGRectGetWidth(compose.frame) - 10 *2, 130)] autorelease];
	textInput.delegate = self;
	textInput.backgroundColor = [UIColor clearColor];
	NSString *format =  BCLocalizedString(@"I am reading %@. Recommend it to friends,the douban link is %@", @"I am reading %@. Recommend it to friends")	;
	textInput.tag = StatuseTextViewTag;
	BookObject* item = self.object;
	if (item) {
		textInput.text = [NSString stringWithFormat:format, item.bookName ,item.oid ];
	}

	[compose addSubview:textInput];
	[compose addSubview:titleLable];
	
	
	TTButton *submitBtn = [[[TTButton alloc] init] autorelease];
	
	submitBtn.backgroundColor = [UIColor clearColor];
	[submitBtn setStylesWithSelector:@"submitButtonStyle:"];
	[submitBtn setTitle:BCLocalizedString(@"share", @"share") forState:UIControlStateNormal];
	[submitBtn addTarget:self action:@selector(submitStatus) forControlEvents:UIControlEventTouchUpInside];
	[submitBtn sizeToFit];
	submitBtn.frame = CGRectMake(compose.width - submitBtn.width - inset*2, compose.height - submitBtn.height -( inset+4),
								 submitBtn.width, submitBtn.height);
	
	[compose addSubview:submitBtn];
	
	UILabel *lengthTipView = [[[UILabel alloc] initWithFrame:CGRectMake(inset*2, compose.height - submitBtn.height - inset, 0, 0)] autorelease];
	lengthTipView.backgroundColor = [UIColor clearColor];
	lengthTipView.textColor = [UIColor blackColor];
	lengthTipView.tag = LengthTipViewTag;
	lengthTipView.font = [UIFont systemFontOfSize:12];
	lengthTipView.text = [NSString stringWithFormat:@"%d", 140 - [textInput.text length]];
	[lengthTipView sizeToFit];
	[compose addSubview:lengthTipView];
	
	
	return container;
}	

- (void)textViewDidBeginEditing:(UITextView *)textView
{
	[self animateTextView: YES];
}

-(void)textViewDidChange:(UITextView *)textView{
	UILabel *lengthTipView = [self.HUD viewWithTag:LengthTipViewTag];
	lengthTipView.text = [NSString stringWithFormat:@"%d", 140 - [[textView text] length]];
	lengthTipView.textColor = 140 > [[textView text] length]  ? [UIColor blackColor]:[UIColor redColor];
	[lengthTipView sizeToFit];
}


- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    // Any new character added is passed in as the "text" parameter
    if ([text isEqualToString:@"\n"]) {
        // Be sure to test for equality using the "isEqualToString" message
        [textView resignFirstResponder];
		
        // Return FALSE so that the final '\n' character doesn't get added
        return FALSE;
    }
    // For any other character return TRUE so that the text gets added to the view
    return TRUE;
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
	[self animateTextView: NO];
}



- (void) animateTextView: (BOOL) up
{
	int movementDistance ;
	UIView *componseView = [self.HUD viewWithTag:ContainerViewTag];
		movementDistance = 85; // tweak as needed
    const float movementDuration = 0.3f; // tweak as needed
	
    int movement = (up ? -movementDistance : movementDistance);
	
    [UIView beginAnimations: @"anim" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    componseView.frame = CGRectOffset(componseView.frame, 0, movement);
    [UIView commitAnimations];
}



-(void)submitStatus{
	
	BookViewController *bookViewController = [TTNavigator navigator].visibleViewController ;
	 
	int maxLength = 140;
	UITextView *statusView =  [self.HUD viewWithTag:StatuseTextViewTag];
	
	if (statusView.text.length >= maxLength)
    {
        statusView.text = [statusView.text substringToIndex:maxLength];
    }
	
	
	if([bookViewController isKindOfClass:[BookViewController class]]){
        NSError *error;
        
        NSString *uid = [UMSNSService getUid:UMENG_KEY andForPlatform:shareToType error:error];
        
        //save to the posted image to tmp path 
        UIImage *image = [bookViewController imageFromCurrentBook];
        

        
        if ( uid ){
            UMReturnStatusType type = [UMSNSService update:shareToType andAppkey:UMENG_KEY andUid:uid andStatus:statusView.text andImageToShare:image error:error];
                 
            MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView: [TTNavigator navigator].visibleViewController.navigationController.view];
            
            switch (type) {
                case UMReturnStatusTypeUpdated:
                    
                    //successful to get response
              
                    HUD.style = TTSTYLE(progressHUDStyle);
                    // The sample image is based on the work by www.pixelpressicons.com, http://creativecommons.org/licenses/by/2.5/ca/
                    // Make the customViews 37 by 37 pixels for best results (those are the bounds of the build-in progress indicators)
                    HUD.customView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"checkmark.png"]] autorelease];
                    
                    // Set custom view mode
                    HUD.mode = MBProgressHUDModeCustomView;
                    
                    // Add HUD to screen
                    [ [TTNavigator navigator].visibleViewController.navigationController.view addSubview:HUD];
                    
                    // Regisete for HUD callbacks so we can remove it from the window at the right time
                    HUD.delegate =  [[UIApplication sharedApplication] delegate];
                    HUD.minShowTime = 2;
                    HUD.labelText = BCLocalizedString(@"successful to share", @"successful to share");
                    [HUD show:YES];
                    [HUD hide:YES];
                    
                    break;
                case UMReturnStatusTypeRepeated:
                    break;
                case UMReturnStatusTypeFileToLarge:
                    break;
                case UMReturnStatusTypeExtendSendLimit:
                    break;
                case UMReturnStatusTypeUnknownError:
                default:
                    break;
            }
            [HUD release];
      
        }
        
	} 
    
	[self.HUD hide:YES];
}


  


///////////////////////////////////////////////////////////////////////////////////////////////////
-(TTStyledTextLabel*)info{
	if (!_info) {
		_info =  [[TTStyledTextLabel alloc] init];
		_info.backgroundColor = [UIColor clearColor];
		[self addSubview:_info];
	}
	
	return _info;
	
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (RatingView*)ratingView {
	if (!_ratingView) {
		_ratingView = [[RatingView alloc] initWithFrame:CGRectMake(0, 0, 105, 20)];
		[self addSubview:_ratingView];
	}
	return _ratingView;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
-(void)layoutSubviews{
	[super layoutSubviews];
	
	CGFloat left = 0;
	if (_bookThumb) {
		_bookThumb.frame = CGRectMake(BKContentMargin, BKContentMargin,
								   DefaultBookThumbWidth, DefaultBookThumbHeight);
		left += BKContentMargin + DefaultBookThumbWidth + BKContentMargin;
	} else {
		left = BKContentMargin;
	}
	

	
	CGFloat width = self.width - left;
	CGFloat top = BKContentMargin;
	
	if (_info) {
		_info.frame = CGRectMake(left, top, width, 0);
		[_info sizeToFit];
		_info.frame = CGRectMake(left, top, _info.width, _info.height);
		top += _info.height;
	}

	if ((int)[_ratingView rating]!=RatingHidden) {
		[_ratingView setFrame:CGRectMake( left, top, RatingViewWidth, RatingViewHeight)];
		
	}else {
		[_ratingView setFrame:CGRectZero];
	}
	
	if (_ratingLabel.text.length) {
		_ratingLabel.frame = CGRectMake(left+RatingViewWidth +  BKContentMargin, top, _ratingLabel.font.ttLineHeight*2, _ratingLabel.font.ttLineHeight);
	}else {
		_ratingLabel.frame = CGRectZero;
	}
//	if (_evaluationNumLabel.text.length) {
//		if (_ratingLabel.text.length) {
//			_evaluationNumLabel.frame =  CGRectMake(CGRectGetMaxX(_ratingLabel.frame), top, 120, _evaluationNumLabel.font.ttLineHeight);
//		}
//		else {
//			_evaluationNumLabel.frame =  CGRectMake(left+RatingViewWidth, top, width - RatingViewWidth, _evaluationNumLabel.font.ttLineHeight);
//		}
//	}else {
//		_evaluationNumLabel.frame = CGRectZero;
//	}
//	if ((int)[_ratingView rating]!=RatingHidden)
//	top += RatingViewHeight + BKContentSmallMargin;
//
//	
//	if ([_bookCommentLink.URL length]) {
//		_bookCommentLink.frame = CGRectMake(left, top, DefaultLinkButtonWidth, DefaultLinkButtonHeight);
//		[_bookCommentLink setTitle:BCLocalizedString(@"BookCommentLink",@"the link button text of BookComment") forState:UIControlStateNormal];
//		
//
//		top += DefaultLinkButtonHeight;
//	} else {
//		_bookCommentLink.frame = CGRectZero;
//	}
//	
//	if ([_parityLink.URL length]) {
//		_parityLink.frame = CGRectMake(left, top, DefaultLinkButtonWidth, DefaultLinkButtonHeight);
//		[_parityLink setTitle:BCLocalizedString(@"ParityLink",@"the link button text of ParityLink") forState:UIControlStateNormal];
//		top += DefaultLinkButtonHeight;
//	} else {
//		_parityLink.frame = CGRectZero;
//	}

}



///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithFrame:(CGRect)frame {

    if ([super initWithFrame:frame]) {
		self.backgroundColor = [UIColor whiteColor];
        // Initialization code.
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code.
}
*/



@end
