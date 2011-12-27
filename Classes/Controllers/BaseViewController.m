    //
//  BaseViewController.m
//  bookcamp
//
//  Created by lin waiwai on 1/29/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "BaseViewController.h"


@implementation BaseViewController
@synthesize navigatorBar = _navigatorBar;
@synthesize backBtn = _backBtn;
///////////////////////////////////////////////////////////////////////////////////////////////////
-(void)viewWillAppear:(BOOL)animated{
	self.navigationController.navigationBarHidden = YES;
    [super viewWillAppear:animated];
}



 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
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


/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/
-(CGRect)rectForNavigator{
	return BKNavigatorBarFrame();
}


-(NavigatorBar*)navigatorBar{
	if (!_navigatorBar){
		_navigatorBar = [[NavigatorBar alloc] initWithFrame:[self rectForNavigator]];
	[_navigatorBar setStyle:TTSTYLE(navigatorBarStyle)];
		[self.view addSubview:_navigatorBar];
		
	}
	return _navigatorBar;
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	
    [super viewDidLoad];
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
