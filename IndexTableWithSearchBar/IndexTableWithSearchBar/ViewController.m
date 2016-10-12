//
//  ViewController.m
//  IndexTableWithSearchBar
//
//  Created by sri Divya on 12/10/16.
//  Copyright © 2016 MyCompanyName. All rights reserved.
//

#import "ViewController.h"
#import "ContainerCellView.h"
#import "ArticleFood.h"
#import "DetailsViewController.h"

@interface ViewController ()
{
        NSArray *content;
        NSArray *indices;
        NSMutableArray *glossaryListArray;
}
@property (weak, nonatomic) IBOutlet UISearchBar *indexSearchBar;
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UITableView *indextableView;

@property (strong, nonatomic) NSMutableArray* allTableData;
@property (strong, nonatomic) NSMutableDictionary* filteredTableData;
@property (nonatomic, strong) NSArray *indexArray;
@property (nonatomic, strong) NSArray *indexTitlesArray;
@property(nonatomic, retain) UIColor *sectionIndexColor;
@property (nonatomic, assign) bool isFiltered;
@property (strong, nonatomic) ContainerCellView *collectionView;
@property (strong, nonatomic) DetailsViewController *detailsViewController;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.indextableView.sectionIndexBackgroundColor = [UIColor redColor];
    self.indextableView.sectionIndexColor = [UIColor blueColor];
    self.indextableView.separatorColor=[UIColor clearColor];
    self.indextableView.sectionIndexTrackingBackgroundColor = [UIColor yellowColor];
    self.automaticallyAdjustsScrollViewInsets = YES;
    
    _collectionView = [[NSBundle mainBundle] loadNibNamed:@"ContainerCellView" owner:self options:nil][0];
    
    _collectionView.frame = self.containerView.bounds;
    
    [self.containerView addSubview:_collectionView];
    
    
    // Add observer that will allow the nested collection cell to trigger the view controller select row at index path
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didSelectItemFromCollectionView:) name:@"didSelectItemFromCollectionView" object:nil];
    
    self.indexSearchBar.delegate = (id)self;
    
    self.allTableData = [[NSMutableArray alloc] initWithObjects:
                    [[ArticleFood alloc] initWithName:@"Steak" andDescription:@"Rare"],
                    [[ArticleFood alloc] initWithName:@"Steak" andDescription:@"Medium"],
                    [[ArticleFood alloc] initWithName:@"Salad" andDescription:@"Caesar"],
                    [[ArticleFood alloc] initWithName:@"Salad" andDescription:@"Bean"],
                    [[ArticleFood alloc] initWithName:@"Fruit" andDescription:@"Apple"],
                    [[ArticleFood alloc] initWithName:@"Potato" andDescription:@"Baked"],
                    [[ArticleFood alloc] initWithName:@"Potato" andDescription:@"Mashed"],
                    [[ArticleFood alloc] initWithName:@"Bread" andDescription:@"White"],
                    [[ArticleFood alloc] initWithName:@"Bread" andDescription:@"Brown"],
                    [[ArticleFood alloc] initWithName:@"Hot Dog" andDescription:@"Beef"],
                    [[ArticleFood alloc] initWithName:@"Hot Dog" andDescription:@"Chicken"],
                    [[ArticleFood alloc] initWithName:@"Hot Dog" andDescription:@"Veggie"],
                    [[ArticleFood alloc] initWithName:@"Pizza" andDescription:@"Pepperonni"],
                    nil ];
    glossaryListArray=[[NSMutableArray alloc]init];
    
    [glossaryListArray addObjectsFromArray:self.allTableData];
    
    [self updateTableData:@""];
    
}

- (void)viewDidUnload
{
    [self.indexSearchBar resignFirstResponder];
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.indexArray count];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    NSString* letter = [self.indexArray objectAtIndex:section];
    NSArray* arrayForLetter = (NSArray*)[self.filteredTableData objectForKey:letter];
    NSLog(@"%@",letter);
    return arrayForLetter.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    
    ArticleFood *food;
    NSString* letter = [self.indexArray objectAtIndex:indexPath.section];
    NSArray* arrayForLetter = (NSArray*)[self.filteredTableData objectForKey:letter];
    food = [arrayForLetter objectAtIndex:indexPath.row];
    cell.textLabel.text = food.name;
    return cell;
    
}

