//
//  AppDelegate.h
//  BlackTrack_iOS
//
//  Created by Jonathan Chen on 9/14/12.
//  Copyright (c) 2012 Jonathan Chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>
#import <RestKit/RestKit.h>
#import "GlobalDataHandler.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
extern NSString *const FBSessionStateChangedNotification;
@property (strong, nonatomic) GlobalDataHandler *dataHandler;

-(BOOL)openSessionWithAllowLoginUI:(BOOL)allowLoginUI;
-(void)closeSession;

@end
