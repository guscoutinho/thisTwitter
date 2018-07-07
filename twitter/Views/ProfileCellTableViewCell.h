//
//  ProfileCellTableViewCell.h
//  twitter
//
//  Created by Gustavo Coutinho on 7/6/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"
#import <UIImageView+AFNetworking.h>
#import "APIManager.h"

@interface ProfileCellTableViewCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UILabel *profileCellUser;
@property (weak, nonatomic) IBOutlet UILabel *profileCellText;
@property (weak, nonatomic) IBOutlet UILabel *profileCellScreenName;
@property (weak, nonatomic) IBOutlet UILabel *profileCellDate;
@property (weak, nonatomic) IBOutlet UIImageView *profileCellProfilePicture;
@property (weak, nonatomic) IBOutlet UILabel *profileCellReplyCount;
@property (weak, nonatomic) IBOutlet UILabel *profileCellRetweetCount;
@property (weak, nonatomic) IBOutlet UILabel *profileCellFavoriteCount;


@property (weak, nonatomic) IBOutlet UIButton *profileCellReplyButton;
@property (weak, nonatomic) IBOutlet UIButton *profileCellRetweetButton;
@property (weak, nonatomic) IBOutlet UIButton *profileCellfavoriteButton;


- (IBAction)didTapRetweet:(id)sender;
- (IBAction)didTapFavorite:(id)sender;


@property (strong, nonatomic) Tweet *tweet;
@property (strong, nonatomic) User *user;


@end
