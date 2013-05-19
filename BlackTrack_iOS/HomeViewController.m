//
//  HomeViewController.m
//  BlackTrack_iOS
//
//  Created by Jonathan Chen on 9/14/12.
//  Copyright (c) 2012 Jonathan Chen. All rights reserved.
//

#import "HomeViewController.h"
#import "AppDelegate.h"

@interface HomeViewController ()

@end

@implementation HomeViewController
@synthesize logOutButton;

@synthesize startTrackingButton, seeHistoryButton;

- (void)viewDidLoad
{
#warning Want to have bar button not appear on home screen!!!!
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(sessionStateChanged:)
     name:FBSessionStateChangedNotification
     object:nil];
    self.navigationItem.hidesBackButton = YES;
    // Check the session for a cached token to show the proper authenticated
    // UI. However, since this is not user intitiated, do not show the login UX.
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    [appDelegate openSessionWithAllowLoginUI:NO];
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    self.navigationController.navigationBarHidden = NO;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (void)request:(FBRequest*)request didLoad:(id)result {
    NSString *uId = [result objectForKey:@"id"];
}

-(IBAction)logOutButtonPressed:(id)sender {
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    
    // If the user is authenticated, log out when the button is clicked.
    // If the user is not authenticated, log in when the button is clicked.
    if (FBSession.activeSession.isOpen) {
        [appDelegate closeSession];
    } else {
        // The user has initiated a login, so call the openSession method
        // and show the login UX if necessary.
        [appDelegate openSessionWithAllowLoginUI:YES];
    }
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)sessionStateChanged:(NSNotification*)notification {
    if (FBSession.activeSession.isOpen) {
        [self.logOutButton setTitle:@"Logout" forState:UIControlStateNormal];
    } else {
        [self.logOutButton setTitle:@"Login" forState:UIControlStateNormal];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"StartTrackingSegue"]) {
        self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Abort track"
                                                                         style:UIBarButtonItemStyleBordered
                                                                         target:nil
                                                                         action:nil];
    }
    else if ([segue.identifier isEqualToString:@"HistorySegue"]) {
        self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back"
                                                                                 style:UIBarButtonItemStyleBordered
                                                                                target:nil
                                                                                action:nil];
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}



@end
