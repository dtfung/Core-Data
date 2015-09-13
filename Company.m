//
//  Company.m
//  navctrl
//
//  Created by Donald Fung on 6/29/15.
//  Copyright (c) 2015 Donald Fung. All rights reserved.
//

#import "Company.h"

@implementation Company

-(instancetype)initWithName:(NSString*)name andImageName:(NSString*)imageName andStockPrice:(NSString*)stockPrice {
    self = [super init];
    if (self) {
        self.name = name;
        self.imageName = imageName;
        self.stockPrice = stockPrice;
    }
    return self;
}
@end
