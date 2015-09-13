//
//  CompanyCell.m
//  navctrl
//
//  Created by Donald Fung on 6/19/15.
//  Copyright (c) 2015 Donald Fung. All rights reserved.
//

#import "CompanyCell.h"

@implementation CompanyCell

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.companyImage = [[UIImageView alloc]init];
        [self.contentView addSubview:self.companyImage];
        self.companyName = [[UILabel alloc]init];
        [self.contentView addSubview:self.companyName];
        self.stockPrice = [[UILabel alloc]init];
        [self.contentView addSubview:self.stockPrice];
    }
    return self;
}

-(void)layoutSubviews {
    [super layoutSubviews];
    
    self.companyImage.frame = self.contentView.bounds;
    
    CGRect frameLbl = self.contentView.bounds;
    frameLbl.origin.y =frameLbl.size.height - 50;
    frameLbl.size.height = 30;
    [self.companyName setBackgroundColor:[UIColor whiteColor]];
    self.companyName.frame = frameLbl;
    
    self.stockPrice.frame = self.contentView.bounds;

    
}
@end
