//
//  GlobalDataHandler.h
//  BlackTrack_iOS
//
//  Created by Jonathan Chen on 9/15/12.
//  Copyright (c) 2012 Jonathan Chen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <RestKit/RestKit.h>
#import <FacebookSDK/FacebookSDK.h>

@interface GlobalDataHandler : NSObject

@property (strong, nonatomic) NSNumber *facebookId;
@property (weak, nonatomic) RKObjectManager *objectManager;
@property (weak, nonatomic) id<FBGraphUser> user;

+ (GlobalDataHandler *)sharedInstance;
- (void)getFbId;

@end
