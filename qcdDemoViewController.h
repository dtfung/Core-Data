//
//  qcdDemoViewController.h
//  NavCtrl
//
//  Created by Donald Fung on 10/22/13.
//  Copyright (c) 2013 Donald Fung. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Company.h"
#import "DAO.h"

@class ChildViewController;

@interface qcdDemoViewController : UITableViewController<NSURLSessionDelegate>

@property (nonatomic, retain) NSMutableArray *companyList;
@property (nonatomic, retain) IBOutlet  ChildViewController * childVC;
@property (nonatomic) BOOL button;
@property (nonatomic, retain) NSString *stockPrice;


@property (nonatomic, retain)  DAO *companyDao;
@end
