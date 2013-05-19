//
//  NowTrackingView.h
//  BlackTrack_iOS
//
//  Created by Jonathan Chen on 9/15/12.
//  Copyright (c) 2012 Jonathan Chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "Trip.h"
#import <RestKit/RestKit.h>
#import "BTPoint.h"
#import "GlobalDataHandler.h"

#define METERS_PER_MILE 1609.344

@interface NowTrackingView : UIViewController <CLLocationManagerDelegate, RKObjectLoaderDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, atomic) CLLocationManager *locationManager;
@property (weak, nonatomic) IBOutlet UIButton *abortTrackButton;
@property (weak, nonatomic) IBOutlet UIButton *concludeTrackButton;
@property (strong, nonatomic) Trip *trip;
@property (strong, nonatomic) BTPoint *btPoint;
@property (strong, nonatomic) NSNumber *timeElapsed;
@property (weak, nonatomic) GlobalDataHandler *dataHandler;
@property (strong, nonatomic) NSNumber *facebookId;

-(IBAction)concludeTrackButtonPressed:(id)sender;

@end
