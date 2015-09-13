//
//  Product.h
//  navctrl
//
//  Created by Donald Fung on 6/26/15.
//  Copyright (c) 2015 Donald Fung. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface ManagedProduct : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * imageName;
@property (nonatomic, retain) NSString * website;
@property (nonatomic, retain) NSString * companyID;

@end
