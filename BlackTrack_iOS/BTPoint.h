//
//  BTPoint.h
//  BlackTrack_iOS
//
//  Created by Jonathan Chen on 9/15/12.
//  Copyright (c) 2012 Jonathan Chen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BTPoint : NSObject

@property (strong, nonatomic) NSNumber *userId;
@property (strong, nonatomic) NSNumber *lat;
@property (strong, nonatomic) NSNumber *lon;
@property (strong, nonatomic) NSString *timeStamp;

-(BTPoint *)initWithId:(NSNumber *)userId latitude:(NSNumber *)ltude longitude:(NSNumber *)lontude timeStamp:(NSString *)tmstmp;

@end
