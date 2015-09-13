//
//  website.m
//  NavCtrl
//
//  Created by Donald Fung on 6/3/15.
//  Copyright (c) 2015 Donald Fung. All rights reserved.
//

#import "website.h"
#import "ChildViewController.h"
#import "qcdDemoViewController.h"
#import "DAO.h"
#import "Product.h"

@interface website ()

@end

@implementation website



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    WKWebViewConfiguration *theConfiguration = [[WKWebViewConfiguration alloc]init];
    
    self.WKwebView = [[WKWebView alloc] initWithFrame:self.view.frame configuration:theConfiguration];
    self.view = self.WKwebView;
    NSURL *url = [NSURL URLWithString:self.webPages];
    NSURLRequest* request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:30];
    [self.WKwebView loadRequest:request];
    
    //released these objects to address memory leaks.
    [theConfiguration release];
  
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [self.WKwebView release];
    [super dealloc];
}
@end
