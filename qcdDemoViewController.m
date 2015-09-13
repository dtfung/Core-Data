//
//  qcdDemoViewController.m
//  NavCtrl
//
//  Created by Donald Fung on 10/22/13.
//  Copyright (c) 2013 Donald Fung. All rights reserved.
//

#import "qcdDemoViewController.h"
#import "ChildViewController.h"
#import "Company.h"

@interface qcdDemoViewController ()

@end

@implementation qcdDemoViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //This is letting the parent know who its child is.  Without this, the parent would know that it has a child, via the property childVC but not who it is.
    self.childVC.companyVC = self;
    
    // Uncomment the following line to preserve selection between presentations.
    self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    

    if (self.button == 0) {
        
        //Initialize this property
        self.companyDao = [[DAO alloc]init];
        
        //call the method in the DAO to retrieve all the company data
        [[DAO sharedCenter] getCompanyInformation];
        self.companyList = self.companyDao.listCompanies;
    }
}

-(void)viewWillAppear:(BOOL)animated {
    
    //call the sendHTTPGet method
     [self sendHTTPGet];
}

-(void) sendHTTPGet
{
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: self delegateQueue: [NSOperationQueue mainQueue]];
    NSURL * url = [NSURL URLWithString: @"http://finance.yahoo.com/d/quotes.csv?s=AAPL+BLUE+BBRY+GOOG&f=l1"];
    
    NSURLSessionDataTask * dataTask = [defaultSession dataTaskWithURL:url
                                                    completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if(error == nil)
        {
            //Put data in a string
            self.stockPrice  = [[NSString alloc] initWithData: data encoding: NSUTF8StringEncoding];
            //Put the stock prices in the string into an array
            NSArray *stockPrices = [self.stockPrice componentsSeparatedByString:@"\n"];
            
            for (int i = 0; i < self.companyList.count; i ++) {
                //assign the stock prices to the stock price property of the company class.
                [self.companyList[i] setStockPrice:stockPrices[i]];
            }
            //reload the table view
            [self.tableView reloadData];
            
        }else {
            NSLog(@"%@",error.localizedDescription);
        }
    }];
    
    [dataTask resume];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [self.companyList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    
    Company* currentCompany = [self.companyList objectAtIndex:
                               [indexPath row]];
    
    cell.textLabel.text = currentCompany.name;
    
    cell.imageView.image = [UIImage imageNamed:currentCompany.imageName];
    cell.detailTextLabel.text = [self.companyList[indexPath.row] stockPrice];
    
    return cell;
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        self.button = 1;
        // Delete the row from the data source
        [self.companyList removeObjectAtIndex:indexPath.row];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
}



// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}



// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}



#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //sets the title of the page equal to the name of each product
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    self.childVC.title = cell.textLabel.text;
    
    
    //When user clicks on a particular company, the data within the array needs to be read.  Declare an instance to access this info
    Company* currentCompany = [self.companyList objectAtIndex:
                               [indexPath row]];
    
    //get the product list for each company from the array above
    NSMutableArray *arrayOfProducts = currentCompany.products;
    
    //populates the view with the product list for a particular company
    self.childVC.products = arrayOfProducts;
    
    [self.navigationController pushViewController:self.childVC animated:YES];
    
    
}



@end
