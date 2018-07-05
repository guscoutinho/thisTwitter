//
//  DetailsViewController.h
//  twitter
//
//  Created by Gustavo Coutinho on 7/5/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TimelineViewController.h"
#import "Tweet.h"
#import "User.h"

@interface DetailsViewController : UIViewController

@property (strong, nonatomic) Tweet *tweet;

@property (weak, nonatomic) IBOutlet UIImageView *detailsImageView;
@property (weak, nonatomic) IBOutlet UILabel *detailsUser;
@property (weak, nonatomic) IBOutlet UILabel *detailsScreename;
@property (weak, nonatomic) IBOutlet UILabel *detailsText;
@property (weak, nonatomic) IBOutlet UILabel *detailsDate;
@property (weak, nonatomic) IBOutlet UILabel *detailsRetweetCount;
@property (weak, nonatomic) IBOutlet UILabel *detailsFavoriteCount;

@property (weak, nonatomic) IBOutlet UIButton *detailsMessageButton;
@property (weak, nonatomic) IBOutlet UIButton *detailsRetweetButton;
@property (weak, nonatomic) IBOutlet UIButton *detailsFavoriteButton;
- (IBAction)detailsFavoriteAction:(id)sender;
- (IBAction)detailsRetweetAction:(id)sender;

@end
