//
//  MovieCell.h
//  tomatoes
//
//  Created by Anand Joshi on 1/13/14.
//  Copyright (c) 2014 Yahoo! Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MovieCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UIImageView *posterImageView;
@property (nonatomic, weak) IBOutlet UILabel *movieTitle;
@property (nonatomic, weak) IBOutlet UILabel *movieSummary;
@property (nonatomic, weak) IBOutlet UILabel *movieCast;

@end
