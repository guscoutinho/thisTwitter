//
//  TweetCellTableViewCell.m
//  twitter
//
//  Created by Gustavo Coutinho on 7/2/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "TweetCellTableViewCell.h"
#import "User.h"
#import "Tweet.h"
#import "APIManager.h"


@implementation TweetCellTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void) setTweet:(Tweet *)tweet{
    _tweet = tweet;

    self.tweetUser.text = tweet.user.name;
    self.tweetText.text = tweet.text;
    self.tweetScreenName.text = [NSString stringWithFormat:@"@%@", tweet.user.screenName];
    self.tweetDate.text = tweet.createdAtString;
    self.tweetReplyCount.text = [NSString stringWithFormat:@"%d", tweet.favoriteCount];
    self.tweetFavoriteCount.text = [NSString stringWithFormat:@"%d", tweet.favoriteCount];
    self.tweetRetweetCount.text = [NSString stringWithFormat:@"%d", tweet.retweetCount];
    
    [self.tweetProfilePicture setImageWithURL:tweet.user.profileImage];
    [self.tweetUser sizeToFit];

    

}

- (void) reloadData {
    
    self.tweetRetweetCount.text = [NSString stringWithFormat:@"%d", self.tweet.retweetCount];
    self.tweetFavoriteCount.text = [NSString stringWithFormat:@"%d", self.tweet.favoriteCount];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


//-(IBAction) toggleUIButtonImage:(id)sender{


- (IBAction)didTapRetweet:(id)sender {
    
    if (self.tweet.retweeted == YES) {
        self.tweet.retweeted = NO;
        self.tweet.retweetCount -= 1;
        [_retweetButton setImage:[UIImage imageNamed:@"retweet-icon"] forState:UIControlStateNormal];

        
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
        [_retweetButton setImage:[UIImage imageNamed:@"retweet-icon-green"] forState:UIControlStateNormal];

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

- (IBAction)didTapFavorite:(id)sender {
    
    if (self.tweet.favorited == YES) {
        self.tweet.favorited = NO;
        self.tweet.favoriteCount -= 1;
        [_favoriteButton setImage:[UIImage imageNamed:@"favor-icon"] forState:UIControlStateNormal];

        
        [[APIManager shared] unfavorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                NSLog(@"Error unfavoriting tweet: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully unfavorited the following Tweet: %@", tweet.text);
            }
        }];
    
    [self reloadData];
    }
    else {
        self.tweet.favorited = YES;
        self.tweet.favoriteCount += 1;
        [_favoriteButton setImage:[UIImage imageNamed:@"favor-icon-red"] forState:UIControlStateNormal];

        
        [[APIManager shared] favorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                NSLog(@"Error favoriting tweet: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully favorited the following Tweet: %@", tweet.text);
            }
        }];
    }
    
    [self reloadData];
}

@end
