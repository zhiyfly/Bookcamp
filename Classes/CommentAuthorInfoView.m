//
//  CommentAuthorInfoView.m
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

#import "CommentAuthorInfoView.h"

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


static const NSInteger  signatureLineCount       = 2;
static const int DefaultAuthorThumbWidth   = BKAuthorThumbWidth;
static const int  DefaultAuthorThumbHeight  = BKAuthorThumbHeight;


@implementation CommentAuthorInfoView
@synthesize nameLabel = _nameLabel, signatureLabel = _signatureLabel,avatar = _avatar; 



///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)dealloc {
	TT_RELEASE_SAFELY(_item);
	TT_RELEASE_SAFELY(_nameLabel);
	TT_RELEASE_SAFELY(_signatureLabel);
	TT_RELEASE_SAFELY(_avatar);

    [super dealloc];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        // Initialization code
		self.signatureLabel.font = [UIFont systemFontOfSize:11];
		self.signatureLabel.textColor = TTSTYLEVAR(tableSubTextColor);
		self.signatureLabel.highlightedTextColor = TTSTYLEVAR(highlightedTextColor);
		self.signatureLabel.textAlignment = UITextAlignmentLeft;
		self.signatureLabel.contentMode = UIViewContentModeTop;
		self.signatureLabel.lineBreakMode = UILineBreakModeTailTruncation;
		self.signatureLabel.numberOfLines = signatureLineCount;
		self.signatureLabel.contentMode = UIViewContentModeLeft;
		self.signatureLabel.backgroundColor = [UIColor clearColor];
	
		self.nameLabel.backgroundColor = [UIColor clearColor];
		self.nameLabel.font = [UIFont systemFontOfSize:20];
    }
    return self;
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
		CommentAuthorInfoItem* item = object;
		if (item.name.length) {
			self.nameLabel.text = item.name;
		}
		if (item.signature.length) {
			self.signatureLabel.text = item.signature;
		}
		if (item.avatarURL) {
			
			[self.avatar setStylesWithSelector:@"authorAvatarStyle:"];
			self.avatar.thumbURL = item.avatarURL;
		}

	}
}


///////////////////////////////////////////////////////////////////////////////////////////////////
-(UILabel*) signatureLabel{
	if (!_signatureLabel) {
		_signatureLabel = [[UILabel alloc] init];
		[self addSubview:_signatureLabel];
	}
	return _signatureLabel;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
-(UILabel*) nameLabel{
	if (!_nameLabel) {
		_nameLabel = [[UILabel alloc] init];
		[self addSubview:_nameLabel];
	}
	return _nameLabel;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
-(TTThumbView*) avatar{
	if (!_avatar) {
		_avatar = [[TTThumbView alloc] init];
		
		[self addSubview:_avatar];
	}
	return _avatar;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
-(void)layoutSubviews{
	[super layoutSubviews];
	
	CGFloat left = 0;
	if (_avatar) {
		_avatar.frame = CGRectMake(36, kTableCellMargin,
									   DefaultAuthorThumbWidth, DefaultAuthorThumbHeight);
		left += 36 + DefaultAuthorThumbWidth + kTableCellMargin;
	} else {
		left = 36;
	}
	
	CGFloat width = self.width - left;
	CGFloat top = kTableCellMargin;
	
	if (_nameLabel.text.length) {
		_nameLabel.frame = CGRectMake(left, top, width-kTableCellSmallMargin, _nameLabel.font.ttLineHeight);
		top += _nameLabel.height;
	} else {
		_nameLabel.frame = CGRectZero;
	}
	if (_signatureLabel.text.length) {
		_signatureLabel.frame = CGRectMake(left, top, width-kTableCellSmallMargin, _signatureLabel.font.ttLineHeight);
		top += _signatureLabel.height;
	} else {
		_signatureLabel.frame = CGRectZero;
	}
	

	
}



@end
