//
//  AuthorViewController.m
//  bookcamp
//
//  Created by lin waiwai on 7/23/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AuthorViewController.h"
#import "Three20UI/UIViewAdditions.h"

@implementation AuthorViewController
@synthesize book = _book;
@synthesize wrapper = _wrapper;

-(id)initWithBook:(id)oid{
	if (self = [super initWithNibName:nil bundle:nil]) {
		TTNavigator* navigator = [TTNavigator navigator];
		TTURLMap* map = navigator.URLMap;
		self.book = [map objectForURL:[@"tt://bookObject/" stringByAppendingFormat:@"%@",oid]];
		[self.backBtn setStylesWithSelector:@"backBtnCloseStyle:"];

		[self.navigatorBar addToNavigatorView:self.backBtn align:NavigationViewAlignLeft];
	
		TTLabel *label = [[[TTLabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)] autorelease];
		label.text = BCLocalizedString(@"about author", @"about author");
		[label sizeToFit];
		[self.navigatorBar addToNavigatorView:label align:NavigationViewAlignCenter];
		
		TTLabel *author = [[[TTLabel alloc] initWithFrame:CGRectMake(0, 0, 300, 45)] autorelease];
		author.backgroundColor = [UIColor clearColor];
		if ([self.book.authors count]>0) {
			author.text = [self.book.authors objectAtIndex:0];
			
		}
		
		author.style = TTSTYLE(authorLabelStyle);
		//[author sizeToFit];
		author.frame = CGRectMake((self.view.width - author.width) / 2 , BKContentSmallMargin,author.width,  author.height);
		[self.wrapper addSubview:author];
		
		UIScrollView *scrollView = [[UIScrollView alloc]
									initWithFrame:CGRectMake(BKContentLargeMargin*2,CGRectGetMaxY(author.frame)  +BKContentLargeMargin, 
															 self.view.width - BKContentLargeMargin*4, 
															 self.wrapper.height - (CGRectGetMaxY(author.frame) + BKContentLargeMargin*2) )];
		
		NSString *authorIntro = [[self.book.authorIntro copy] autorelease];
		if (authorIntro) {

			while ( [authorIntro rangeOfString:@"\n\n"].location != NSNotFound) {
				authorIntro = [authorIntro stringByReplacingOccurrencesOfString:@"\n\n" withString:@"\n"];
			}
			
			while ([authorIntro rangeOfString:@"\n\r\n\r"].location != NSNotFound) {
				authorIntro = [authorIntro stringByReplacingOccurrencesOfString:@"\n\r\n\r" withString:@"\n\r"];
			}
			
			while ( [authorIntro rangeOfString:@"　　"].location != NSNotFound) {
				authorIntro = [authorIntro stringByReplacingOccurrencesOfString:@"　　" withString:@"　"];
			}
			while ( [authorIntro rangeOfString:@"  "].location != NSNotFound) {
				authorIntro = [authorIntro stringByReplacingOccurrencesOfString:@"  " withString:@" "];
			}
		

			authorIntro = [authorIntro stringByReplacingOccurrencesOfString:@"\n" withString:@"<br/><br/>"];
			authorIntro = [authorIntro stringByReplacingOccurrencesOfString:@"\n\r" withString:@"<br/><br/>"];
		}
		
		
		//scrollView.backgroundColor = [UIColor redColor];
		TTStyledText *styledText = [TTStyledText textFromXHTML:authorIntro?authorIntro:BCLocalizedString(@"no author intro", @"")  lineBreaks:YES URLs:NO];
		styledText.width = scrollView.width;
		styledText.font =[UIFont systemFontOfSize: 14.0];
		TTStyledTextLabel *contentLabel = [[TTStyledTextLabel alloc] initWithFrame:CGRectMake(0,0, styledText.width, styledText.height)];
		contentLabel.font = [UIFont systemFontOfSize: 14.0];
		contentLabel.text = styledText;
		contentLabel.backgroundColor = [UIColor clearColor];
		[contentLabel sizeToFit];
		
		[scrollView setContentSize:CGSizeMake(scrollView.width, styledText.height)];
		[scrollView addSubview:contentLabel];
		
		[self.wrapper addSubview:scrollView];
		
	}
	return self;
}

-(TTView*)wrapper{
	if (!_wrapper) {
		_wrapper  = [[TTView alloc] initWithFrame:
					 CGRectMake(0, BKNavigatorBarHeight,
								RootModuleWidth, 
								CGRectGetHeight(BKScreenBoundsWithoutBar()) - BKNavigatorBarHeight)];

		_wrapper.style = TTSTYLE(popupViewStyle);
		[self.view addSubview:_wrapper];
								
	}
	return _wrapper;
}





@end
