//
//  HistoryModule.m
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

#import "HistoryModule.h"
#import "EditableSectionedDateSource.h"
#import "HistoryDataSource.h"
#import "Book.h"

@implementation HistoryModule
@synthesize tableView = _tableView;
@synthesize recordTableViewDataSource = _recordTableViewDataSource;
@synthesize editBtn = _editBtn;
@synthesize tableViewVarHeightDelegate = _tableViewVarHeightDelegate;
@synthesize managedObjectContext = _managedObjectContext;
@synthesize fetchedItems = _fetchedItems;
@synthesize sections =_sections;
@synthesize dataSource   = _dataSource;

-(void)dealloc{
	TT_RELEASE_SAFELY(_tableView);
	TT_RELEASE_SAFELY(_recordTableViewDataSource);
	TT_RELEASE_SAFELY(_editBtn);
	TT_RELEASE_SAFELY(_tableViewVarHeightDelegate);
	TT_RELEASE_SAFELY (_managedObjectContext);
	TT_RELEASE_SAFELY (_fetchedItems);
	TT_RELEASE_SAFELY (_sections);
	TT_RELEASE_SAFELY(_dataSource);
	[super dealloc];
}

-(id)initWithConfig:(NSDictionary*)config{
	if (self = [super initWithConfig:config]) {
		[self.view.navigatorBar setStyle:TTSTYLE(navigatorBarStyleThree)];
		self.view.navigatorBarHidden = NO;
		
//		TTLabel *titleLabel = [[[TTLabel alloc] init] autorelease];
//		titleLabel.text = BCLocalizedString(@"HistoryModuleTitle", @"HistoryModuleTitle");
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

-(HistoryDataSource*)recordTableViewDataSource{
	if (!_recordTableViewDataSource) {

		_recordTableViewDataSource = [[HistoryDataSource alloc]initWithItems:self.fetchedItems sections:self.sections];
	}
	return _recordTableViewDataSource;
}

- (NSManagedObjectContext *) managedObjectContext {
    if (!_managedObjectContext ) {
		ModelLocator *locator = [ModelLocator sharedInstance];
		NSPersistentStoreCoordinator *coordinator = [locator persistentStoreCoordinator];
		if (coordinator != nil) {
			_managedObjectContext = [[NSManagedObjectContext alloc] init];
			[_managedObjectContext setPersistentStoreCoordinator: coordinator];
		}
    }
	
    return _managedObjectContext;
}

-(NSMutableArray*)fetchedItems{
	if (!_fetchedItems) {
		_fetchedItems = [[NSMutableArray alloc] initWithCapacity:1];
	}
	return _fetchedItems;
}

-(NSMutableArray*)sections{
	if (!_sections) {
		_sections = [[NSMutableArray alloc] initWithCapacity:1];
	}
	return _sections;
}


-(void)createModel{
	self.dataSource = [[[HistoryDataSource alloc] init] autorelease];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
-(void)didLoadModel:(BOOL)firstTime{
	[super didLoadModel:firstTime];
	[self.dataSource tableViewDidLoadModel:self.tableView];	
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

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setDataSource:(id<TTTableViewDataSource>)dataSource {
	if (dataSource != _dataSource) {
		[_dataSource release];
		_dataSource = [dataSource retain];
		self.tableView.dataSource = nil;
		self.model = dataSource.model;
	}
}

- (void)model:(id<TTModel>)model didInsertObject:(id)object atIndexPath:(NSIndexPath*)indexPath{
	NSArray *insertIndexPaths = [NSArray arrayWithObjects:
								 indexPath,
								 nil];

	[self.tableView reloadData];

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
		_tableView.delegate = self.tableViewVarHeightDelegate;
		_tableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
				_tableView.backgroundColor = RGBCOLOR(241,241,241);
	}
	return _tableView;
}



@end
