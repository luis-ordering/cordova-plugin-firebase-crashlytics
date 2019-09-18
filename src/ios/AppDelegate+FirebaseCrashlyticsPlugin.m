#import "AppDelegate+FirebaseCrashlyticsPlugin.h"
#import "FirebaseCrashlyticsPlugin.h"
// @import Fabric;
@import Firebase;
#import <objc/runtime.h>

@implementation AppDelegate (FirebaseCrashlyticsPlugin)

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Method original, swizzled;

        original = class_getInstanceMethod(self, @selector(application:didFinishLaunchingWithOptions:));
        swizzled = class_getInstanceMethod(self, @selector(firebaseCrashlyticsPlugin:customDidFinishLaunchingWithOptions:));
        method_exchangeImplementations(original, swizzled);
    });
}

- (BOOL)firebaseCrashlyticsPlugin:(UIApplication *)application customDidFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self firebaseCrashlyticsPlugin:application customDidFinishLaunchingWithOptions:launchOptions];
    [FIRApp configure];
    return YES;
}

@end
