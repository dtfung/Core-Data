//
//  Product.h
//  navctrl
//
//  Created by Donald Fung on 6/29/15.
//  Copyright (c) 2015 Donald Fung. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Product : NSObject

@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *imageName;
@property (nonatomic, retain) NSString *website;
@property (nonatomic, retain) NSString *companyID;

-(instancetype)initWithName:(NSString*)name andImageName:(NSString *)imageName andWebsite:(NSString *)website;

@end
