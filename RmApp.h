@interface RmApp: NSObject

@property (nonatomic, strong) NSDate *date;
@property (nonatomic, strong) NSString* name;

- (instancetype)initWithDate:(NSDate*)dat name:(NSString*)name;

@end