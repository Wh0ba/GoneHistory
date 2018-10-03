#import "AppDelegate.h"
#import "ViewController.h"

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(UIApplication *)application {
	_window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
	UINavigationController *rootNavCon = [[UINavigationController alloc] initWithRootViewController:[[ViewController alloc] init]];
	_window.rootViewController = rootNavCon;
	[_window makeKeyAndVisible];
}


@end
