//
//  CompanyCell.h
//  navctrl
//
//  Created by Donald Fung on 6/19/15.
//  Copyright (c) 2015 Donald Fung. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CompanyCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView *companyImage;
@property (nonatomic, strong) UILabel *companyName;
@property (nonatomic, strong) UILabel *stockPrice;

@end
