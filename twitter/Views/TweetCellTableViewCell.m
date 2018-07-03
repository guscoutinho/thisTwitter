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


@implementation TweetCellTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void) setTweet:(Tweet *)tweet{
    _tweet = tweet;

    self.tweetUser.text = tweet.user.name;
    self.tweetText.text = tweet.text;
    self.tweetScreenName.text = tweet.user.screenName;
    self.tweetDate.text = tweet.createdAtString;
    self.tweetReplyCount.text = [NSString stringWithFormat:@"%d", tweet.favoriteCount];
    self.tweetFavoriteCount.text = [NSString stringWithFormat:@"%d", tweet.favoriteCount];
    self.tweetRetweetCount.text = [NSString stringWithFormat:@"%d", tweet.retweetCount];
    
    

    
    [self.tweetProfilePicture setImageWithURL:tweet.user.profileImage];

    // [self.tweetProfilePicture sizeToFit];
//        [self.tweetUser sizeToFit];
//        [self.tweetText sizeToFit];
    

}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
