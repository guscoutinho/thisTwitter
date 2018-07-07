//
//  ProfileViewController.m
//  twitter
//
//  Created by Gustavo Coutinho on 7/5/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "ProfileViewController.h"
#import "Tweet.h"
#import <UIImageView+AFNetworking.h>
#import "ProfileCellTableViewCell.h"
#import "APIManager.h"

@interface ProfileViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *profileHeaderView;
@property (weak, nonatomic) IBOutlet UIImageView *profilePictureView;
@property (weak, nonatomic) IBOutlet UILabel *profileUser;
@property (weak, nonatomic) IBOutlet UILabel *profileScreenname;
@property (weak, nonatomic) IBOutlet UILabel *profileDescription;
@property (weak, nonatomic) IBOutlet UILabel *profileFollowersCount;
@property (weak, nonatomic) IBOutlet UILabel *profileFollowingCount;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *tweets;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    self.tableView.rowHeight = 120;
    
    [self fetchProfileTweets];
    
    self.profileUser.text = self.user.name;
    self.profileScreenname.text = [NSString stringWithFormat:@"@%@", self.user.screenName];
    self.profileDescription.text = self.user.profileDescription;
    
    self.profileFollowersCount.text = [NSString stringWithFormat:@"%d", self.user.profileFollowers];
    self.profileFollowingCount.text = [NSString stringWithFormat:@"%d", self.user.profileFollowing];
    
    self.profilePictureView.layer.cornerRadius = self.profilePictureView.frame.size.height/2;

    [self.profilePictureView setImageWithURL:self.user.profileImage];
    [self.profileHeaderView setImageWithURL:self.user.profileBanner];
    


}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)fetchProfileTweets {
    // Get timeline
    [[APIManager shared] getProfileTweets:^(NSArray *tweets, NSError *error) {
        if (tweets) {
            
            // Creeting the array of the tweets
            self.tweets = (NSMutableArray*)tweets;
            [self.tableView reloadData];
            
            
            NSLog(@"Successfully loaded profile tweets: AYYYYYYYYYYYYYYYYYYY");
            for (Tweet *tweet in tweets) {
                NSURL *text = tweet.text;
                NSLog(@"%@", text);
                
            }
        } else {
            NSLog(@"😫😫😫 Error getting profile tweets: %@", error.localizedDescription);
        }
    }];
}








/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    ProfileCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ProfileCellTableViewCell"];
    
    Tweet *tweet = self.tweets[indexPath.row];
    
    cell.tweet = tweet;
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tweets.count;
}


@end
