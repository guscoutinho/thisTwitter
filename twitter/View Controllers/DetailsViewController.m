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
    
    
//    self.titleLabel.text = self.movie[@"title"];
//    self.descriptionLabel.text = self.movie[@"overview"];
//    self.releaseLabel.text = self.movie[@"release_date"];
    

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)detailsRetweetAction:(id)sender {
    
}
- (IBAction)detailsFavoriteAction:(id)sender {
}
@end
