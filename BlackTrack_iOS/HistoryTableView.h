//
//  HistoryTableView.h
//  BlackTrack_iOS
//
//  Created by Jonathan Chen on 9/15/12.
//  Copyright (c) 2012 Jonathan Chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <RestKit/RestKit.h>
#import "Trip.h"
#import "GlobalDataHandler.h"
#import "BTPoint.h"

@interface HistoryTableView : UITableViewController <RKObjectLoaderDelegate>

@property (strong, nonatomic) NSMutableArray *pointsArray;
@property (strong, nonatomic) NSArray *tripsArray;
@property (strong, nonatomic) NSNumber *facebookId;
@property (weak, nonatomic) GlobalDataHandler *dataHandler;

@end