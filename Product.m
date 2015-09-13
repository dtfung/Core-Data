//
//  Product.m
//  navctrl
//
//  Created by Donald Fung on 6/29/15.
//  Copyright (c) 2015 Donald Fung. All rights reserved.
//

#import "Product.h"

@implementation Product

-(instancetype)initWithName: (NSString*)name andImageName:(NSString *)imageName andWebsite:(NSString *)website{
    self = [super init];
    if (self) {
        self.name = name;
        self.imageName = imageName;
        self.website = website;
    }
    return self;
}

@end
