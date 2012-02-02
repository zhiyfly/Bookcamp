//
//  GlobalStyleSheet.h
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

#import <Foundation/Foundation.h>
#import "extThree20CSSStyle/extThree20CSSStyle.h"

@interface GlobalStyleSheet : TTDefaultCSSStyleSheet {

}
- (TTStyle*)linkButton:(UIControlState)state;
-(UIFont*)titleFont;
-(UIFont*)summaryFont;
-(UIColor*)captionColor;
- (TTStyle*)segmentBar ;
-(TTStyle*)bookSelfStyle;
-(TTStyle*)infoViewStyle;
- (TTStyle*)segment:(UIControlState)state ;
- (TTStyle*)stripBarStyle;
- (TTStyle*)segment:(UIControlState)state corner:(short)corner ;
- (TTStyle*)segmentLeft:(UIControlState)state;
- (TTStyle*)segmentRight:(UIControlState)state;

- (TTStyle*)segmentCenter:(UIControlState)state;
- (TTStyle*)tabGridTabImage:(UIControlState)state;
- (UIColor*)tabBarTintColor ;

- (TTStyle*)tabBar;
-(TTStyle*)expressTab:(UIControlState)state;
-(TTStyle*)historyTab:(UIControlState)state ;
-(TTStyle*)scanFromCameraTab:(UIControlState)state ;
-(TTStyle*)favoriteTab:(UIControlState)state;
-(TTStyle*)moreTab:(UIControlState)state ;
- (TTStyle*)tab:(UIControlState)state iconStr:(NSString*)iconStr;
- (TTStyle*)navigatorBarStyle;
- (TTStyle*)navigatorBarStyleTwo;
-(TTStyle*) navigatorBarStyleThree;
-(TTStyle*) toggleIconStyle:(UIControlState)state;
-(UIFont*) moduleTitleFont;
- (TTStyle*)moduleTitleStyle;
- (TTStyle*)priceLabelStyle;
-(TTStyle*) finishButtonStyle:(UIControlState)state ;
-(TTStyle*) cancelButtonStyle:(UIControlState)state ;
-(TTStyle*) editButtonStyle:(UIControlState)state;
-(TTStyle*) backButtonStyle:(UIControlState)state;
-(TTStyle*)toolbarButton:(UIControlState)state withImgURL:(NSString*)imageURL;
-(TTStyle*)toolbarFavoriteButton:(UIControlState)state;
-(TTStyle*)toolbarCommentButton:(UIControlState)state;
-(TTStyle*)toolbarParityButton:(UIControlState)state;
-(TTStyle*)toolbarAuthorButton:(UIControlState)state;
- (TTStyle*)linkButton:(UIControlState)state;
- (TTStyle*)favoriteButtonStyle:(UIControlState)state;
-(TTStyle*)sliderSegmentLeftStyle;
-(UIImage*)sliderSegmentLeftImage;
-(TTStyle*)sliderSegmentRightStyle;
-(UIImage*)sliderSegmentRightImage;
-(TTStyle*)sliderSegmentThumbStyle;
-(UIImage*)sliderSegmentThumbImage;
-(TTStyle*) bookSummaryTitleStyle;
-(TTStyle*) bookSummaryAuthorStyle;
-(TTStyle*) bookSummaryTimelineStyle;
-(TTStyle*) bookSummaryRateStyle;
-(TTStyle*) testStyle;
-(TTStyle*)infoBackground;
-(TTStyle*)backBtnCloseStyle:(UIControlState)state ;
-(TTStyle*)popupViewStyle;
-(TTStyle*)commentViewStyle;
-(TTStyle*) authorLabelStyle;
- (TTStyle*)stripTab:(UIControlState)state position:(int)position;
- (TTStyle*)stripTabLeft:(UIControlState)state ;
- (TTStyle*)stripTabCenter:(UIControlState)state ;
- (TTStyle*)stripTabRight:(UIControlState)state ;
-(TTStyle*) favoriteTableCellStyle ;
- (TTStyle*)bindLinkStyle:(UIControlState)state;
- (TTStyle*)feedbackLinkStyle:(UIControlState)state ;
-(UIImage*)defalutAvatar;
- (TTStyle*)authorAvatarStyle:(UIControlState)state;
-(TTStyle*)booknameStyle;
-(TTStyle*)bookItemStyle ;
-(TTStyle*) commentDismissBtnStyle:(UIControlState)state;
-(TTStyle*) bookThumbStyle:(UIControlState)state;
-(TTStyle*) bookViewThumbStyle:(UIControlState)state;
-(UIImage*)defalutBookCover;
-(TTStyle*) progressHUDStyle ;
-(TTStyle*)composeViewStyle ;
-(TTStyle*) closeButtonStyle:(UIControlState)state ;
-(TTStyle*)submitButtonStyle:(UIControlState)state ;
-(TTStyle*)sharebookTitleStyle ;

@end
