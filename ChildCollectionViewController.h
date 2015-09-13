//
//  ChildCollectionViewController.h
//  navctrl
//
//  Created by Donald Fung on 6/22/15.
//  Copyright (c) 2015 Donald Fung. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DAO.h"
#import "ProductCell.h"
#import "Company.h"
//#import "qcdDemoCollectionViewController.h"
#import "website.h"
#import "qcdDemoAppDelegate.h"

@class qcdDemoCollectionViewController;

@interface ChildCollectionViewController : UICollectionViewController <UIGestureRecognizerDelegate>

@property (nonatomic, retain) DAO *dao;
@property (nonatomic, retain) NSMutableArray *products;
@property (nonatomic, retain) ProductCell *productCell;
@property (nonatomic, retain) qcdDemoCollectionViewController *qcdDemoCollectionViewController;
@property (nonatomic, retain) website *websiteVC;

@property (nonatomic, retain) qcdDemoAppDelegate *appDelegate;

@end
