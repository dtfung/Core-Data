//
//  DAO.m
//  navctrl
//
//  Created by Donald Fung on 6/8/15.
//  Copyright (c) 2015 Donald Fung. All rights reserved.
//

#import "DAO.h"
#import "ChildViewController.h"
#import "qcdDemoViewController.h"

#import "sqlite3.h"


//Core Data is an object graph and persistence framework provided by Apple in the Mac OS X and IOS operating systems.
//
//Core data isn't a database but a way of persisting changes to a persistent store .
//Data is stored in a persistent store (typically a SQLite Database) and is retrieved/fetched via the Persistent Store Coordinator .
//A Model is the schema and manages all the attributes and relationships of the entities.
////A managed object context manages each Managed Objects.


@implementation DAO

//create singleton
static DAO *sharedDAOCenter = nil;

+ (DAO *)sharedCenter {
    
    //check if instance exists.  If not, then create instance of DAO.
    if (sharedDAOCenter == nil) {
        //returns a new instance of the class.
        sharedDAOCenter = [[super allocWithZone:NULL] init];
    }
    return sharedDAOCenter;
}

//initialize new object after memory has been allocated
-(instancetype) init {
    if (self = [super init]) {
        //a reference to the app delegate
        _appDelegate = [[UIApplication sharedApplication]delegate];
        
        // see if we have records
        [self loadAllCompanies];
        
        //if records don't exist, then call the following methods to create NSManagedObjects and Send off fetch requests
        if(self.listCompanies.count == 0) {
            [self getCompanyInformation];
            [self loadAllCompanies];
        }

        return self;
    }
    else return nil;
}


