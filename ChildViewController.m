//
//  ChildViewController.m
//  NavCtrl
//
//  Created by Donald Fung on 10/22/13.
//  Copyright (c) 2013 Donald Fung. All rights reserved.
//

#import "ChildViewController.h"
#import "qcdDemoViewController.h"
#import "website.h"
#import "Product.h"
@interface ChildViewController ()

@end

@implementation ChildViewController

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
    
    // Uncomment the following line to preserve selection between presentations.
    self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    // Populate the view with products excluding the ones that were deleted. 
    if (self.button == 0) {
        
        /*
        if ([self.title isEqualToString:@"Apple mobile devices"]) {
            Product *iPad = [[Product alloc]initWithName:@"iPad" andImageName:@"AppleLogo.png"];
            Product *iPod = [[Product alloc]initWithName:@"iPod Touch" andImageName:@"AppleLogo.png"];
            Product *iPhone = [[Product alloc]initWithName:@"iPhone" andImageName:@"AppleLogo.png"];
            self.products = [[NSMutableArray alloc]initWithObjects:iPad,iPod,iPhone, nil];
        }
        
        
        else if ([self.title isEqualToString:@"Samsung mobile devices"]){
            Product *galaxyS4 = [[Product alloc]initWithName:@"Galaxy S4" andImageName:@"Samsung-Logo.jpg"];
            Product *galaxyNote = [[Product alloc]initWithName:@"Galaxy Note" andImageName:@"Samsung-Logo.jpg"];
            Product *galaxyTab = [[Product alloc]initWithName:@"Galaxy Tab" andImageName:@"Samsung-Logo.jpg"];
            self.products = [[NSMutableArray alloc]initWithObjects:galaxyS4,galaxyNote,galaxyTab, nil];
                                     }
        else if ([self.title isEqualToString:@"Blackberry mobile devices"]){
            Product *blackberryPassport = [[Product alloc]initWithName:@"Blackberry Passport" andImageName:@"blackberryLogo.jpg"];
            Product *blackberryPearl = [[Product alloc]initWithName:@"Blackberry Pearl" andImageName:@"blackberryLogo.jpg"];
            Product *blackberryZ30 = [[Product alloc]initWithName:@"Blackberry Z30" andImageName:@"blackberryLogo.jpg"];
            self.products = [[NSMutableArray alloc]initWithObjects:blackberryPassport,blackberryPearl,blackberryZ30, nil];
        }
        else if ([self.title isEqualToString:@"HTC mobile devices"]){
            Product *desire610 = [[Product alloc]initWithName:@"HTC Desire 610" andImageName:@"HTC-logo.png"];
            Product *one = [[Product alloc]initWithName:@"HTC One" andImageName:@"HTC-logo.png"];
            Product *desire816 = [[Product alloc]initWithName:@"HTC Desire 816" andImageName:@"HTC-logo.png"];
            self.products = [[NSMutableArray alloc]initWithObjects:desire610,one,desire816, nil];
        }*/
        
        
        
    }
    [self.tableView reloadData];
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
    return [self.products count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    
    Product *listOfProducts = [self.products objectAtIndex:
                           [indexPath row]];
    
    cell.textLabel.text = listOfProducts.name;
    cell.imageView.image = [UIImage imageNamed:listOfProducts.imageName];
    
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
        
        //if item/s are deleted, set button to 1.
        self.button = 1;
        // Delete the row from the data source
        [self.products removeObjectAtIndex:indexPath.row];
        DAO *dao = [DAO sharedCenter];
        [dao deleteProducts];
        
        
        
        
        

        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        [tableView reloadData];
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
    // Navigation logic may go here, for example:
    // Create the next view controller.
   // website *websiteForProducts = [[website alloc] initWithNibName:@"website" bundle:nil];
    
    // Pass the selected object to the new view controller.
    //UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    //websiteForProducts.title = cell.textLabel.text;
    
    // Create the next view controller.
    self.websiteVC = [[website alloc] init];
    
    Product *listOfProducts = [self.products objectAtIndex:[indexPath row]];
    self.websiteVC.webPages = listOfProducts.website;
    // Push the view controller.
    [self.navigationController pushViewController:self.websiteVC animated:YES];
    
}



@end
