//
//  TweetCellTableViewCell.h
//  twitter
//
//  Created by Gustavo Coutinho on 7/2/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"
#import <UIImageView+AFNetworking.h>
#import "APIManager.h"


@interface TweetCellTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *tweetUser;
@property (weak, nonatomic) IBOutlet UILabel *tweetText;
@property (weak, nonatomic) IBOutlet UILabel *tweetScreenName;
@property (weak, nonatomic) IBOutlet UILabel *tweetDate;
@property (weak, nonatomic) IBOutlet UIImageView *tweetProfilePicture;
@property (weak, nonatomic) IBOutlet UILabel *tweetReplyCount;
@property (weak, nonatomic) IBOutlet UILabel *tweetRetweetCount;
@property (weak, nonatomic) IBOutlet UILabel *tweetFavoriteCount;


@property (weak, nonatomic) IBOutlet UIButton *replyButton;
@property (weak, nonatomic) IBOutlet UIButton *retweetButton;
@property (weak, nonatomic) IBOutlet UIButton *favoriteButton;


- (IBAction)didTapRetweet:(id)sender;
- (IBAction)didTapFavorite:(id)sender;


@property (strong, nonatomic) Tweet *tweet;

@end
