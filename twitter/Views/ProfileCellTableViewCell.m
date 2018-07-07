//
//  ProfileCellTableViewCell.m
//  twitter
//
//  Created by Gustavo Coutinho on 7/6/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "ProfileCellTableViewCell.h"

@implementation ProfileCellTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void) setTweet:(Tweet *)tweet {
    _tweet = tweet;
    
    self.profileCellUser.text = tweet.user.name;
    self.profileCellText.text = tweet.text;
    self.profileCellDate.text = tweet.createdAtString;
    self.profileCellScreenName.text = [NSString stringWithFormat:@"@%@", tweet.user.screenName];
    self.profileCellReplyCount.text = [NSString stringWithFormat:@"%d", tweet.favoriteCount];
    self.profileCellFavoriteCount.text = [NSString stringWithFormat:@"%d", tweet.favoriteCount];
    self.profileCellRetweetCount.text = [NSString stringWithFormat:@"%d", tweet.retweetCount];
    
    [self.profileCellProfilePicture setImageWithURL: self.tweet.user.profileImage];
    
    self.profileCellProfilePicture.layer.cornerRadius = self.profileCellProfilePicture.frame.size.height/2;
    
    if (self.tweet.retweeted == YES) {
        [self.profileCellRetweetButton setImage:[UIImage imageNamed:@"retweet-icon-green"] forState:UIControlStateNormal];
    }
    else {
        [self.profileCellRetweetButton setImage:[UIImage imageNamed:@"retweet-icon"] forState:UIControlStateNormal];
    }
    
    if (self.tweet.favorited == YES) {
        [self.profileCellfavoriteButton setImage:[UIImage imageNamed:@"favor-icon-red"] forState:UIControlStateNormal];
    }
    else {
        [self.profileCellfavoriteButton setImage:[UIImage imageNamed:@"favor-icon"] forState:UIControlStateNormal];
    }
    
    
}
- (void) reloadData {
    
    self.profileCellRetweetCount.text = [NSString stringWithFormat:@"%d", self.tweet.retweetCount];
    self.profileCellFavoriteCount.text = [NSString stringWithFormat:@"%d", self.tweet.favoriteCount];
    
}

- (IBAction)didTapRetweet:(id)sender {
    
    if (self.tweet.retweeted == YES) {
        self.tweet.retweeted = NO;
        self.tweet.retweetCount -= 1;
        [self.profileCellRetweetButton setImage:[UIImage imageNamed:@"retweet-icon"] forState:UIControlStateNormal];
        
        [self reloadData];
        
        
        [[APIManager shared] unretweet:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                NSLog(@"Error unretweeting tweet: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully unretweeted the following Tweet: %@", tweet.text);
            }
        }];
        
        [self reloadData];
    }
    else {
        self.tweet.retweeted = YES;
        self.tweet.retweetCount += 1;
        [self.profileCellRetweetButton setImage:[UIImage imageNamed:@"retweet-icon-green"] forState:UIControlStateNormal];
        [self reloadData];
        
        [[APIManager shared] retweet:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                NSLog(@"Error retweeting tweet: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully retweed the following Tweet: %@", tweet.text);
            }
        }];
    }
    
    [self reloadData];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
