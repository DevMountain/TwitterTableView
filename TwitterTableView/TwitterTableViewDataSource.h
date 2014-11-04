//
//  TwitterTableViewDataSource.h
//  TwitterTableView
//
//  Created by Caleb Hicks on 11/4/14.
//  Copyright (c) 2014 Caleb Hicks. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface TwitterTableViewDataSource : NSObject <UITableViewDataSource>

@property (strong, nonatomic) NSArray *twitterAccounts;

- (void)registerTableView:(UITableView *)tableView;

@end
