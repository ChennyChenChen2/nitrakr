//
//  HistoryTableCell.m
//  BlackTrack_iOS
//
//  Created by Jonathan Chen on 9/16/12.
//  Copyright (c) 2012 Jonathan Chen. All rights reserved.
//

#import "HistoryTableCell.h"

@implementation HistoryTableCell

@synthesize startLabel, endLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
