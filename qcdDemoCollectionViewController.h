//
//  qcdDemoCollectionViewController.h
//  navctrl
//
//  Created by Donald Fung on 6/19/15.
//  Copyright (c) 2015 Donald Fung. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DAO.h"
#import "CompanyCell.h"
#import "Company.h"
#import "ChildCollectionViewController.h"


@class NavReachability;

@interface qcdDemoCollectionViewController : UICollectionViewController <NSURLSessionDelegate> {
    NavReachability* internetReachable;
    NavReachability* hostReachable;
}
@property (nonatomic, retain) DAO *dao;
@property (nonatomic, retain) NSMutableArray *companies;
@property (nonatomic, retain) CompanyCell *companyCell;
@property (nonatomic, retain) ChildCollectionViewController *childCollectionView;
@property (nonatomic, retain) NSString *stockPrice;


@property (nonatomic, assign) BOOL internetActive;
@property (nonatomic, assign) BOOL hostActive;

-(void) checkNetworkStatus:(NSNotification *)notice;




@end
