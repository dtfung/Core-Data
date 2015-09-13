//
//  DAO.h
//  navctrl
//
//  Created by Donald Fung on 6/8/15.
//  Copyright (c) 2015 Donald Fung. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ManagedCompany.h"
#import "ManagedProduct.h"
#import "qcdDemoAppDelegate.h"
#import "Company.h"
#import "Product.h"

@interface DAO : NSObject


//this is an array property that will store all the data for each company
@property (nonatomic, retain) NSMutableArray *listCompanies;
@property (nonatomic, retain) NSMutableArray *listProducts;

@property (nonatomic, retain) NSMutableArray *copiedListOfCompanies;

@property (nonatomic, retain) qcdDemoAppDelegate *appDelegate;
@property (nonatomic, retain) ManagedCompany *managedCompany;

+(DAO*)sharedCenter;
-(void)loadAllCompanies;
- (void)getCompanyInformation;
-(void)deleteProducts:(NSString*)productName;
@end
