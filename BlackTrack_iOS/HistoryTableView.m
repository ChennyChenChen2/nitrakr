//
//  HistoryTableView.m
//  BlackTrack_iOS
//
//  Created by Jonathan Chen on 9/15/12.
//  Copyright (c) 2012 Jonathan Chen. All rights reserved.
//

#import "HistoryTableView.h"
#import "HistoryTableCell.h"

@interface HistoryTableView ()

@end

@implementation HistoryTableView

@synthesize pointsArray, tripsArray, facebookId, dataHandler;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
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
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    
    //setup for the REST call
    RKObjectManager *objectManager = [RKObjectManager sharedManager];
    objectManager.client.baseURL = [RKURL URLWithString:@"http://blcktrckr.herokuapp.com/services/rest"];
    [objectManager.requestCache invalidateAll];
    
    //setup the object mapping (what object to create based on the JSON results)
    RKObjectMapping *tripMapping = [RKObjectMapping mappingForClass:[Trip class]];
    [tripMapping mapKeyPath:@"tripId" toAttribute:@"tripId"];
    [tripMapping mapKeyPath:@"userId" toAttribute:@"userId"];
    [tripMapping mapKeyPath:@"start" toAttribute:@"start"];
    [tripMapping mapKeyPath:@"finish" toAttribute:@"finish"];
    
    NSString *resourcePath = [NSString stringWithFormat:@"/gettrips/%d", [self.facebookId intValue]];
    
    // Register our mappings with the provider using a resource path pattern
    [objectManager.mappingProvider setMapping:tripMapping forKeyPath:@""];
    
    //execute the REST call asynchronously
    [objectManager loadObjectsAtResourcePath:resourcePath delegate:self];
//    
//    [objectManager.requestCache invalidateAll];
//    
//    RKObjectMapping *pointMapping = [RKObjectMapping mappingForClass:[BTPoint class]];
//    [pointMapping mapKeyPath:@"userId" toAttribute:@"userId"];
//    [pointMapping mapKeyPath:@"lat" toAttribute:@"lat"];
//    [pointMapping mapKeyPath:@"lon" toAttribute:@"lon"];
//    [pointMapping mapKeyPath:@"timeStamp" toAttribute:@"timeStamp"];
//    
//    for (int i = [self.tripsArray count]; i > 0; i--) {
//        NSString *resourcePath2 = [NSString stringWithFormat:@"/getpoints/%d/%i", [self.facebookId intValue], i];
//        //execute the REST call asynchronously
//        [objectManager loadObjectsAtResourcePath:resourcePath2 delegate:self];
//        [objectManager.requestCache invalidateAll];
//    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    if (self.tripsArray)
        return [self.tripsArray count];
    else
        return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"HistoryCell";
    HistoryTableCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[HistoryTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"attendeeCell"];
    }
    Trip *trip = [self.tripsArray objectAtIndex:[indexPath row]];
    cell.startLabel.text = [NSString stringWithFormat:@"%@", trip.start];
    cell.endLabel.text = [NSString stringWithFormat:@"%@", trip.finish];
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
    self.tripsArray = [[NSMutableArray alloc] initWithArray:objects];
    [self.tableView reloadData];
}

// Prints statement if unexpected response is received from JSON post
- (void)objectLoaderDidLoadUnexpectedResponse:(RKObjectLoader *)objectLoader
{
    NSLog(@"objectLoaderDidLoadUnexpectedResponse");
    return;
}


@end
