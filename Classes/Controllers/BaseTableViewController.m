//
//  BaseTableViewController.m
//  bookcamp
//
//  Created by lin waiwai on 2/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "BaseTableViewController.h"


@implementation BaseTableViewController
@synthesize backBtn = _backBtn;
@synthesize navigatorBar = _navigatorBar;
///////////////////////////////////////////////////////////////////////////////////////////////////
-(void)viewWillAppear:(BOOL)animated{
	self.navigationController.navigationBarHidden = YES;
    [super viewWillAppear:animated];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (UITableView*)tableView {
	UITableView *table = [super tableView];
	table.frame = CGRectMake(0,   BKNavigatorBarHeight, 	 
							 RootModuleWidth, 
							 CGRectGetHeight(self.view.frame)-BKNavigatorBarHeight);
	return table;
}

-(CGRect)rectForNavigator{
	return BKNavigatorBarFrame();
}


-(NavigatorBar*)navigatorBar{
	if (!_navigatorBar){
		_navigatorBar = [[NavigatorBar alloc] initWithFrame:[self rectForNavigator]];
		//_navigatorBar.backgroundColor = [UIColor redColor];
		[_navigatorBar setStyle:TTSTYLE(navigatorBarStyle)];
		//[self setNavigatorBarHidden:NO];
		[self.view addSubview:_navigatorBar];
		
	}
	return _navigatorBar;
}

-(void)back:(TTButton*)btn{
	[self.navigationController popViewControllerAnimated:YES];
}

-(TTButton*)backBtn{
	if (!_backBtn) {
		_backBtn = [[TTButton alloc] init];
		[_backBtn setStylesWithSelector:@"backButtonStyle:"];
		[_backBtn setTitle:BCLocalizedString(@"back", @"back") forState:UIControlStateNormal];
		[_backBtn sizeToFit];
		[_backBtn addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
	}
	return _backBtn;
}

@end
