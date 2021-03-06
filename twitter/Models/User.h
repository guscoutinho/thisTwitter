//
//  User.h
//  twitter
//
//  Created by Gustavo Coutinho on 7/2/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

// TODO: Add properties

// TODO: Create initializer
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *screenName; // two minimum properties for displaying a user
@property (strong, nonatomic) NSURL *profileImage;
@property (strong, nonatomic)NSURL *profileBanner;
@property (strong, nonatomic) NSString *profileDescription;
@property (strong, nonatomic) NSString *profileFollowers;
@property (strong, nonatomic) NSString *profileFollowing;




- (instancetype)initWithDictionary: (NSDictionary *)dictionary;


@end
