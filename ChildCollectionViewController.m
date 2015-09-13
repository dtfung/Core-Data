//
//  ChildCollectionViewController.m
//  navctrl
//
//  Created by Donald Fung on 6/22/15.
//  Copyright (c) 2015 Donald Fung. All rights reserved.
//

#import "ChildCollectionViewController.h"

@interface ChildCollectionViewController ()

@end

@implementation ChildCollectionViewController

-(instancetype)init{
    //a concrete layout object that organizes items into a grid with an optional header and footer views.
    UICollectionViewFlowLayout *layout =[[UICollectionViewFlowLayout alloc]init];
    //sets the size of the cell
    layout.itemSize = CGSizeMake(106.0, 106.0);
    //the minimum spacing between items in the same row
    layout.minimumInteritemSpacing = .5;
    //the minimum spacing between items in the same column
    layout.minimumLineSpacing = .5;
    //initializes the collection view controller and configures the view with the layout.
    (self = [super initWithCollectionViewLayout:layout]);
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
   // self.title =
    // Register cell classes
    [self.collectionView registerClass:[ProductCell class] forCellWithReuseIdentifier:@"product"];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    // ATTACH LONG GESTURE TO THE COLLECTION VIEW
    // this is a subclass of UIGestureRecognizer.  The target is the object that the subclass acts upon.  The action is the selector that specifies which method will handle the gesture recognized by the receiver.
    UILongPressGestureRecognizer *lpgr
    = [[UILongPressGestureRecognizer alloc]
       initWithTarget:self action:@selector(handleLongPress:)];
    //the minimum period for the gesture to be recognized
    lpgr.minimumPressDuration = .5; //seconds
    //sets the delegate
    lpgr.delegate = self;
    //attach the gesture recognizer to the view
    [self.collectionView addGestureRecognizer:lpgr];

}
//a method to handle the gesture
-(void)handleLongPress:(UILongPressGestureRecognizer *)gestureRecognizer
{
    if (gestureRecognizer.state != UIGestureRecognizerStateEnded) {
        return;
    }
    
    //returns the coordinates of a single point in the veiw of a gesture
    CGPoint p = [gestureRecognizer locationInView:self.collectionView];
    //returns the index path made with p as a parameter
    NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:p];
    //checks if the user has clicked on an index path of an item
    if (indexPath == nil){
        NSLog(@"couldn't find index path");
    } else {
        
       
//        [self.appDelegate]
        // get the cell at indexPath (the one you long pressed and removes it from the row
        [self.products removeObjectAtIndex:indexPath.row];
        
        //delete item from the disk
        Product *selectedProduct = [self.products objectAtIndex:[indexPath row]];
        [[DAO sharedCenter] deleteProducts:selectedProduct.name];
        
        //reloads the data for the collection view
        [self.collectionView reloadData];
    }
}

-(NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.products.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    //returns a reusable cell object
    ProductCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"product" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor lightGrayColor];
    //access the products at a specific index path
    Product *product = [self.products objectAtIndex:
                               [indexPath row]];
    //sets the image of each cell in the collection view to the image of each product
    cell.productImage.image = [UIImage imageNamed:product.imageName];
    //sets the name of each cell in the collection view to the name of each product
    cell.productName.text = product.name;
    
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    //a new instance of the website class.
    self.websiteVC = [[website alloc] init];
    //access the products array baed on the index path selected
    Product *listOfProducts = [self.products objectAtIndex:[indexPath row]];
    //sets the url of the new instance equal to the website address for the particular product
    self.websiteVC.webPages = listOfProducts.website;
    // Push the view controller.
    [self.navigationController pushViewController:self.websiteVC animated:YES];

}



@end
