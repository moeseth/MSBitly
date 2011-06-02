//
//  MSBitlyDemoAppDelegate.h
//  MSBitlyDemo
//
//  Created by Sieg on 6/3/11.
//  Copyright 2011 Seth Corp. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MSBitlyDemoViewController;

@interface MSBitlyDemoAppDelegate : NSObject <UIApplicationDelegate> {

}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet MSBitlyDemoViewController *viewController;

@end
