//
//  GlobalDataHandler.m
//  BlackTrack_iOS
//
//  Created by Jonathan Chen on 9/15/12.
//  Copyright (c) 2012 Jonathan Chen. All rights reserved.
//

#import "GlobalDataHandler.h"
#import "Trip.h"

@implementation GlobalDataHandler

@synthesize facebookId, objectManager, user;

static GlobalDataHandler *_sharedDataHandler = nil;   //instance variable

// Use to define the singleton instance of the GlobalDataHandler
+ (GlobalDataHandler *)sharedInstance
{
    @synchronized([GlobalDataHandler class])
    {
        if (!_sharedDataHandler) {
            NSAssert(_sharedDataHandler == nil,@"Attempted to allocate a second instance of the GlobalDataHandler singleton.");
            _sharedDataHandler = [[super alloc] init];
        }
        return _sharedDataHandler;
    }
    return nil;
}

-(void)getFbId {
    
    //self.facebookId = [self.user.id  ;
    
    //Create object manager to handle JSON requests... invalidate cache so that the call will be made multiple times if necessary (will only refer to previous data if this is not done)
    self.objectManager = [RKObjectManager objectManagerWithBaseURLString:@"https://graph.facebook.com/me"];
    
    [self.objectManager.requestCache invalidateAll];
    
    //RKObjectMapping *idMapping = [RKObjectMapping mappingForClass:[Trip  ];
    
}

@end