//a method to create Managed Objects for each Entity, Managed Company and Managed Products.
- (void)getCompanyInformation {
    
    //Create new instance of an Entity called ManagedCompany
    NSEntityDescription *ManagedCompany = [NSEntityDescription entityForName:@"ManagedCompany" inManagedObjectContext:self.appDelegate.managedObjectContext];
    //Create Managed Object instances assigned to the ManagedCompany entity
    NSManagedObject *apple = [[NSManagedObject alloc] initWithEntity:ManagedCompany insertIntoManagedObjectContext:self.appDelegate.managedObjectContext];
    NSManagedObject *blu = [[NSManagedObject alloc] initWithEntity:ManagedCompany insertIntoManagedObjectContext:self.appDelegate.managedObjectContext];
    NSManagedObject *blackberry = [[NSManagedObject alloc] initWithEntity:ManagedCompany insertIntoManagedObjectContext:self.appDelegate.managedObjectContext];
    NSManagedObject *google = [[NSManagedObject alloc] initWithEntity:ManagedCompany insertIntoManagedObjectContext:self.appDelegate.managedObjectContext];
    
    //set attributes for each Managed Object
    [apple setValue:@"Apple Mobile Devices" forKey:@"name"];
    [apple setValue:@"AppleLogo.png" forKey:@"imageName"];
    [apple setValue:@"1" forKey:@"companyID"];
    [apple setValue:@"AAPL" forKey:@"stockPrice"];
    
    [blu setValue:@"Blu Mobile Devices" forKey:@"name"];
    [blu setValue:@"BluLogo.png" forKey:@"imageName"];
    [blu setValue:@"2" forKey:@"companyID"];
    [blu setValue:@"BLUE" forKey:@"stockPrice"];
    
    [blackberry setValue:@"Blackberry Mobile Devices" forKey:@"name"];
    [blackberry setValue:@"blackberryLogo.jpg" forKey:@"imageName"];
    [blackberry setValue:@"3" forKey:@"companyID"];
    [blackberry setValue:@"BBRY" forKey:@"stockPrice"];
    
    [google setValue:@"Google Mobile Devices" forKey:@"name"];
    [google setValue:@"googleLogo.png" forKey:@"imageName"];
    [google setValue:@"4" forKey:@"companyID"];
    [google setValue:@"GOOG" forKey:@"stockPrice"];
    
    
    NSEntityDescription *ManagedProduct = [NSEntityDescription entityForName:@"ManagedProduct" inManagedObjectContext:self.appDelegate.managedObjectContext];
    NSManagedObject *iPad = [[NSManagedObject alloc] initWithEntity:ManagedProduct insertIntoManagedObjectContext:self.appDelegate.managedObjectContext];
    [iPad setValue:@"iPad" forKey:@"name"];
    [iPad setValue:@"AppleLogo.png" forKey:@"imageName"];
    [iPad setValue:@"http://www.apple.com/ipad" forKey:@"website"];
    [iPad setValue:@"1" forKey:@"companyID"];
    
    NSManagedObject *iPod = [[NSManagedObject alloc] initWithEntity:ManagedProduct insertIntoManagedObjectContext:self.appDelegate.managedObjectContext];
    [iPod setValue:@"iPod" forKey:@"name"];
    [iPod setValue:@"AppleLogo.png" forKey:@"imageName"];
    [iPod setValue:@"https://www.apple.com/ipod-touch" forKey:@"website"];
    [iPod setValue:@"1" forKey:@"companyID"];
    
    NSManagedObject *iPhone = [[NSManagedObject alloc] initWithEntity:ManagedProduct insertIntoManagedObjectContext:self.appDelegate.managedObjectContext];
    [iPhone setValue:@"iPhone" forKey:@"name"];
    [iPhone setValue:@"AppleLogo.png" forKey:@"imageName"];
    [iPhone setValue:@"https://www.apple.com/ipod-touch" forKey:@"website"];
    [iPhone setValue:@"1" forKey:@"companyID"];
    //apple. = [[NSMutableArray alloc]initWithObjects:iPad,iPod,iPhone, nil];
    
    NSManagedObject *dashCMusic = [[NSManagedObject alloc] initWithEntity:ManagedProduct insertIntoManagedObjectContext:self.appDelegate.managedObjectContext];
    [dashCMusic setValue:@"dashCMusic" forKey:@"name"];
    [dashCMusic setValue:@"BluLogo.png" forKey:@"imageName"];
    [dashCMusic setValue:@"http://www.bluproducts.com/index.php/dash-c-music" forKey:@"website"];
    [dashCMusic setValue:@"2" forKey:@"companyID"];
    
    NSManagedObject *dashMusicJR = [[NSManagedObject alloc] initWithEntity:ManagedProduct insertIntoManagedObjectContext:self.appDelegate.managedObjectContext];
    [dashMusicJR setValue:@"DashMusicJR" forKey:@"name"];
    [dashMusicJR setValue:@"BluLogo.png" forKey:@"imageName"];
    [dashMusicJR setValue:@"http://www.bluproducts.com/index.php/dash-c-music" forKey:@"website"];
    [dashMusicJR setValue:@"2" forKey:@"companyID"];
    
    NSManagedObject *dashJR = [[NSManagedObject alloc] initWithEntity:ManagedProduct insertIntoManagedObjectContext:self.appDelegate.managedObjectContext];
    [dashJR setValue:@"DashJR" forKey:@"name"];
    [dashJR setValue:@"BluLogo.png" forKey:@"imageName"];
    [dashJR setValue:@"http://www.bluproducts.com/index.php/dash-c-music" forKey:@"website"];
    [dashJR setValue:@"2" forKey:@"companyID"];
    
    NSManagedObject *blackberryPassport = [[NSManagedObject alloc] initWithEntity:ManagedProduct insertIntoManagedObjectContext:self.appDelegate.managedObjectContext];
    [blackberryPassport setValue:@"Passport" forKey:@"name"];
    [blackberryPassport setValue:@"blackberryLogo.jpg" forKey:@"imageName"];
    [blackberryPassport setValue:@"http://us.blackberry.com/smartphones/blackberry-passport/overview.html" forKey:@"website"];
    [blackberryPassport setValue:@"3" forKey:@"companyID"];
    
    NSManagedObject *blackberryPearl = [[NSManagedObject alloc] initWithEntity:ManagedProduct insertIntoManagedObjectContext:self.appDelegate.managedObjectContext];
    [blackberryPearl setValue:@"Pearl" forKey:@"name"];
    [blackberryPearl setValue:@"blackberryLogo.jpg" forKey:@"imageName"];
    [blackberryPearl setValue:@"http://us.blackberry.com/smartphones/blackberry-passport/overview.html" forKey:@"website"];
    [blackberryPearl setValue:@"3" forKey:@"companyID"];
    
    NSManagedObject *BlackberryZ30 = [[NSManagedObject alloc] initWithEntity:ManagedProduct insertIntoManagedObjectContext:self.appDelegate.managedObjectContext];
    [BlackberryZ30 setValue:@"Z30" forKey:@"name"];
    [BlackberryZ30 setValue:@"blackberryLogo.jpg" forKey:@"imageName"];
    [BlackberryZ30 setValue:@"http://us.blackberry.com/smartphones/blackberry-passport/overview.html" forKey:@"website"];
    [BlackberryZ30 setValue:@"3" forKey:@"companyID"];
    
    NSManagedObject *Nexus9 = [[NSManagedObject alloc] initWithEntity:ManagedProduct insertIntoManagedObjectContext:self.appDelegate.managedObjectContext];
    [Nexus9 setValue:@"Nexus9" forKey:@"name"];
    [Nexus9 setValue:@"googleLogo.png" forKey:@"imageName"];
    [Nexus9 setValue:@"http://www.google.com/nexus/9/" forKey:@"website"];
    [Nexus9 setValue:@"4" forKey:@"companyID"];
    
    NSManagedObject *Nexus6 = [[NSManagedObject alloc] initWithEntity:ManagedProduct insertIntoManagedObjectContext:self.appDelegate.managedObjectContext];
    [Nexus6 setValue:@"Nexus6" forKey:@"name"];
    [Nexus6 setValue:@"googleLogo.png" forKey:@"imageName"];
    [Nexus6 setValue:@"http://www.google.com/nexus/9/" forKey:@"website"];
    [Nexus6 setValue:@"4" forKey:@"companyID"];
    
    NSManagedObject *Nexus5 = [[NSManagedObject alloc] initWithEntity:ManagedProduct insertIntoManagedObjectContext:self.appDelegate.managedObjectContext];
    [Nexus5 setValue:@"Nexus5" forKey:@"name"];
    [Nexus5 setValue:@"googleLogo.png" forKey:@"imageName"];
    [Nexus5 setValue:@"http://www.google.com/nexus/9/" forKey:@"website"];
    [Nexus5 setValue:@"4" forKey:@"companyID"];
    
    //self.listProducts = [[NSMutableArray alloc]initWithObjects:iPad,iPod,iPhone,dashCMusic,dashJR,dashMusicJR,blackberryPassport,blackberryPearl,BlackberryZ30,Nexus9,Nexus6,Nexus5, nil];
    
    
    
    /*
     Company *apple = [[Company alloc] init];
     apple.name = @"Apple mobile devices";
     apple.imageName = @"AppleLogo.png";
     Product *iPad = [[Product alloc]initWithName:@"iPad" andImageName:@"AppleLogo.png" andWebsite:@"http://www.apple.com/ipad"];
     Product *iPod = [[Product alloc]initWithName:@"iPod Touch" andImageName:@"AppleLogo.png" andWebsite:@"https://www.apple.com/ipod-touch"];
     Product *iPhone = [[Product alloc]initWithName:@"iPhone" andImageName:@"AppleLogo.png" andWebsite:@"http://www.apple.com/iphone"];
     apple.products = [[NSMutableArray alloc]initWithObjects:iPad,iPod,iPhone, nil];
     
     Company *blu = [[Company alloc] init];
     blu.name = @"Blu mobile devices";
     blu.imageName = @"BluLogo.png";
     Product *dashCMusic = [[Product alloc]initWithName:@"Dash C Music" andImageName:@"BluLogo.png" andWebsite:@"http://www.bluproducts.com/index.php/dash-c-music"];
     Product *dashMusicJR = [[Product alloc]initWithName:@"Dash Music JR" andImageName:@"BluLogo.png" andWebsite:@"http://www.bluproducts.com/index.php/dash-music-jr"];
     Product *dashJR = [[Product alloc]initWithName:@"Dash JR" andImageName:@"BluLogo.png" andWebsite:@"http://www.bluproducts.com/index.php/dash-jr"];
     blu.products = [[NSMutableArray alloc]initWithObjects:dashCMusic,dashMusicJR,dashJR, nil];
     
     Company *blackberry = [[Company alloc] init];
     blackberry.name = @"Blackberry mobile devices";
     blackberry.imageName = @"blackberryLogo.jpg";
     Product *blackberryPassport = [[Product alloc]initWithName:@"Blackberry Passport" andImageName:@"blackberryLogo.jpg" andWebsite:@"http://us.blackberry.com/smartphones/blackberry-passport/overview.html"];
     Product *blackberryPearl = [[Product alloc]initWithName:@"Blackberry Pearl" andImageName:@"blackberryLogo.jpg" andWebsite:@"http://worldwide.blackberry.com/blackberrypearl/"];
     Product *blackberryZ30 = [[Product alloc]initWithName:@"Blackberry Z30" andImageName:@"blackberryLogo.jpg" andWebsite:@"http://us.blackberry.com/smartphones/blackberry-z30.html"];
     blackberry.products = [[NSMutableArray alloc]initWithObjects:blackberryPassport,blackberryPearl,blackberryZ30, nil];
     
     
     Company *google = [[Company alloc] init];
     google.name = @"Google Nexus mobile devices";
     google.imageName = @"googleLogo.png";
     Product *nexus9 = [[Product alloc]initWithName:@"Nexus 9" andImageName:@"googleLogo.png" andWebsite:@"http://www.google.com/nexus/9/"];
     Product *nexus6 = [[Product alloc]initWithName:@"Nexus 6" andImageName:@"googleLogo.png" andWebsite:@"http://www.google.com/nexus/6/"];
     Product *nexus5 = [[Product alloc]initWithName:@"Nexus 5" andImageName:@"googleLogo.png" andWebsite:@"http://www.google.com/nexus/5/"];
     google.products = [[NSMutableArray alloc]initWithObjects:nexus9,nexus6,nexus5, nil];
     
     self.listCompanies = [[NSMutableArray alloc]initWithObjects:apple,blu,blackberry, google, nil];
     */
    //save changes to Persistent Store
    [self saveChanges];
}

