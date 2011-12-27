//
//  FavoriteModule.m
//  bookcamp
//
//  Created by waiwai on 12/19/10.
//  Copyright 2010 __iwaiwai__. All rights reserved.
//

#import "FavoriteModule.h"
#import "FavoriteDataSource.h"
#import "Book.h"
@implementation FavoriteModule

@synthesize tableView = _tableView;
@synthesize recordTableViewDataSource = _recordTableViewDataSource;
@synthesize editBtn = _editBtn;
@synthesize tableViewVarHeightDelegate = _tableViewVarHeightDelegate;
@synthesize dataSource          = _dataSource;

-(void)dealloc{
	TT_RELEASE_SAFELY(_tableView);
	TT_RELEASE_SAFELY(_editBtn);
	TT_RELEASE_SAFELY(_tableViewVarHeightDelegate);
	TT_RELEASE_SAFELY(_dataSource);
	[super dealloc];
}

-(id)initWithConfig:(NSDictionary*)config{
	if (self = [super initWithConfig:config]) {
		
		[self.view.navigatorBar setStyle:TTSTYLE(navigatorBarStyleThree)];
		self.view.navigatorBarHidden = NO;
//		
//		TTLabel *titleLabel = [[[TTLabel alloc] init] autorelease];
//		titleLabel.text = BCLocalizedString(@"FavoriteModuleTitle", @"FavoriteModuleTitle");
//		titleLabel.backgroundColor = [UIColor clearColor];
//		titleLabel.style =  TTSTYLE(moduleTitleStyle);
//		[titleLabel sizeToFit];
//		[self.view.navigatorBar addToNavigatorView:titleLabel align:NavigationViewAlignCenter];
		
		self.editBtn.backgroundColor = [UIColor clearColor];
		[self.view.navigatorBar addToNavigatorView:self.editBtn align:NavigationViewAlignRight];
		self.view.contentView.backgroundColor = [UIColor blackColor];
		[self.view.contentView addSubview:self.tableView];

	}
	return self;
}

-(void)toggleEdit:(TTButton*)btn{
	[btn setTitle:BCLocalizedString((self.tableView.editing ? @"edit":@"done"),@"the edit toggle string") forState:UIControlStateNormal];
	[btn setStylesWithSelector:self.tableView.editing ? @"editButtonStyle:":@"finishButtonStyle:"];
	[btn sizeToFit];	
	[self.tableView setEditing:!self.tableView.editing animated:YES];
	self.tableView.editing ? [self.tableView beginUpdates]:[self.tableView endUpdates];
}


-(TTButton*)editBtn{
	if (!_editBtn) {
		_editBtn = [[TTButton alloc] init];
		[_editBtn setStylesWithSelector:@"editButtonStyle:"];
		[_editBtn setTitle:BCLocalizedString(@"edit", @"edit") forState:UIControlStateNormal];
		[_editBtn sizeToFit];
		[_editBtn addTarget:self action:@selector(toggleEdit:) forControlEvents:UIControlEventTouchUpInside];
	}
	return _editBtn;
}

-(void)createModel{
	self.dataSource = [[[FavoriteDataSource alloc] init] autorelease];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setDataSource:(id<TTTableViewDataSource>)dataSource {
	if (dataSource != _dataSource) {
		[_dataSource release];
		_dataSource = [dataSource retain];
		self.tableView.dataSource = nil;
		self.model = dataSource.model;
	}
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)showModel:(BOOL)show {
	[self hideMenu:YES];
	if (show) {
		self.tableView.dataSource = _dataSource;
	} else {
		self.tableView.dataSource = nil;
	}
	[self.tableView reloadData];
}


-(void)didLoadModel:(BOOL)firstTime{
	[super didLoadModel:firstTime];
	[self.dataSource tableViewDidLoadModel:self.tableView];
}

- (void)model:(id<TTModel>)model didInsertObject:(id)object atIndexPath:(NSIndexPath*)indexPath{
	NSArray *insertIndexPaths = [NSArray arrayWithObjects:
								 indexPath,
								 nil];
	[self.tableView insertRowsAtIndexPaths:insertIndexPaths withRowAnimation:UITableViewRowAnimationNone];
}

-(BCTableViewVarHeightDelegate*)tableViewVarHeightDelegate{
	if (!_tableViewVarHeightDelegate) {
		_tableViewVarHeightDelegate = [[BCTableViewVarHeightDelegate alloc] initWithController:self];
	}
	return _tableViewVarHeightDelegate;
}

-(TTTableView*)tableView{
	if (!_tableView) {
		_tableView = [[TTTableView alloc] initWithFrame:CGRectMake(0, 0,CGRectGetWidth(self.view.contentView.frame),
																   CGRectGetHeight(self.view.contentView.frame))];
		_tableView.delegate = [self tableViewVarHeightDelegate];
		_tableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
		_tableView.backgroundColor = RGBCOLOR(241,241,241);
		
	}
	return _tableView;
}



@end