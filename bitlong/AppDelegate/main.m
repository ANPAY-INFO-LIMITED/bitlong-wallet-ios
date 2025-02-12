//
//  main.m
//  bitlong
//

//

#import <UIKit/UIKit.h>
#import "BLAppDelegate.h"
#include <sys/types.h>
#include <sys/sysctl.h>

int main(int argc, char * argv[]) {
    NSString * appDelegateClassName;
    @autoreleasepool {
        // Setup code that might create autoreleased objects goes here.
        appDelegateClassName = NSStringFromClass([BLAppDelegate class]);
    }
    
    return UIApplicationMain(argc, argv, nil, appDelegateClassName);
}
