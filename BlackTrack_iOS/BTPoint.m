//
//  BTPoint.m
//  BlackTrack_iOS
//
//  Created by Jonathan Chen on 9/15/12.
//  Copyright (c) 2012 Jonathan Chen. All rights reserved.
//

#import "BTPoint.h"

@implementation BTPoint

@synthesize userId, lat, lon, timeStamp;

-(BTPoint *)initWithId:(NSNumber *)usrId latitude:(NSNumber *)ltude longitude:(NSNumber *)lontude timeStamp:(NSString *)tmstmp {
    self = [super init];
    if (self) {
        self.userId = usrId;
        self.lat = ltude;
        self.lon = lontude;
        self.timeStamp = tmstmp;
    }
    return self;
}

@end
