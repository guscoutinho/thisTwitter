//
//  User.m
//  twitter
//
//  Created by Gustavo Coutinho on 7/2/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "User.h"

@implementation User

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        self.name = dictionary[@"name"];
        self.screenName = dictionary[@"screen_name"];
        self.profileDescription = dictionary[@"description"];
        self.profileImage = [NSURL URLWithString:dictionary[@"profile_image_url_https"]];
        self.profileBanner = [NSURL URLWithString:dictionary[@"profile_banner_url"]];
        self.profileFollowers = dictionary[@"followers_count"];
        self.profileFollowing = dictionary[@"friends_count"];
        
        
    }
    return self;
}

@end
