#import "RmApp.h"


@implementation RmApp
- (instancetype)initWithDate:(NSDate*)dat name:(NSString*)nam {
	
	
	self = [super init];
	if (self) {
		self.date = dat;
		self.name = nam;
	}
	
	return self;
}
@end