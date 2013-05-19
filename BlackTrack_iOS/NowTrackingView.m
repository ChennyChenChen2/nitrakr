//
//  NowTrackingView.m
//  BlackTrack_iOS
//
//  Created by Jonathan Chen on 9/15/12.
//  Copyright (c) 2012 Jonathan Chen. All rights reserved.
//

#import "NowTrackingView.h"
#import "HomeViewController.h"

@interface NowTrackingView ()

@end

@implementation NowTrackingView

@synthesize mapView, locationManager, trip, timeElapsed, dataHandler, facebookId;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    self.navigationController.navigationBarHidden = NO;
    self.dataHandler = [GlobalDataHandler sharedInstance];
    self.facebookId = self.dataHandler.facebookId;
    [self.navigationItem initWithTitle:@"Now tracking..."];
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    [self.locationManager setDistanceFilter:40];    //kCLDistanceFilterNone];
    [self.locationManager setDesiredAccuracy:kCLLocationAccuracyBestForNavigation];
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(self.locationManager.location.coordinate, 0.5*METERS_PER_MILE, 0.5*METERS_PER_MILE);
    MKCoordinateRegion adjustedRegion = [self.mapView regionThatFits:viewRegion];
    [self.mapView setCenterCoordinate:self.locationManager.location.coordinate];
    [self.mapView setRegion:adjustedRegion animated:YES];
    [self.locationManager startUpdatingLocation];
    
    /* Initialize the trip with a trip ID, facebook ID, and starting time */
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //NSString *dateFormat = [NSDateFormatter dateFormatFromTemplate:@"yyyy-MM-dd kk:mm:ss" options:0 locale:[NSLocale currentLocale]];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    [dateFormatter setLocale:[NSLocale currentLocale]];
    
    NSString *currentDate = [[dateFormatter stringFromDate:[NSDate date]] stringByReplacingOccurrencesOfString:@"/" withString:@"-"];

    self.trip = [[Trip alloc] initWithId:[NSNumber numberWithInteger:1] fbId:self.facebookId startDate:currentDate];
    
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:21600 target:self selector:@selector(concludeTrackButtonPressed:) userInfo:nil repeats:YES];
}

#pragma mark CLLocationManagerDelegate methods

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    
    //Keep map centered on user location
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(self.locationManager.location.coordinate, 0.5*METERS_PER_MILE, 0.5*METERS_PER_MILE);
    MKCoordinateRegion adjustedRegion = [self.mapView regionThatFits:viewRegion];
    [self.mapView setRegion:adjustedRegion animated:YES];
    
    /* Initialize the trip with a trip ID, facebook ID, and starting time */
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    [dateFormatter setLocale:[NSLocale currentLocale]];
    
    NSString *currentDate = [[dateFormatter stringFromDate:[NSDate date]] stringByReplacingOccurrencesOfString:@"/" withString:@"-"];
    
    self.btPoint = [[BTPoint alloc] initWithId:self.facebookId
                                      latitude:[NSNumber numberWithDouble:self.locationManager.location.coordinate.latitude]
                                     longitude:[NSNumber numberWithDouble:self.locationManager.location.coordinate.longitude]
                                     timeStamp:currentDate];
    
//    RKObjectManager *pointManager = [[RKObjectManager alloc] initWithBaseURL:[NSURL URLWithString:@"http://blcktrckr.herokuapp.com/services/rest"]];
//    
//    [pointManager.router routeClass:[BTPoint class]
//                                        toResourcePath:@"/point"
//                                             forMethod:RKRequestMethodPOST];
    
    RKObjectMapping *pointMapping = [RKObjectMapping mappingForClass:[BTPoint class]];
    [pointMapping mapKeyPath:@"userId" toAttribute:@"userId"];
    [pointMapping mapKeyPath:@"lat" toAttribute:@"lat"];
    [pointMapping mapKeyPath:@"lon" toAttribute:@"lon"];
    [pointMapping mapKeyPath:@"timeStamp" toAttribute:@"timeStamp"];
        
    [[RKObjectManager sharedManager] postObject:self.btPoint usingBlock:^(RKObjectLoader *loader) {
        NSLog(@"In post object block");
        loader.resourcePath = @"/point";
        loader.serializationMIMEType = RKMIMETypeJSON;
        loader.delegate = self;
        loader.method = RKRequestMethodPOST;
        loader.objectMapping = pointMapping;
        loader.serializationMapping = pointMapping;
    }];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    NSLog(@"Location manager failed with error %@", [error localizedDescription]);
}

-(void)abortTrack {
    [self.locationManager stopUpdatingLocation];
}

- (void)viewDidUnload
{
    [self.locationManager stopUpdatingLocation];
    self.locationManager = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

-(IBAction)concludeTrackButtonPressed:(id)sender {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    [dateFormatter setLocale:[NSLocale currentLocale]];
    NSString *currentDate = [[dateFormatter stringFromDate:[NSDate date]] stringByReplacingOccurrencesOfString:@"/" withString:@"-"];
    self.trip.finish = currentDate;
    
    RKObjectMapping *tripMapping = [RKObjectMapping mappingForClass:[Trip class]];
    [tripMapping mapKeyPath:@"tripId" toAttribute:@"tripId"];
    [tripMapping mapKeyPath:@"userId" toAttribute:@"userId"];
    [tripMapping mapKeyPath:@"start" toAttribute:@"start"];
    [tripMapping mapKeyPath:@"finish" toAttribute:@"finish"];
    
     [[RKObjectManager sharedManager] postObject:self.trip usingBlock:^(RKObjectLoader *loader) {
        NSLog(@"In post object block");
        loader.resourcePath = @"/trip";
        loader.serializationMIMEType = RKMIMETypeJSON;
        loader.delegate = self;
        loader.method = RKRequestMethodPOST;
        loader.objectMapping = tripMapping;
        loader.serializationMapping = tripMapping;
    }];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Congratulations" message:@"on a night well spent." delegate:nil cancelButtonTitle:@"Thanks man" otherButtonTitles:nil];
    [alert show];
    HomeViewController *viewController = [self.navigationController.viewControllers objectAtIndex:1];
    [self.navigationController popToViewController:viewController animated:YES];
    
    

    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark delegate methods for RestKit

// Print error message
- (void)objectLoader:(RKObjectLoader *)objectLoader didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError: %@, code=%d", [error localizedDescription], [error code]);
}

// Load mapped objects into an array, and prints the number of objects received
- (void)objectLoader:(RKObjectLoader *)objectLoader didLoadObjects:(NSMutableArray *)objects
{
    NSLog(@"didLoadObjects: objects[%d]", [objects count]);
}

// Prints statement if unexpected response is received from JSON post
- (void)objectLoaderDidLoadUnexpectedResponse:(RKObjectLoader *)objectLoader
{
    NSLog(@"objectLoaderDidLoadUnexpectedResponse");
    return;
}

@end