//
//  Trip.h
//  BlackTrack_iOS
//
//  Created by Jonathan Chen on 9/15/12.
//  Copyright (c) 2012 Jonathan Chen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Trip : NSObject

@property (strong, nonatomic) NSNumber *tripId;
@property (strong, nonatomic) NSNumber *userId;
@property (strong, nonatomic) NSString *start;
@property (strong, nonatomic) NSString *finish;

-(Trip *)initWithId:(NSNumber *)tripId fbId:(NSNumber *)fId startDate:(NSString *)date;

@end
