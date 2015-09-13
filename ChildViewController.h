//
//  ChildViewController.h
//  NavCtrl
//
//  Created by Donald Fung on 10/22/13.
//  Copyright (c) 2013 Donald Fung. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "website.h"
#import "qcdDemoViewController.h"
#import "DAO.h"


@interface ChildViewController : UITableViewController
@property (nonatomic, retain) NSMutableArray *products;
@property (nonatomic, retain) website *websiteVC;
@property (nonatomic, retain) NSMutableArray *companyURL;
@property (nonatomic, retain) IBOutlet  qcdDemoViewController * companyVC;
@property (nonatomic) BOOL button;


@end
