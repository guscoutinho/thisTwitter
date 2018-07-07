//
//  ComposeViewController.h
//  twitter
//
//  Created by Gustavo Coutinho on 7/3/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"
#import "User.h"

@protocol ComposeViewControllerDelegate

- (void)didTweet:(Tweet *)tweet;

@end

@interface ComposeViewController : UIViewController

@property (strong, nonatomic) Tweet *tweet;
@property (strong, nonatomic) User *user;

@property (nonatomic, weak) id<ComposeViewControllerDelegate> delegate;

@end
