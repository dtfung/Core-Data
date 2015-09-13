//
//  ProductCell.m
//  navctrl
//
//  Created by Donald Fung on 6/22/15.
//  Copyright (c) 2015 Donald Fung. All rights reserved.
//

#import "ProductCell.h"

@implementation ProductCell

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.productImage = [[UIImageView alloc]init];
        [self.contentView addSubview:self.productImage];
         self.productName = [[UILabel alloc]init];
        [self.contentView addSubview:self.productName];
    }
    return self;
}

-(void)layoutSubviews {
    [super layoutSubviews];
    self.productImage.frame = self.contentView.bounds;
    CGRect frameLbl = self.contentView.bounds;
    frameLbl.origin.y =frameLbl.size.height - 20;
    frameLbl.size.height = 30;
    [self.productName setBackgroundColor:[UIColor whiteColor]];
    self.productName.frame = frameLbl;
}
@end
