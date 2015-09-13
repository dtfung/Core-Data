//
//  qcdDemoCollectionViewController.m
//  navctrl
//
//  Created by Donald Fung on 6/19/15.
//  Copyright (c) 2015 Donald Fung. All rights reserved.
//

#import "qcdDemoCollectionViewController.h"
#import "NavReachability.h"

@interface qcdDemoCollectionViewController ()


@end

@implementation qcdDemoCollectionViewController

-(instancetype)init{
    UICollectionViewFlowLayout *layout =[[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake(106.0, 106.0);
    layout.minimumInteritemSpacing = .5;
    layout.minimumLineSpacing = 21.5;
    (self = [super initWithCollectionViewLayout:layout]);
    return self;
}

-(void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Companies";
    [self.collectionView registerClass:[CompanyCell class ]forCellWithReuseIdentifier:@"company"];
    self.collectionView.backgroundColor = [UIColor whiteColor];
}

-(NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.companies.count;
}


-(void)viewWillAppear:(BOOL)animated {
    
    // check for internet connection
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkNetworkStatus:) name:kReachabilityChangedNotification object:nil];
    
    internetReachable = [NavReachability reachabilityForInternetConnection];
    [internetReachable startNotifier];
    
    // check if a pathway to a random host exists
    hostReachable = [NavReachability reachabilityWithHostName:@"www.apple.com"];
    [hostReachable startNotifier];
    
    
    // now patiently wait for the notification
    //call the sendHTTPGet method
    self.dao = [DAO sharedCenter];
    self.companies = self.dao.listCompanies;
    [self sendHTTPGet];
}

-(void) viewWillDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void) checkNetworkStatus:(NSNotification *)notice
{
    // called after network status changes
    NetworkStatus internetStatus = [internetReachable currentReachabilityStatus];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Connection error" message:@"we couldn't connect, bitch ass" delegate:self cancelButtonTitle:@"GOT YOU" otherButtonTitles:nil];
    
    switch (internetStatus)
    {
        case NotReachable:
        {
            NSLog(@"The internet is down.");
            self.internetActive = NO;
            [alert show];
            
            break;
        }
        case ReachableViaWiFi:
        {
            NSLog(@"The internet is working via WIFI.");
            self.internetActive = YES;
            
            break;
        }
        case ReachableViaWWAN:
        {
            NSLog(@"The internet is working via WWAN.");
            self.internetActive = YES;
            
            break;
        }
    }
    
    NetworkStatus hostStatus = [hostReachable currentReachabilityStatus];
    switch (hostStatus)
    {
        case NotReachable:
        {
            NSLog(@"A gateway to the host server is down.");
            self.hostActive = NO;
            
            break;
        }
        case ReachableViaWiFi:
        {
            NSLog(@"A gateway to the host server is working via WIFI.");
            self.hostActive = YES;
            
            break;
        }
        case ReachableViaWWAN:
        {
            NSLog(@"A gateway to the host server is working via WWAN.");
            self.hostActive = YES;
            
            break;
        }
    }
}
-(void) sendHTTPGet
{
    
    for (int i = 0; i < self.companies.count; i++) {
        Company *companies = self.companies[i];

    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: self delegateQueue: [NSOperationQueue mainQueue]];
    NSURL * url = [[NSURL alloc]initWithString:[NSString stringWithFormat:@"http://finance.yahoo.com/d/quotes.csv?s=%@&f=l1", companies.stockPrice]];
    
    NSURLSessionDataTask * dataTask = [defaultSession dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
    if(error == nil)
          {
           //Put data in a string
           self.stockPrice  = [[NSString alloc] initWithData: data encoding: NSUTF8StringEncoding];
           //Put the stock prices in the string into an array
            NSArray *stockPrices = [self.stockPrice componentsSeparatedByString:@"\n"];
            companies.actualStockPrice = [stockPrices objectAtIndex:0];
              
           //reload the table view
           [self.collectionView reloadData];
                                                            
            }else {
            NSLog(@"%@",error.localizedDescription);
            }
            }];
    
    [dataTask resume];
     
}

}



-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CompanyCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"company" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor lightGrayColor];
   Company* currentCompany = [self.companies objectAtIndex:[indexPath row]];
    
    //cell.UIview .text = currentCompany.name;
    
    cell.companyImage.image = [UIImage imageNamed:currentCompany.imageName];
    cell.companyName.text = currentCompany.name;
    cell.stockPrice.text = currentCompany.actualStockPrice;
    //NSLog(@"%@",currentCompany.actualStockPrice);
//    self.companyCell.companyView = [UIImage imageNamed:currentCompany.imageName];
  //  ell.imageView.image = [UIImage imageNamed:currentCompany.imageName];
   // cell.detailTextLabel.text = [self.companyList[indexPath.row] stockPrice];

    return cell;
}

-(void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

    self.childCollectionView = [[ChildCollectionViewController alloc]init];
    Company  *currentCompany = [self.companies objectAtIndex:
                               [indexPath row]];
//    NSMutableArray *arrayOfProducts = currentCompany.products;
    self.childCollectionView.products = currentCompany.products;
    
    [self.navigationController pushViewController:self.childCollectionView animated:YES];
}
@end
