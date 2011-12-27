//
//  BaseTableViewController.m
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
