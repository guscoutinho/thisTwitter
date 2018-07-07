//
//  TimelineViewController.m
//  twitter
//
//  Created by emersonmalca on 5/28/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "TimelineViewController.h"
#import "APIManager.h"
#import "TweetCellTableViewCell.h"
#import "Tweet.h"
#import <UIImageView+AFNetworking.h>
#import "ComposeViewController.h"
#import "AppDelegate.h"
#import "LoginViewController.h"
#import "DetailsViewController.h"
#import "DateTools.h"
#import "ProfileViewController.h"

@interface TimelineViewController () <UITableViewDataSource, UITableViewDelegate, ComposeViewControllerDelegate>

- (IBAction)logoutAction:(id)sender;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *tweets;

@property (nonatomic, strong) UIRefreshControl *refreshControl;

@property (weak, nonatomic) IBOutlet UIButton *replyButton;
@property (weak, nonatomic) IBOutlet UIButton *retweetButton;
@property (weak, nonatomic) IBOutlet UIButton *favoriteButton;


@property (weak, nonatomic) IBOutlet UIBarButtonItem *logoutButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *composeTweetButton;
@end

@implementation TimelineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[APIManager shared] goToProfile:^(User *user, NSError *error) {
        if (user) {
            self.user = user;
        }
        else {
            self.user = nil;
        }
    }];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    [self fetchTweets];
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    
    // Programagtic view of dragging and dropping in code
    [self.refreshControl addTarget:self action:@selector(fetchTweets) forControlEvents:UIControlEventValueChanged];
    
    // Nests views into subviews
    [self.tableView insertSubview:self.refreshControl atIndex:0];
}

- (void)fetchTweets {
    // Get timeline
    [[APIManager shared] getHomeTimelineWithCompletion:^(NSArray *tweets, NSError *error) {
        if (tweets) {
            
            // Creeting the array of the tweets
            self.tweets = (NSMutableArray*)tweets;
            [self.tableView reloadData];
            
            
        }
        [self.refreshControl endRefreshing];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tweets.count;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {

    TweetCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TweetCellTableViewCell"];
    
    Tweet *tweet = self.tweets[indexPath.row];
    
    cell.tweet = tweet;
    
    return cell;
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Deselect the row which was tapped
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(void)didTweet:(Tweet *)tweet {
    // Goes to the top instead of bottom as addObject
    [self.tweets insertObject:tweet atIndex:0];
    [self.tableView reloadData];
}


- (IBAction)logoutAction:(id)sender {
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LoginViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    appDelegate.window.rootViewController = loginViewController;
    
    [[APIManager shared] logout];
}



 #pragma mark - Navigation

//  In a storyboard-based application, you will often want to do a little preparation before navigation


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier  isEqual: @"composeTweet"]) {
        
        UINavigationController *navigationController = [segue destinationViewController];
        ComposeViewController *composeController = (ComposeViewController*)navigationController.topViewController;
        composeController.delegate = self;
        
        composeController.user = self.user;
        
    }
    
    if ([segue.identifier  isEqual: @"detailsController"]) {
        
        UITableView *tappedCell = sender;
        
        NSIndexPath *indexPath = [self.tableView indexPathForCell:tappedCell];
        Tweet *tweet = self.tweets[indexPath.row];
        
        DetailsViewController *detailsViewController = [segue destinationViewController];
        
        detailsViewController.tweet = tweet;

    }
    

}

@end