#pragma mark - Table view delegate


//For showing side index bar
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    
    return self.indexArray;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    return 44;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 0;
}
//Setting Title Index for searchDisplayController
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    //    return [self.indexArray objectAtIndex:section];
    return nil;
}
-(void) searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    [self updateTableData:searchText];
}

-(void)updateTableData:(NSString*)searchString
{
    
    self.filteredTableData = [[NSMutableDictionary alloc] init];
    
    for (ArticleFood *foodObj in glossaryListArray)
    {
        bool isMatch = false;
        if(searchString.length == 0)
        {
            // If our search string is empty, everything is a match
            isMatch = true;
        }
        else
        {
            
            // If we have a search string, check to see if it matches the food's name or description
            
            NSRange nameRange = [foodObj.name rangeOfString:searchString options:(NSAnchoredSearch|NSCaseInsensitiveSearch)];
            NSLog(@"This is it: %@",foodObj.name);
            
            
            if(nameRange.location != NSNotFound)
                
                isMatch = true;
        }
        
        
        // If we have a match...
        if(isMatch)
        {
            // Find the first letter of the food's name. This will be its gropu
            NSString* firstLetter = [foodObj.name substringToIndex:1];
            
            NSLog(@"This is it: %@",firstLetter);
            
            // Check to see if we already have an array for this group
            NSMutableArray* arrayForLetter = (NSMutableArray*)[self.filteredTableData objectForKey:firstLetter];
            if(arrayForLetter == nil)
            {
                // If we don't, create one, and add it to our dictionary
                arrayForLetter = [[NSMutableArray alloc] init];
                [self.filteredTableData setValue:arrayForLetter forKey:firstLetter];
                NSLog(@"This is it: %@",self.filteredTableData);
            }
            
            // Finally, add the food to this group's array
            [arrayForLetter addObject:foodObj];
        }
    }
    
    // Make a copy of our dictionary's keys, and sort them
    self.indexArray = [[self.filteredTableData allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    
    
    //For collectionView data
    NSMutableArray *collectionArray = [[NSMutableArray alloc]initWithArray:@[ @{ @"title": @"A- A1" },
                                                                              @{ @"title": @"A- A2" },
                                                                              @{ @"title": @"A- A3" },
                                                                              @{ @"title": @"A- A4" },
                                                                              @{ @"title": @"A- A5" }
                                                                              ]];
    NSMutableArray *temporaryArray = [NSMutableArray new];
    
    [temporaryArray addObject:[NSArray arrayWithArray:[collectionArray copy]]];
    
    self.indexTitlesArray = [NSArray arrayWithArray:[temporaryArray copy]];
    
    [_collectionView setCollectionData:[collectionArray copy]];
    
    
    NSLog(@"Self.indexArray %@",self.indexArray);
    // Finally, refresh the table
    [self.indextableView reloadData];
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)asearchBar
{
    [self.indexSearchBar resignFirstResponder];
    
    
}
- (void)searchBarCancelButtonClicked:(UISearchBar *)asearchBar
{
    self.indexSearchBar.hidden=YES;
    [self.indexSearchBar resignFirstResponder];
    [self updateTableData:@""];
}
- (void) didSelectItemFromCollectionView:(NSNotification *)notification
{
    NSDictionary *cellData = [notification object];
    if (cellData) {
        NSLog(@"TappedCollectionItem %@",cellData[@"title"]);
        if (!self.detailsViewController)
        {
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:
                                        @"Main" bundle:nil];
            self.detailsViewController = [storyboard instantiateViewControllerWithIdentifier:@"DetailsViewController"];
        }
        
        self.detailsViewController.foodTitle = cellData[@"title"];
        [self.navigationController pushViewController:self.detailsViewController animated:YES];

    }
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"didSelectItemFromCollectionView" object:nil];
}


@end
