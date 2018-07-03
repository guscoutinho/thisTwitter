//
//  ComposeViewController.m
//  twitter
//
//  Created by Gustavo Coutinho on 7/3/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "ComposeViewController.h"
#import "Tweet.h"
#import "APIManager.h"

@interface ComposeViewController ()

@property (weak, nonatomic) IBOutlet UITextView *tweetTextView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *tweetCloseButton;

- (IBAction)tweetCloseButtonAction:(UIBarButtonItem *)sender;

- (IBAction)tweetComposeButton:(UIBarButtonItem *)sender;


@end

@implementation ComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

//- (UIBarButtonItem *)tweetCloseButton {
//    [self dismissViewControllerAnimated:true completion:nil];
//}

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

- (IBAction)tweetCloseButtonAction:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}

- (IBAction)tweetComposeButton:(UIBarButtonItem *)sender {
    
    [[APIManager shared] postStatusWithText:self.tweetTextView.text completion:^(Tweet *tweet, NSError *error) {
        if (tweet) {
            [self.delegate didTweet:tweet];
            NSLog(@"Compose Tweet Success!");
            [self dismissViewControllerAnimated:true completion:nil];
        }
        else {
            NSLog(@"Error composing Tweet: %@", error.localizedDescription);
        }
        
    }];
     
}

@end