//Retrieve data from Persistent Store
-(void)loadAllCompanies{

        self.listCompanies = [[NSMutableArray alloc]init];
        
        NSFetchRequest *request = [[NSFetchRequest alloc]init];
        //NSPredicate *p = [NSPredicate predicateWithFormat:@"emp_id >1"];
        //[request setPredicate:p];
        NSEntityDescription *e = [[self.appDelegate.managedObjectModel entitiesByName] objectForKey:@"ManagedCompany"];
        [request setEntity:e];
        NSError *error = nil;
        //an array containing the requested Managed Objects
        NSArray *result = [self.appDelegate.managedObjectContext executeFetchRequest:request error:&error];
        if(!result){
            [NSException raise:@"Fetch Failed" format:@"Reason: %@", [error localizedDescription]];
        }
        else  {
            //Loop through the array of managed objects to create NSObjects for each Managed Object.
            for(ManagedCompany *mc in result){
                Company *newCompany = [[Company alloc] init];
                //set the properties of each instance of the Company class equal to the the respective attribute of the Entity.
                [newCompany setCompanyID:mc.companyID];
                [newCompany setName:mc.name];
                [newCompany setImageName:mc.imageName];
                [newCompany setProducts:[[NSMutableArray alloc]init]];
                [newCompany setStockPrice:mc.stockPrice];
                [self.listCompanies addObject:newCompany];
            }
        }
        
        
        //Send another fetch request for products.
        NSFetchRequest *productRequest = [[NSFetchRequest alloc]init];
        NSEntityDescription *entityForProduct = [[self.appDelegate.managedObjectModel entitiesByName] objectForKey:@"ManagedProduct"];
        [productRequest setEntity:entityForProduct];
        NSError *errorForProductFetch = nil;
        NSArray *resultForProduct = [self.appDelegate.managedObjectContext executeFetchRequest:productRequest error:&errorForProductFetch];
        if (!resultForProduct) {
            [NSException raise:@"Fetch Failed" format:@"Reason: %@", [error localizedDescription]];
        }
        else {
            for (Company *aCompany in self.listCompanies) {
                for (ManagedProduct *mp in resultForProduct) {
                    Product *newProduct = [[Product alloc]init];
                    [newProduct setCompanyID:mp.companyID];
                    [newProduct setName:mp.name];
                    [newProduct setImageName:mp.imageName];
                    [newProduct setWebsite:mp.website];
                    
                    
                    //assign each product to their respective company based on companyID's
                    if ([aCompany.companyID isEqualToString:newProduct.companyID]) {
                        [aCompany.products addObject:newProduct];
                    }
                }
            }
        }
    
}

