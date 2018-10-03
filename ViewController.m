#import "ViewController.h"


#define CELL @"Cell"
#define DictDir @"/var/installd/Library/MobileInstallation/UninstalledApplications.plist"








@interface ViewController()

@property (nonatomic, strong) NSMutableArray<RmApp*> *iApps;
@property (nonatomic, strong) UIActivityIndicatorView *loadingSpinner;

@end



@implementation ViewController {
	NSDateFormatter *_df2;
}

@synthesize iApps, loadingSpinner;

- (void)loadView {
	[super loadView];
	self.view.backgroundColor = [UIColor whiteColor];
	
	self.title = @"Gone History";
	
	
}
- (void)viewDidLoad {
	[super viewDidLoad];
	
	
	[self setupSpinner];
	[self loadDataToArrays];
	
	
}

-(void)loadDataToArrays {
	
	
	
	dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
			//start hud and work
			[loadingSpinner startAnimating];
			[self loadDict];
			dispatch_async(dispatch_get_main_queue(), ^(void) {
				
				
				//kill hud
				[loadingSpinner stopAnimating];
				
		});
	});
	
	
	
}
- (void)setupSpinner {
	
	
	
	loadingSpinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
	loadingSpinner.hidesWhenStopped = YES; 
	
	
	
	loadingSpinner.translatesAutoresizingMaskIntoConstraints = NO;
	
	[self.view addSubview:loadingSpinner];
	
	
	@autoreleasepool{
	//Trailing    
	NSLayoutConstraint *centerX =[NSLayoutConstraint constraintWithItem:loadingSpinner attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0f constant:0.f];
	
	//Leading
	
	NSLayoutConstraint *centerY = [NSLayoutConstraint constraintWithItem:loadingSpinner attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1.0f constant:0.f];
	
	//Bottom
	NSLayoutConstraint *width =[NSLayoutConstraint constraintWithItem:loadingSpinner attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0 constant:50];
	
	//Height to be fixed for SubView same as AdHeight
	NSLayoutConstraint *height = [NSLayoutConstraint constraintWithItem:loadingSpinner attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0 constant:50];
	
	    //Add constraints to the Parent
    [self.view addConstraint:centerX];
    [self.view addConstraint:centerY];
    [loadingSpinner addConstraint:width];
	 [loadingSpinner addConstraint:height];
	}
	
}

- (void)loadDict {
	
	
	NSMutableDictionary *appsDict = [[NSMutableDictionary alloc] initWithContentsOfFile:DictDir];
	
	if (!appsDict) {
		appsDict = (NSMutableDictionary*)@{
		@"something is wrong" : [NSDate date]
		};
	}
	
	iApps = [[NSMutableArray alloc] init];
	
	
	_df2 = [[NSDateFormatter alloc] init];
	
	[_df2 setDateFormat:@"yyyy-MM"];
	
	for (NSString* key in appsDict.allKeys) {
		[iApps addObject:[[RmApp alloc] initWithDate:appsDict[key] name:key]];
	}
	appsDict = nil;
	
	
	
}


#pragma mark -
#pragma mark section and row count

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	
	return iApps.count;
	
}


#pragma mark -
#pragma mark creating cells 

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELL];
	
	
	if (!cell) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CELL];
	}
	cell.detailTextLabel.font = [UIFont systemFontOfSize:13];
	cell.detailTextLabel.textColor = [UIColor blueColor];
	//cell.textLabel.numberOfLines = 0;
	
	return cell;
}



#pragma mark -
#pragma mark Table View Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
	
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	 
	
	
}

/*
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath { 
	return 60.f;
}

*/
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath { 
	
	
	
	
	cell.textLabel.text = iApps[indexPath.row].name;
	cell.detailTextLabel.text = [_df2 stringFromDate:iApps[indexPath.row].date];;
	//cell.detailTextLabel.text = iAppsD[key];
	
	
	
}
@end
