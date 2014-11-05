//
//  ViewController.m
//  TwitterTableView
//
//  Created by Caleb Hicks on 11/4/14.
//  Copyright (c) 2014 Caleb Hicks. All rights reserved.
//

#import "ViewController.h"
#import "TwitterTableViewDataSource.h"
#import <Accounts/Accounts.h>
#import <Social/Social.h>

@interface ViewController () <UITableViewDelegate>

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) TwitterTableViewDataSource *dataSource;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    self.dataSource = [TwitterTableViewDataSource new];
    self.tableView.dataSource = self.dataSource;
    self.tableView.delegate = self;
    [self.dataSource registerTableView:self.tableView];
    
    ACAccountStore *accountStore = [ACAccountStore new];
    ACAccountType *accountType = [accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
    
    [accountStore requestAccessToAccountsWithType:accountType options:nil completion:^(BOOL granted, NSError *error) {
        if (granted) {
            self.dataSource.twitterAccounts = [accountStore accountsWithAccountType:accountType];
            [self.tableView reloadData];
        } else {
            NSLog(@"Error. Permission not granted.");
        }
    }];
    
    [self.view addSubview:self.tableView];
}

- (void)openTweetSheetWithText:(NSString *)text {
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
    {
        SLComposeViewController *tweetSheet = [SLComposeViewController
                                               composeViewControllerForServiceType:SLServiceTypeTwitter];
        [tweetSheet setInitialText:text];
        [self presentViewController:tweetSheet animated:YES completion:nil];
    } else {
        NSLog(@"Error. Twitter Service is unavailable.");
    }
}

- (IBAction)composeTweet:(id)sender {
    [self openTweetSheetWithText:@"This tweet brought to you by a tapped bar button!"];
}

#pragma mark - UITableView Delegate Methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self openTweetSheetWithText:@"This tweet brought to you by a selected table view cell!"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