-(void)saveChanges
{
    NSError *err = nil;
    BOOL successful = [self.appDelegate.managedObjectContext save:&err];
    if(!successful){
        NSLog(@"Error saving: %@", [err localizedDescription]);
    }
    NSLog(@"Data Saved");
}

//handle deletion persistence
-(void)deleteProducts:(NSString *)productName {
    NSFetchRequest *productRequest = [[NSFetchRequest alloc]init];
    NSEntityDescription *entityForProduct = [[self.appDelegate.managedObjectModel entitiesByName] objectForKey:@"ManagedProduct"];
    //NSPredicate *p = [NSPredicate predicateWithFormat:@"name == %@", deleteProduct];
    //[productRequest setPredicate:p];
    [productRequest setEntity:entityForProduct];
    NSError *errorForProductFetch = nil;
    NSArray *resultForProduct = [self.appDelegate.managedObjectContext executeFetchRequest:productRequest error:&errorForProductFetch];
    if (!resultForProduct) {
        [NSException raise:@"Fetch Failed" format:@"Reason: %@", [errorForProductFetch localizedDescription]];
    }
    else {
        for (ManagedProduct *product in resultForProduct) {
            if ([productName isEqualToString: product.name]) {
                //delete selected product
                [self.appDelegate.managedObjectContext deleteObject: product];
                 NSLog(@"%@ got deleted, mon",product.name);
                
                //Break out of loop here...
            }
        }
        [self saveChanges];
    }
}

// singleton methods
+ (id)allocWithZone:(NSZone *)zone {
    return [[self sharedCenter] retain];
}

- (id)copyWithZone:(NSZone *)zone {
    return self;
}

- (id)retain {
    return self;
}

- (NSUInteger)retainCount {
    return NSUIntegerMax;  // denotes an object that cannot be released
}

//- (void)release {
//    // do nothing - we aren't releasing the singleton object.
//}

- (id)autorelease {
    return self;
}

-(void)dealloc {
    [super dealloc];
}
@end


