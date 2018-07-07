//
//  ComposeViewController.m
//  twitter
//
//  Created by Gustavo Coutinho on 7/3/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "ComposeViewController.h"
#import "APIManager.h"
#import <UIImageView+AFNetworking.h>
#import "User.h"

@interface ComposeViewController () <UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITextView *tweetTextView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *tweetCloseButton;
@property (weak, nonatomic) IBOutlet UILabel *charsLabel;

@property (weak, nonatomic) IBOutlet UILabel *labelPlaceholder;
@property (weak, nonatomic) IBOutlet UIImageView *authorImageView;
@property (weak, nonatomic) IBOutlet UILabel *characterCount;

- (IBAction)tweetCloseButtonAction:(UIBarButtonItem *)sender;

- (IBAction)tweetComposeButton:(UIBarButtonItem *)sender;


@end

@implementation ComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tweetTextView.delegate = self;
    self.characterCount.alpha = 0;
    self.charsLabel.alpha = 0;

    
    [self.authorImageView setImageWithURL:self.user.profileImage];
    
    self.authorImageView.layer.cornerRadius = self.authorImageView.frame.size.height/2;



}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)textViewDidBeginEditing:(UITextView *)textView
{
    self.characterCount.alpha = 1;
    self.labelPlaceholder.alpha = 0;
    self.charsLabel.alpha = 1;

}
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

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    // TODO: Check the proposed new text character count
    // Allow or disallow the new text
    
    // Set the max character limit
    int characterLimit = 280;
    
    // Construct what the new text would be if we allowed the user's latest edit
    NSString *newText = [self.tweetTextView.text stringByReplacingCharactersInRange:range withString:text];
    
    // Update Character Count Label
    
    
    NSUInteger length;
    NSInteger display;
    length = [_tweetTextView.text length];
    
    display = characterLimit - length;
    
    self.characterCount.text = [NSString stringWithFormat:@"%u", display];
    
    // The new text should be allowed? True/False
    return newText.length < characterLimit;
    
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
