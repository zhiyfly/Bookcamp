//
//  RootViewController.m
//  bookcamp
//
//  Created by waiwai on 12/11/10.
//  Copyright 2010 __iwaiwai__. All rights reserved.
//

#import "RootViewController.h"
#import "Three20UI/private/TTTabBarInternal.h"
#import "BKTabItem.h"

@implementation RootViewController
@synthesize tabBar=_tabBar;
@synthesize tabURLs = _tabURLs;
@synthesize modules = _modules;

#define TabURLs [NSArray arrayWithObjects:@"tt://root/#express",\
@"tt://root/#history",\
@"tt://scanFromCamera",\
@"tt://root/#favorite",\
@"tt://root/#more",\
nil]

///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {		
		self.view.backgroundColor = [UIColor whiteColor];
		kTabMargin = 0;
		
	}
	return self;
}



///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Private

-(void)selectedTab:(NSString*)tab{
	NSString *className = [moduleNameForTab([tab intValue]) stringByAppendingString:ModuleSuffix];
	Module* module  = [self.modules objectForKey:className];
	if (module) {
		[self.view bringSubviewToFront:module.view];
	}else {
		Class ModuleClass =	NSClassFromString(className);
		module = [[[ModuleClass alloc] initWithConfig:nil] autorelease];
		[self.modules setObject:module forKey:className];
		[self.view addSubview:module.view];
		[self.view bringSubviewToFront:module.view];
			
	}
	[module viewWillAppear:YES];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
-(NSMutableDictionary*)modules{
	if (!_modules) {
		_modules = [[NSMutableDictionary alloc] init];
	}
	return _modules;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setTabURLs:(NSArray*)URLStrs {
	NSMutableArray* tabbarInfo = [NSMutableArray array];	
	for (NSString* URLStr in URLStrs) {
		NSURL *URL = [NSURL URLWithString:URLStr];
		BKTabItem *tttabBarItem;
		NSString *title ;
		if ([URL fragment]) {
			title = [URL fragment];
			tttabBarItem = [[[BKTabItem alloc] initWithTitle:BCLocalizedString( [upcaseFirstLetter([URL fragment]) stringByAppendingString:@"ModuleTitle"],@"the title of module")] autorelease];
			
		}else if ([URL pathComponents]) {
			title = [URL host];
			tttabBarItem = [[[BKTabItem alloc] initWithTitle:BCLocalizedString(upcaseFirstLetter([URL host]),@"the title of viewController") ] autorelease];
		}
		tttabBarItem.style = [title stringByAppendingString:@"Tab:"];
		[tabbarInfo addObject:tttabBarItem];
	}
	self.tabBar.tabItems = [NSArray arrayWithArray:tabbarInfo];
	[self.view addSubview:self.tabBar];
}




-(BKTabBar*)tabBar{
	if (!_tabBar) {
		CGRect aBound = BKScreenBoundsWithoutBar();
		_tabBar = [[BKTabBar alloc] initWithFrame:CGRectMake(0, 
															CGRectGetHeight(aBound)-TabBarHeight,
															CGRectGetWidth(aBound), 
															TabBarHeight)];
		_tabBar.delegate = self;
	}
	return _tabBar;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark TTTabDelegate
- (void)tabBar:(TTTabBar*)tabBar tabSelected:(NSInteger)selectedIndex{
	TTOpenURL([[NSArray arrayWithObjects:@"tt://root/#0",\
				@"tt://root/#1",\
				@"tt://scanFromCamera",\
				@"tt://root/#3",\
				@"tt://root/#4",\
				nil] objectAtIndex:selectedIndex]);
}

#pragma mark -
#pragma mark View lifecycle
//
//-(void)loadView{
//	//a status bar is counted in;
//	CGRect aBound = TTScreenBounds();
//	UIView *aView = [[[UIView alloc] initWithFrame:CGRectMake(0,0, CGRectGetWidth(aBound),CGRectGetHeight(aBound))] autorelease];
//	aView.backgroundColor = [UIColor redColor];
//	self.view = aView;
//}





///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)viewDidLoad {
	[self setTabURLs:TabURLs];
	
}



///////////////////////////////////////////////////////////////////////////////////////////////////
-(void)viewWillAppear:(BOOL)animated{
	self.navigationController.navigationBarHidden = YES;
    [super viewWillAppear:animated];
	NSEnumerator *enumerator = [self.modules objectEnumerator];
	Module *value ;
	if (value = [enumerator nextObject]) {
		[value viewWillAppear:animated];
	}
	[self selectedTab:@"0"];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];


}

/*
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}
*/

// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
//	return YES;
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark -
#pragma mark Memory management
///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	NSEnumerator *enumerator = [self.modules objectEnumerator];
	Module *value ;
	if (value = [enumerator nextObject]) {
		[value didReceiveMemoryWarning];
	}
    // Relinquish ownership any cached data, images, etc that aren't in use.
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end

