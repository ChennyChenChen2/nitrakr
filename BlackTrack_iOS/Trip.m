//
//  Trip.m
//  BlackTrack_iOS
//
//  Created by Jonathan Chen on 9/15/12.
//  Copyright (c) 2012 Jonathan Chen. All rights reserved.
//

#import "Trip.h"

@implementation Trip

-(Trip *)initWithId:(NSNumber *)tripId fbId:(NSNumber *)fId startDate:(NSString *)date {
    self = [super init];
    if (self) {
        self.tripId = tripId;
        self.userId = fId;
        self.start = date;
    }
return self;
}

@end
