//
//  TwitterTableViewDataSource.m
//  TwitterTableView
//
//  Created by Caleb Hicks on 11/4/14.
//  Copyright (c) 2014 Caleb Hicks. All rights reserved.
//

#import "TwitterTableViewDataSource.h"
#import "TwitterAccountCell.h"
#import <Accounts/Accounts.h>

@interface TwitterTableViewDataSource ()

@property (strong, nonatomic) UITableView *tableView;

@end

@implementation TwitterTableViewDataSource

- (void)registerTableView:(UITableView *)tableView {
    self.tableView = tableView;
    [tableView registerClass:[TwitterAccountCell class] forCellReuseIdentifier:@"twitterCell"];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TwitterAccountCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"twitterCell"];
    
    if (self.twitterAccounts && [self.twitterAccounts count] > 0) {
        ACAccount *twitterAccount = [self.twitterAccounts objectAtIndex:indexPath.row];
        cell.textLabel.text = twitterAccount.username;
    } else {
        cell.textLabel.text = @"No Twitter accounts found";
    }
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (self.twitterAccounts && [self.twitterAccounts count] > 0) {
        return self.twitterAccounts.count;
    } else {
        return 1;
    }
}

@end
