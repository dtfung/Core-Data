//
//  Company.h
//  navctrl
//
//  Created by Donald Fung on 6/29/15.
//  Copyright (c) 2015 Donald Fung. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Company : NSObject


@property (nonatomic, retain) NSString *companyID;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *imageName;
@property (nonatomic, retain) NSMutableArray *products;
@property (nonatomic, retain) NSString *stockPrice;
@property (nonatomic, retain) NSString *actualStockPrice;

-(instancetype)initWithName:(NSString*)name andImageName:(NSString*)imageName andStockPrice:(NSString*)stockPrice;
@end
