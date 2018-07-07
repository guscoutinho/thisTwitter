//
//  DetailsViewController.m
//  twitter
//
//  Created by Gustavo Coutinho on 7/5/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "DetailsViewController.h"
#import "Tweet.h"
#import <UIImageView+AFNetworking.h>
#import "APIManager.h"
#import "User.h"



@interface DetailsViewController ()

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.detailsUser.text = self.tweet.user.name;    
    self.detailsScreename.text = [NSString stringWithFormat:@"@%@", self.tweet.user.screenName];
    
    
    self.detailsDate.text = self.tweet.createdAtString;
    self.detailsText.text = self.tweet.text;
    self.detailsFavoriteCount.text = [NSString stringWithFormat:@"%d", self.tweet.favoriteCount];
    self.detailsRetweetCount.text = [NSString stringWithFormat:@"%d", self.tweet.retweetCount];
    
    
    [self.detailsImageView setImageWithURL:self.tweet.user.profileImage];
    self.detailsImageView.layer.cornerRadius = self.detailsImageView.frame.size.height/2;

    
    
    if (self.tweet.retweeted == YES) {
        [self.detailsRetweetButton setImage:[UIImage imageNamed:@"retweet-icon-green"] forState:UIControlStateNormal];
    }
    else {
        [self.detailsRetweetButton setImage:[UIImage imageNamed:@"retweet-icon"] forState:UIControlStateNormal];
    }
    
    if (self.tweet.favorited == YES) {
        [self.detailsFavoriteButton setImage:[UIImage imageNamed:@"favor-icon-red"] forState:UIControlStateNormal];
    }
    else {
        [self.detailsFavoriteButton setImage:[UIImage imageNamed:@"favor-icon"] forState:UIControlStateNormal];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void) detailsReloadData {
    self.detailsRetweetCount.text = [NSString stringWithFormat:@"%d", self.tweet.retweetCount];
    self.detailsFavoriteCount.text = [NSString stringWithFormat:@"%d", self.tweet.favoriteCount];
}


- (IBAction)detailsRetweet:(id)sender {
    if (self.tweet.retweeted == YES) {
        self.tweet.retweeted = NO;
        self.tweet.retweetCount -= 1;
        [_detailsRetweetButton setImage:[UIImage imageNamed:@"retweet-icon"] forState:UIControlStateNormal];
        
        
        [[APIManager shared] unretweet:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                NSLog(@"Error unretweeting tweet: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully unretweeted the following Tweet: %@", tweet.text);
            }
        }];
        
        [self detailsReloadData];
    }
    else {
        self.tweet.retweeted = YES;
        self.tweet.retweetCount += 1;
        [_detailsRetweetButton setImage:[UIImage imageNamed:@"retweet-icon-green"] forState:UIControlStateNormal];

        [[APIManager shared] retweet:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                NSLog(@"Error retweeting tweet: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully retweed the following Tweet: %@", tweet.text);
            }
        }];
    }
    
    [self detailsReloadData];
}

- (IBAction)detailsFavorite:(id)sender {

    if (self.tweet.favorited == YES) {
        self.tweet.favorited = NO;
        self.tweet.favoriteCount -= 1;
        [_detailsFavoriteButton setImage:[UIImage imageNamed:@"favor-icon"] forState:UIControlStateNormal];

        
        [[APIManager shared] unfavorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                NSLog(@"Error unfavoriting tweet: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully unfavorited the following Tweet: %@", tweet.text);
            }
        }];
        
        [self detailsReloadData];
    }
    else {
        self.tweet.favorited = YES;
        self.tweet.favoriteCount += 1;
        [_detailsFavoriteButton setImage:[UIImage imageNamed:@"favor-icon-red"] forState:UIControlStateNormal];

        
        [[APIManager shared] favorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                NSLog(@"Error favoriting tweet: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully favorited the following Tweet: %@", tweet.text);
            }
        }];
    }
    
    [self detailsReloadData];
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */


@end
