//
//  website.h
//  NavCtrl
//
//  Created by Donald Fung on 6/3/15.
//  Copyright (c) 2015 Donald Fung. All rights reserved.
//


 #import <WebKit/WebKit.h>
@interface website : UIViewController
//Changed from UIWebView to WKWebView.  So the difference comes down to performance improvements when using WKWebview over UIWebview.  So each app uses an API (UIWebview) to invoke a webview but UIWebview doesn't contain any performance optimizations.  WKWebview on the other hand contains optimizations, making its performance equivalent to Safari.  The performance falters when using UIWebView in other browsers, such as Chrome.)

@property (nonatomic, retain) NSString *webPages;
@property (nonatomic, retain) NSArray *arrayOfProducts;
@property (nonatomic, retain) WKWebView * WKwebView;

@end
