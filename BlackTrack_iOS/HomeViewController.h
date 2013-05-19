//
//  HomeViewController.h
//  BlackTrack_iOS
//
//  Created by Jonathan Chen on 9/14/12.
//  Copyright (c) 2012 Jonathan Chen. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface HomeViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *startTrackingButton;
@property (weak, nonatomic) IBOutlet UIButton *seeHistoryButton;
@property (weak, nonatomic) IBOutlet UIButton *logOutButton;

-(IBAction)logOutButtonPressed:(id)sender;

@end
